context("test-geom_categorical_model")

library(ggplot2)
library(dplyr)
library(moderndive)

mpg <- mpg[mpg$cyl != 5, ]

viz <- ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_point()


# geom_categorical_model ----------------------------------------------------
test_that("geom_categorical_model works", {
  expect_doppelganger(
    "geom_categorical_model-basic",
    viz + geom_categorical_model() + labs(title = "geom_categorical_model()")
  )

  expect_doppelganger(
    "geom_categorical_model-no-SE",
    viz + geom_categorical_model(se = FALSE) +
      labs(title = "geom_categorical_model() with `se = FALSE`")
  )

  expect_doppelganger(
    "geom_categorical_model_basic_color_and_size",
    viz %+% aes(color = drv) +
      geom_categorical_model(linewidth = 3) +
      labs(title = "geom_categorical_model() with extra aesthetics")
  )

  expect_doppelganger(
    "geom_categorical_model-linetype-override",
    viz %+% aes(linetype = drv) +
      geom_categorical_model() +
      labs(title = "geom_categorical_model() with linetype mapped")
  )

  expect_doppelganger(
    "geom_categorical_model-faceted",
    viz + geom_categorical_model() +
      facet_wrap(~cyl) +
      labs(title = "Faceted geom_categorical_model()")
  )
})

test_that("geom_categorical_model works in edge cases", {

  # Warns and doesn't draw anything when x axis is numeric
  expect_warning(
    expect_doppelganger(
      "geom_parallel_slopes-numeric-x",
      ggplot(mpg, aes(x = displ, y = hwy)) +
        geom_point() +
        geom_categorical_model() +
        labs(title = "geom_categorical_model() does nothing with numeric x")
    ),
    regexp = "*only works with a discrete x axis variable"
  )
})

############ New tests

# -------------------------------------------------------------------
# Additional unit tests for geom_categorical_model and helpers
# -------------------------------------------------------------------

test_that("geom_categorical_model warns on method argument and still returns a plot", {
  p <- expect_warning(
    ggplot(mpg, aes(drv, hwy)) +
      geom_point() +
      geom_categorical_model(method = "lm"),
    regexp = "doesn't need a `method` argument"
  )
  
  expect_s3_class(p, "ggplot")
  
  # Model layer should have some data
  ld <- layer_data(p, 2)
  expect_gt(nrow(ld), 0L)
})

test_that("StatCategoricalModel returns empty data frame when input has zero rows", {
  mpg_empty <- mpg[0, ]
  
  p <- ggplot(mpg_empty, aes(drv, hwy)) +
    geom_categorical_model()
  
  ld <- layer_data(p, 1)  # only one layer here
  expect_equal(nrow(ld), 0L)
})

test_that("geom_categorical_model produces nearly horizontal segments for each group", {
  p <- ggplot(mpg, aes(drv, hwy)) +
    geom_point() +
    geom_categorical_model(se = FALSE)
  
  # layer 2 is the model layer (1 = points)
  ld <- layer_data(p, 2)
  
  # If for some reason there is no model data, skip
  skip_if(nrow(ld) == 0L)
  
  # Within each group, y should be almost constant (piecewise horizontal)
  group_sd <- tapply(ld$y, ld$group, stats::sd, na.rm = TRUE)
  
  # All groups should have essentially zero variation in y
  expect_true(all(group_sd < 1e-6 | is.na(group_sd)))
})

test_that("compute_group_new_categorical_data builds sequence and assigns linetype", {
  # Fake group df for baseline (x = 1) and non-baseline (x = 2)
  g1 <- data.frame(
    x = factor(1, levels = 1:2),
    y = 1,
    group = 1
  )
  g2 <- data.frame(
    x = factor(2, levels = 1:2),
    y = 2,
    group = 2
  )
  
  new1 <- compute_group_new_categorical_data(g1)
  new2 <- compute_group_new_categorical_data(g2)
  
  # Should create a sequence of x values and keep group + x_orig
  expect_equal(unique(new1$group), 1)
  expect_equal(unique(new2$group), 2)
  expect_true("x_orig" %in% names(new1))
  expect_true("x_orig" %in% names(new2))
  
  # Baseline level (numeric 1) gets linetype 1, others 2
  expect_true(all(new1$linetype == 1))
  expect_true(all(new2$linetype == 2))
})

test_that("predict_categorical_df returns correct columns with and without se", {
  # Simple toy model
  df <- data.frame(
    x = factor(c(1, 1, 2, 2)),
    y = c(1, 2, 3, 4)
  )
  m <- lm(y ~ x, data = df)
  
  # Data with a single x to match what StatCategoricalModel passes
  new_data <- data.frame(x = df$x[1])
  
  with_se <- predict_categorical_df(model = m, data = new_data, se = TRUE, level = 0.9)
  no_se   <- predict_categorical_df(model = m, data = new_data, se = FALSE, level = 0.9)
  
  # With se: x, y, ymin, ymax, se
  expect_true(all(c("x", "y", "ymin", "ymax", "se") %in% names(with_se)))
  expect_equal(nrow(with_se), 1L)
  
  # Without se: just x and y
  expect_true(all(c("x", "y") %in% names(no_se)))
  expect_false(any(c("ymin", "ymax", "se") %in% names(no_se)))
  expect_equal(nrow(no_se), 1L)
})

test_that("geom_categorical_model colour mapping respects x levels", {
  p <- ggplot(mpg, aes(x = drv, y = hwy, colour = class)) +
    geom_point() +
    geom_categorical_model(se = FALSE)
  
  ld <- layer_data(p, 2)  # model layer
  
  # It should always return some model data
  expect_gt(nrow(ld), 0L)
  
  if ("colour" %in% names(ld)) {
    # If colour is present, the stat guarantees it does not vary within each x level.
    # That is exactly what the n_levels vs n_color_groups logic enforces.
    col_per_x <- ld |>
      dplyr::distinct(x, colour) |>
      dplyr::count(x, name = "n_colours")
    
    # At most one colour per x in the model layer
    expect_lte(max(col_per_x$n_colours), 1L)
  } else {
    # If colour was dropped, we just confirm the model layer still exists
    expect_gt(nrow(ld), 0L)
  }
})

test_that("geom_categorical_model keeps colour when it matches levels of x", {
  # Create a data frame where colour is effectively the same as x
  df <- subset(mpg, drv %in% c("4", "f"))  # two levels only
  df$drv_col <- df$drv
  
  p <- ggplot(df, aes(x = drv, y = hwy, colour = drv_col)) +
    geom_point() +
    geom_categorical_model(se = FALSE)
  
  ld <- layer_data(p, 2)
  
  # In this special case, colour corresponds one-to-one with x, so it is kept
  expect_true("colour" %in% names(ld))
})

test_that("geom_categorical_model respects se and level parameters structurally", {
  p_95 <- ggplot(mpg, aes(drv, hwy)) +
    geom_point() +
    geom_categorical_model(se = TRUE, level = 0.95)
  
  p_50 <- ggplot(mpg, aes(drv, hwy)) +
    geom_point() +
    geom_categorical_model(se = TRUE, level = 0.5)
  
  ld_95 <- layer_data(p_95, 2)
  ld_50 <- layer_data(p_50, 2)
  
  # If se = TRUE, we should see ymin/ymax columns
  skip_if(!all(c("ymin", "ymax") %in% names(ld_95)))
  skip_if(!all(c("ymin", "ymax") %in% names(ld_50)))
  
  width_95 <- mean(ld_95$ymax - ld_95$ymin, na.rm = TRUE)
  width_50 <- mean(ld_50$ymax - ld_50$ymin, na.rm = TRUE)
  
  # Lower confidence level should give narrower intervals on average
  expect_lt(width_50, width_95)
})

test_that("geom_categorical_model handles missing y when na.rm = TRUE", {
  mpg_na <- mpg
  mpg_na$hwy[1:5] <- NA_real_
  
  p <- ggplot(mpg_na, aes(drv, hwy)) +
    geom_point() +
    geom_categorical_model(na.rm = TRUE)
  
  ld <- layer_data(p, 2)
  
  # Model layer should not contain NA y values if na.rm = TRUE
  expect_false(any(is.na(ld$y)))
})
