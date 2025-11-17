context("test-geom_parallel_slopes")

library(ggplot2)


# Helper data -------------------------------------------------------------
set.seed(202)
test_df <- dplyr::bind_rows(
  tibble::tibble(a = runif(10, 0, 0.1), gr = 1),
  tibble::tibble(a = runif(15, 0.1, 0.3), gr = 2),
  tibble::tibble(a = runif(20, 0.4, 1), gr = 3)
) %>%
  dplyr::mutate(
    pan = factor(sample(1:3, dplyr::n(), replace = TRUE)),
    gr = factor(gr),
    # Slope depends on panel, intercept on group
    b = as.integer(pan) * a + as.integer(gr) + runif(dplyr::n(), max = 0.1),
    # Quadratic curves
    c = as.integer(pan) * a^2 + as.integer(gr) + runif(dplyr::n(), max = 0.1),
  )

viz <- ggplot(test_df, aes(a, b, colour = gr)) +
  geom_point()


# geom_parallel_slopes ----------------------------------------------------
test_that("geom_parallel_slopes works", {
  expect_doppelganger(
    "geom_parallel_slopes-basic-1",
    viz + geom_parallel_slopes() + labs(title = "geom_parallel_slopes()")
  )

  expect_doppelganger(
    "geom_parallel_slopes-basic-2",
    viz + geom_parallel_slopes(se = FALSE) +
      labs(title = "geom_parallel_slopes() with `se = FALSE`")
  )

  expect_doppelganger(
    "geom_parallel_slopes-basic-3",
    viz +
      geom_parallel_slopes(
        mapping = aes(group = gr), color = "red", linewidth = 3
      ) +
      labs(title = "geom_parallel_slopes() with extra aesthetics")
  )

  expect_doppelganger(
    "geom_parallel_slopes-basic-4",
    ggplot(test_df, aes(a, c, colour = gr)) +
      geom_point() +
      geom_parallel_slopes(formula = y ~ poly(x, 2)) +
      labs(title = "Quadratic geom_parallel_slopes()")
  )

  expect_doppelganger(
    "geom_parallel_slopes-basic-5",
    viz + geom_parallel_slopes() +
      facet_wrap(~pan) +
      labs(title = "Faceted geom_parallel_slopes()")
  )

  expect_doppelganger(
    "geom_parallel_slopes-basic-6",
    ggplot(test_df, aes(a, b)) +
      geom_point() +
      geom_parallel_slopes(aes(group = gr)) +
      labs(title = "geom_parallel_slopes() with `group` aesthetics grouping")
  )

  expect_doppelganger(
    "geom_parallel_slopes-basic-7",
    ggplot(test_df, aes(a, b)) +
      geom_point() +
      geom_parallel_slopes(aes(fill = gr)) +
      labs(title = "geom_parallel_slopes() with `fill` aesthetics grouping")
  )

  expect_doppelganger(
    "geom_parallel_slopes-fullrange",
    viz + geom_parallel_slopes(fullrange = TRUE) +
      xlim(c(-1, 2)) +
      labs(title = "geom_parallel_slopes() with fullrange=TRUE")
  )

  expect_doppelganger(
    "geom_parallel_slopes-level",
    viz + geom_parallel_slopes(level = 0.25) +
      labs(title = "geom_parallel_slopes() with level=0.25")
  )
})

test_that("geom_parallel_slopes works in edge cases", {
  # Non-factor grouping
  expect_doppelganger(
    "geom_parallel_slopes-non-factor-grouping",
    test_df %>%
      dplyr::mutate(gr = as.integer(gr)) %>%
      ggplot(aes(a, b, colour = gr, group = gr)) +
      geom_point() +
      geom_parallel_slopes() +
      labs(title = "Works with non-factor grouping")
  )

  # Works without grouping variable. Should give warning
  expect_warning(
    expect_doppelganger(
      "geom_parallel_slopes-edge-no-grouping",
      ggplot(test_df, aes(a, b)) +
        geom_point() +
        geom_parallel_slopes() +
        labs(title = "Works without grouping")
    ),
    regexp = "grouping"
  )

  # Works with grouping variable that has one unique value. Should give warning
  expect_warning(
    expect_doppelganger(
      "geom_parallel_slopes-edge-unique-grouping",
      test_df %>%
        dplyr::mutate(gr = 1) %>%
        ggplot(aes(a, b, group = gr)) +
        geom_point() +
        geom_parallel_slopes() +
        labs(title = "Works with grouping variable with one value")
    ),
    regexp = "grouping.*unique"
  )

  # Gives a custom warning when supplied `method` argument
  expect_warning(
    expect_doppelganger(
      "geom_parallel_slopes-edge-method-arg",
      viz + geom_parallel_slopes(method = "lm") +
        labs(title = "geom_parallel_slopes() with `method` supplied")
    ),
    regexp = "doesn't need a `method`"
  )
})

test_that("gg_parallel_slopes returns ggplot and warns about deprecation", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("dplyr")
  skip_if_not_installed("moderndive")
  
  data("house_prices", package = "moderndive")
  
  # Create transformed variables as in the examples
  hp_small <- dplyr::mutate(
    house_prices,
    log10_price = log10(price),
    log10_size  = log10(sqft_living)
  )[1:200, ]
  
  # Capture both the deprecation warning and the guidance message
  expect_warning(
    p <- expect_message(
      gg_parallel_slopes(
        y = "log10_price",
        num_x = "log10_size",
        cat_x = "condition",
        data = hp_small,
        alpha = 0.3
      ),
      regexp = "geom_parallel_slopes",
      all = FALSE
    ),
    regexp = "geom_parallel_slopes",
    all = FALSE
  )
  
  # Basic structure: should be a ggplot
  expect_s3_class(p, "ggplot")
  
  # The base mapping should use the requested variables
  expect_equal(rlang::as_label(p$mapping$x), "log10_size")
  expect_equal(rlang::as_label(p$mapping$y), "log10_price")
  expect_equal(rlang::as_label(p$mapping$colour), "condition")
  
  # First layer is points, second is lines
  expect_s3_class(p$layers[[1]]$geom, "GeomPoint")
  expect_s3_class(p$layers[[2]]$geom, "GeomLine")
  
  # The alpha in the point layer should match the argument
  expect_equal(p$layers[[1]]$aes_params$alpha, 0.3)
})
