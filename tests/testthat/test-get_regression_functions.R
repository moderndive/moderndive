context("get_regression")

library(dplyr)
library(tibble)

# Modify mtcars and run two lm() models
data(mtcars)
mtcars <- mtcars %>%
  rownames_to_column(var = "automobile") %>%
  mutate(cyl = as.factor(cyl))

mpg_null <- lm(mpg ~ NULL, data = mtcars)
mpg_cyl <- lm(mpg ~ cyl, data = mtcars)

# Modify iris and run glm() model
iris_binary <- iris %>%
  mutate(virginica = Species == "virginica")
species_glm <- glm(virginica ~ Sepal.Width, data = iris_binary)


test_that("function inputs are valid", {
  vec <- 1:10
  
  # Check `model` — non-model objects are still rejected
  expect_error(
    get_regression_table(model = vec)
  )
  # glm objects are now accepted (issue #20). Verify no error and a tibble.
  expect_silent(
    get_regression_summaries(model = species_glm)
  )
  expect_s3_class(
    get_regression_summaries(model = species_glm),
    "tbl_df"
  )
  
  # Check `digits`
  expect_error(
    get_regression_table(model = mpg_null, digits = "blah")
  )
  
  # Check `print`
  expect_error(
    get_regression_points(model = mpg_cyl, digits = 5, print = "yes")
  )
  expect_silent(
    get_regression_points(model = mpg_cyl, digits = 4, print = TRUE)
  )
  
  # Check newdata
  expect_silent(
    get_regression_points(model = mpg_cyl, ID = "automobile", newdata = mtcars)
  )
  expect_silent(
    get_regression_points(model = mpg_cyl, ID = "automobile", newdata = NULL)
  )
  expect_error(
    get_regression_points(model = mpg_cyl, ID = "automobile", newdata = matrix(mtcars))
  )
  
  # Check ID
  expect_error(
    get_regression_points(model = mpg_cyl, ID = 6)
  )
  
  # Check default_categorical_levels
  expect_silent(
    get_regression_table(model = mpg_cyl, digits = 5, print = FALSE, default_categorical_levels = TRUE)
  )
  
  expect_error(
    get_regression_table(model = mpg_cyl, digits = 5, print = FALSE, default_categorical_levels = "yes pls")
  )
})


test_that("README code works", {
  # Regression models
  mpg_model <- lm(mpg ~ hp, data = mtcars)
  mpg_mlr_model <- lm(mpg ~ hp + wt, data = mtcars)
  mpg_mlr_model2 <- lm(mpg ~ hp + cyl, data = mtcars)
  
  # Regression tables
  expect_silent(
    get_regression_table(model = mpg_model)
  )
  expect_silent(
    get_regression_table(mpg_mlr_model, digits = 4, print = TRUE)
  )
  
  # Regression points. For residual analysis for example
  expect_silent(
    get_regression_points(mpg_mlr_model2)
  )
  # newdata case when true observed outcome variable is included and hence we can
  # compute residuals
  newcars <- slice(mtcars, 1:3)
  expect_silent(
    get_regression_points(mpg_mlr_model2, newdata = newcars)
  )
  # newdata case when true observed outcome variable is not included and hence we
  # cannot compute residuals
  newcars <- slice(mtcars, 1:3) %>%
    select(-mpg)
  
  if (packageVersion("broom") <= "1.0.1") {
    regexp <- "variables found"
  } else {
    regexp <- NA
  }
  
  expect_warning(
    get_regression_points(mpg_mlr_model2, newdata = newcars), regexp = regexp
  )
  
  # Regression summaries
  expect_silent(
    get_regression_summaries(mpg_model)
  )
  expect_silent(
    mpg_model %>%
      get_regression_summaries(digits = 5, print = TRUE)
  )
})


test_that("pretty printing xlevels used in `get_regression_table` 
          does not give unexpected outputs", {
  no_cat <- lm(Sepal.Length ~ Sepal.Width, data = iris)
  expect_equal(
    get_regression_table(no_cat)$term,
    c("intercept", "Sepal.Width")
  )

  iris_multi_cat <- iris %>% 
    mutate(petal_width = if_else(
      Petal.Width > 0.2,
      "wide", "narrow"))
  multi_cat <- lm(Sepal.Length ~ Sepal.Width + Species + petal_width,
                  data = iris_multi_cat)
  expect_equal(
    get_regression_table(multi_cat)$term,
    c("intercept", "Sepal.Width", "Species-versicolor", "Species-virginica", "petal_width-wide")
  )
  int_cat <- lm(Sepal.Length ~ Sepal.Width * Species * petal_width,
                  data = iris_multi_cat)
  expect_equal(
    get_regression_table(int_cat)$term,
    c(
      "intercept",
      "Sepal.Width",
      "Species-versicolor",
      "Species-virginica",
      "petal_width-wide",
      "Sepal.Width:Species-versicolor",
      "Sepal.Width:Species-virginica",
      "Sepal.Width:petal_width-wide",
      "Species-versicolor:petal_width-wide",
      "Species-virginica:petal_width-wide",
      "Sepal.Width:Species-versicolor:petal_width-wide",
      "Sepal.Width:Species-virginica:petal_width-wide"
    )
  )
  weird_cat <- lm(Sepal.Length ~ Sepal.Width + factor(Species) + as.factor(petal_width),
                  data = iris_multi_cat)
  expect_equal(
    get_regression_table(weird_cat)$term,
    c(
      "intercept",
      "Sepal.Width",
      "factor(Species)-versicolor",
      "factor(Species)-virginica",
      "as.factor(petal_width)-wide"
    )
  )
})

test_that(
  "we display modified non-baseline levels of categorical variables by default, but allow users to use the default R behavior",
  {
    expect_equal(
      get_regression_table(mpg_cyl, default_categorical_levels = TRUE) %>% pull(term) %>% .[c(-1)],
      names(mpg_cyl$coefficients)[c(-1)]
    )
    
    mpg_model <- lm(mpg ~ hp, data = mtcars)
    expect_equal(
      get_regression_table(mpg_model, default_categorical_levels = FALSE) %>% pull(term) %>% .[c(-1)],
      names(mpg_model$coefficients)[c(-1)]
    )
  }
)

test_that("get_regression_points handles on-the-fly predictor term", {
  iris_model <- lm(
    Sepal.Width ~ Sepal.Length + (Petal.Length > 1.5),
    data = iris
  )
  
  pts <- NULL
  
  # Main call should not error
  expect_error({
    pts <- get_regression_points(iris_model)
  }, NA)
  
  # Basic structure checks
  expect_s3_class(pts, "tbl_df")
  expect_equal(nrow(pts), nrow(iris))
  
  # Original outcome and one predictor must be present
  expect_true(all(c("Sepal.Width", "Sepal.Length") %in% names(pts)))
  
  # Fitted and residual columns should be present with moderndive-style names
  expect_true("Sepal.Width_hat" %in% names(pts))
  expect_true("residual" %in% names(pts))
  
  # 1) Check fitted values are close to stats::predict for the same model
  expected_fitted <- as.numeric(predict(iris_model))
  expect_equal(
    pts$Sepal.Width_hat,
    expected_fitted,
    tolerance = 1e-3
  )
  
  # 2) Check residuals are outcome minus fitted (internally consistent)
  expect_equal(
    pts$Sepal.Width - pts$Sepal.Width_hat,
    pts$residual,
    tolerance = 1e-3
  )
  
  # 3) Check that all rows line up with the original data order
  #    (this is an important part of "functionality works" for users)
  expect_equal(pts$Sepal.Width, iris$Sepal.Width, tolerance = 1e-8)
})

test_that("get_regression_summaries works with on-the-fly predictor term", {
  iris_model <- lm(
    Sepal.Width ~ Sepal.Length + (Petal.Length > 1.5),
    data = iris
  )
  
  summ <- NULL
  
  # Should run without error
  expect_error({
    summ <- get_regression_summaries(iris_model)
  }, NA)
  
  expect_s3_class(summ, "tbl_df")
  expect_identical(nrow(summ), 1L)
  
  # Check for key summary columns
  expect_true(all(
    c("r_squared", "adj_r_squared", "mse", "rmse") %in% names(summ)
  ))
  
  # 1) r_squared and adj_r_squared should be close to stats::summary.lm
  mod_sum <- summary(iris_model)
  
  expect_equal(
    summ$r_squared[[1]],
    unname(mod_sum$r.squared),
    tolerance = 1e-3
  )
  
  expect_equal(
    summ$adj_r_squared[[1]],
    unname(mod_sum$adj.r.squared),
    tolerance = 1e-3
  )
  
  # 2) mse and rmse should be consistent with residuals
  resids <- residuals(iris_model)
  expected_mse <- mean(resids^2)
  expected_rmse <- sqrt(expected_mse)
  
  expect_true(is.finite(summ$mse[[1]]))
  expect_true(is.finite(summ$rmse[[1]]))
  
  expect_equal(
    summ$mse[[1]],
    expected_mse,
    tolerance = 1e-6
  )
  
  expect_equal(
    summ$rmse[[1]],
    expected_rmse,
    tolerance = 1e-6
  )
})

test_that("get_regression_summaries works with poly() term", {
  data("house_prices", package = "moderndive")
  
  mod <- lm(
    price ~ poly(sqft_living, degree = 2),
    data = house_prices
  )
  
  summ <- NULL
  
  # Should run without error
  expect_error({
    summ <- get_regression_summaries(mod)
  }, NA)
  
  # Basic structure checks
  expect_s3_class(summ, "tbl_df")
  expect_identical(nrow(summ), 1L)
  
  expect_true(all(
    c("r_squared", "adj_r_squared", "mse", "rmse", "sigma",
      "statistic", "p_value", "df", "nobs") %in% names(summ)
  ))
  
  # Functionality checks - values exist and look sensible
  expect_true(is.finite(summ$r_squared[[1]]))
  expect_true(is.finite(summ$adj_r_squared[[1]]))
  expect_true(is.finite(summ$mse[[1]]))
  expect_true(is.finite(summ$rmse[[1]]))
  expect_true(is.finite(summ$sigma[[1]]))
  expect_true(is.finite(summ$statistic[[1]]))
  expect_true(is.finite(summ$p_value[[1]]))
  
  # r_squared should be between 0 and 1
  expect_gt(summ$r_squared[[1]], 0)
  expect_lt(summ$r_squared[[1]], 1)
  
  # nobs should match the number of rows in the data (allow type differences)
  expect_equal(summ$nobs[[1]], nrow(house_prices))
})

test_that("get_regression_points works with poly() term", {
  data("house_prices", package = "moderndive")
  
  mod <- lm(
    price ~ poly(sqft_living, degree = 2),
    data = house_prices
  )
  
  pts <- NULL
  
  # Should run without error
  expect_error({
    pts <- get_regression_points(mod)
  }, NA)
  
  # Basic structure checks
  expect_s3_class(pts, "tbl_df")
  expect_equal(nrow(pts), nrow(house_prices))
  
  # Columns that users care about
  expect_true(all(c("ID", "price", "price_hat", "residual") %in% names(pts)))
  
  # Fitted and residuals should be finite
  expect_true(all(is.finite(pts$price_hat)))
  expect_true(all(is.finite(pts$residual)))
  
  # Residuals should be internally consistent with price and price_hat
  expect_equal(
    pts$price - pts$price_hat,
    pts$residual,
    tolerance = 1e-3
  )
  
  # There should be at least one extra predictor column corresponding to the poly() term
  non_core_cols <- setdiff(
    names(pts),
    c("ID", "price", "price_hat", "residual")
  )
  expect_gte(length(non_core_cols), 1L)
  
  # That extra column should be numeric
  for (col in non_core_cols) {
    expect_true(is.numeric(pts[[col]]))
  }
  
  # And its name should at least hint at coming from poly() or sqft_living
  expect_true(
    any(grepl("poly", non_core_cols, fixed = TRUE)) ||
      any(grepl("sqft_living", non_core_cols, fixed = TRUE))
  )
})

# In-formula transforms ----

test_that("get_regression_points handles LHS transform like log(y) ~ x", {
  m <- lm(log(mpg) ~ hp, data = mtcars)

  pts <- get_regression_points(m)

  expect_s3_class(pts, "tbl_df")
  expect_equal(nrow(pts), nrow(mtcars))
  # outcome column is sanitized to log_mpg, hp is the original predictor
  expect_true(all(c("ID", "log_mpg", "hp", "log_mpg_hat", "residual") %in% names(pts)))
  # ugly columns must not leak
  expect_false(".rownames" %in% names(pts))
  expect_false("mpg" %in% names(pts))

  # residuals are on the model's (log) scale and match residuals(model)
  # Rounded outcome minus rounded fit can drift by 1e-3 from the rounded raw
  # residual, so use a slightly looser tolerance than for direct equality.
  expect_equal(
    pts$log_mpg - pts$log_mpg_hat,
    pts$residual,
    tolerance = 5e-3
  )
  expect_equal(
    pts$residual,
    unname(round(as.numeric(residuals(m)), 3)),
    tolerance = 1e-3
  )
})

test_that("get_regression_summaries handles LHS transform like log(y) ~ x", {
  m <- lm(log(mpg) ~ hp, data = mtcars)

  summ <- get_regression_summaries(m)

  expect_s3_class(summ, "tbl_df")
  expect_identical(nrow(summ), 1L)

  # mse/rmse are computed on the model scale (log)
  resids <- residuals(m)
  expect_equal(summ$mse[[1]], mean(resids^2), tolerance = 1e-3)
  expect_equal(summ$rmse[[1]], sqrt(mean(resids^2)), tolerance = 1e-3)
})

test_that("get_regression_points handles LHS+RHS transforms like log(y) ~ log(x)", {
  m <- lm(log(mpg) ~ log(hp), data = mtcars)

  pts <- get_regression_points(m)

  # both sides sanitized; original predictor `hp` shown rather than log(hp)
  expect_true(all(c("log_mpg", "hp", "log_mpg_hat", "residual") %in% names(pts)))
  expect_false("log(hp)" %in% names(pts))
  expect_false(".rownames" %in% names(pts))

  # Rounded outcome minus rounded fit can drift by 1e-3 from the rounded raw
  # residual, so use a slightly looser tolerance than for direct equality.
  expect_equal(
    pts$log_mpg - pts$log_mpg_hat,
    pts$residual,
    tolerance = 5e-3
  )
})

test_that("get_regression_points with newdata containing outcome computes residuals on model scale", {
  m <- lm(log(mpg) ~ hp, data = mtcars)
  nd <- mtcars[1:5, ]

  pts <- get_regression_points(m, newdata = nd)

  expect_equal(nrow(pts), 5L)
  expect_true(all(c("log_mpg", "hp", "log_mpg_hat", "residual") %in% names(pts)))
  # residuals are log(y) - log_y_hat, NOT y - log_y_hat
  # Rounded outcome minus rounded fit can drift by 1e-3 from the rounded raw
  # residual, so use a slightly looser tolerance than for direct equality.
  expect_equal(
    pts$log_mpg - pts$log_mpg_hat,
    pts$residual,
    tolerance = 5e-3
  )
  expect_equal(
    pts$log_mpg,
    round(log(nd$mpg), 3),
    tolerance = 1e-3
  )
})

test_that("get_regression_points with newdata missing outcome returns predictions on model scale", {
  m <- lm(log(mpg) ~ hp, data = mtcars)
  nd <- mtcars[1:5, !names(mtcars) %in% "mpg"]

  pts <- get_regression_points(m, newdata = nd)

  expect_equal(nrow(pts), 5L)
  expect_true("log_mpg_hat" %in% names(pts))
  expect_false("residual" %in% names(pts))
  expect_false("log_mpg" %in% names(pts))
})

test_that("get_regression_points cleans up basis-matrix columns from poly/scale/I", {
  for (formula_obj in list(
    mpg ~ poly(hp, 2),
    mpg ~ scale(hp),
    mpg ~ I(hp^2)
  )) {
    m <- lm(formula_obj, data = mtcars)
    pts <- get_regression_points(m)

    # original predictor is present, transformed/basis columns are not
    expect_true("hp" %in% names(pts), info = deparse(formula_obj))
    # no leaked basis matrix or wrapper columns
    expect_false(any(grepl("poly|scale|I\\(", names(pts))),
                 info = deparse(formula_obj))
    expect_false(".rownames" %in% names(pts), info = deparse(formula_obj))
    # all output columns are atomic vectors (no matrix-columns from poly/scale)
    for (col in names(pts)) {
      expect_null(dim(pts[[col]]), info = paste(deparse(formula_obj), col))
    }
  }
})

test_that("get_regression_points does not leak .rownames when source data has rownames", {
  # mtcars has named row names — old code passed these through as a column
  m <- lm(mpg ~ hp, data = mtcars)
  pts <- get_regression_points(m)
  expect_false(".rownames" %in% names(pts))
})

test_that("get_regression_points ID arg works with LHS transforms", {
  mt <- tibble::rownames_to_column(mtcars, "auto")
  m  <- lm(log(mpg) ~ hp, data = mt)

  pts <- get_regression_points(m, ID = "auto")

  expect_true("auto" %in% names(pts))
  expect_equal(pts$auto[1:3], rownames(mtcars)[1:3])
  expect_true(all(c("log_mpg", "hp", "log_mpg_hat", "residual") %in% names(pts)))
})

test_that("get_regression_points errors helpfully on bad newdata/ID inputs", {
  m <- lm(mpg ~ hp, data = mtcars)

  # 1) newdata missing a required predictor
  nd_no_hp <- mtcars[, c("automobile", "mpg")]
  expect_error(
    get_regression_points(m, newdata = nd_no_hp),
    "missing required predictor"
  )

  # 2) ID arg refers to a column not present in newdata
  nd_no_auto <- mtcars[, c("mpg", "hp")]
  expect_error(
    get_regression_points(m, newdata = nd_no_auto, ID = "automobile"),
    "not found in `newdata`"
  )

  # 3) ID arg refers to a column not present in source data
  expect_error(
    get_regression_points(m, ID = "doesnotexist"),
    "not found in source data"
  )

  # 4) Source data isn't reachable from the model call (e.g. anonymous data)
  m_no_src <- m
  m_no_src$call$data <- NULL
  expect_error(
    get_regression_points(m_no_src, ID = "automobile"),
    "Could not locate source data"
  )
})

# glm support (issue #20) ----

test_that("get_regression_table works on a logistic glm", {
  m <- glm(am ~ mpg + wt, data = mtcars, family = binomial())

  tbl <- get_regression_table(m)
  expect_s3_class(tbl, "tbl_df")
  expect_setequal(tbl$term, c("intercept", "mpg", "wt"))
  expect_named(tbl, c("term", "estimate", "std_error", "statistic",
                      "p_value", "lower_ci", "upper_ci"))
})

test_that("get_regression_table exponentiate=TRUE returns odds ratios", {
  m <- glm(am ~ mpg + wt, data = mtcars, family = binomial())

  tbl_log  <- get_regression_table(m)
  tbl_odds <- get_regression_table(m, exponentiate = TRUE)

  # exp(estimate) of the log-odds matches the exponentiated estimate
  # (within rounding tolerance — both are independently rounded to 3 dp).
  expect_equal(
    tbl_odds$estimate[tbl_log$term == "mpg"],
    round(exp(tbl_log$estimate[tbl_log$term == "mpg"]), 3),
    tolerance = 1e-2
  )
})

test_that("get_regression_table validates exponentiate arg", {
  m <- glm(am ~ mpg, data = mtcars, family = binomial())
  expect_error(get_regression_table(m, exponentiate = "yes"))
})

test_that("get_regression_points on a logistic glm returns response-scale fitted/residual", {
  m <- glm(am ~ mpg + wt, data = mtcars, family = binomial())

  pts <- get_regression_points(m)

  expect_s3_class(pts, "tbl_df")
  expect_equal(nrow(pts), nrow(mtcars))
  expect_true(all(c("ID", "am", "mpg", "wt", "am_hat", "residual") %in% names(pts)))

  # am_hat is a probability in [0, 1]
  expect_true(all(pts$am_hat >= 0 & pts$am_hat <= 1))

  # residual = am - am_hat (within rounding tolerance)
  expect_equal(
    pts$am - pts$am_hat,
    pts$residual,
    tolerance = 5e-3
  )
})

test_that("get_regression_points on a glm with newdata predicts on response scale", {
  m  <- glm(am ~ mpg + wt, data = mtcars, family = binomial())
  nd <- mtcars[1:5, ]

  pts <- get_regression_points(m, newdata = nd)
  expect_equal(nrow(pts), 5L)
  expect_true(all(pts$am_hat >= 0 & pts$am_hat <= 1))
  expect_equal(
    pts$am - pts$am_hat,
    pts$residual,
    tolerance = 5e-3
  )

  # newdata WITHOUT the outcome — only fitted column, no residual
  nd2 <- mtcars[1:5, !names(mtcars) %in% "am"]
  pts2 <- get_regression_points(m, newdata = nd2)
  expect_true("am_hat" %in% names(pts2))
  expect_false("residual" %in% names(pts2))
})

test_that("get_regression_summaries on a glm returns glm-shaped summary", {
  m <- glm(am ~ mpg + wt, data = mtcars, family = binomial())

  summ <- get_regression_summaries(m)

  expect_s3_class(summ, "tbl_df")
  expect_identical(nrow(summ), 1L)

  # mse / rmse computed from response-scale residuals
  resid_resp <- residuals(m, type = "response")
  expect_equal(summ$mse[[1]], round(mean(resid_resp^2), 3), tolerance = 1e-3)
  expect_equal(summ$rmse[[1]], round(sqrt(mean(resid_resp^2)), 3), tolerance = 1e-3)

  # glm-shaped: deviance / aic / bic should be present, R^2 columns absent
  expect_true(all(c("mse", "rmse", "deviance", "aic", "bic",
                    "null_deviance", "log_lik", "nobs") %in% names(summ)))
  expect_false("r_squared" %in% names(summ))
  expect_false("adj_r_squared" %in% names(summ))
})

test_that("get_regression_summaries on a Poisson glm works", {
  # The file-level `mtcars` has `cyl` coerced to a factor — Poisson needs
  # a numeric count outcome, so use a fresh copy of `mtcars` here.
  raw_mtcars <- datasets::mtcars
  m <- glm(carb ~ mpg + wt, data = raw_mtcars, family = poisson())

  summ <- get_regression_summaries(m)
  expect_s3_class(summ, "tbl_df")
  expect_true(all(is.finite(c(summ$mse, summ$rmse, summ$deviance, summ$aic))))
})

test_that("get_regression_table renders factor levels for glm with default delimiter", {
  # mtcars$cyl is set up as a factor at the top of this test file. Use a
  # non-degenerate predictor combination (NOT one where the outcome is
  # perfectly determined by the factor — that breaks profile-likelihood CIs).
  m <- glm(am ~ mpg + cyl, data = mtcars, family = binomial())

  tbl <- get_regression_table(m)
  # cyl has levels "4", "6", "8" — baseline is "4", non-baseline are "6", "8"
  expect_true(any(grepl("cyl-6", tbl$term, fixed = TRUE)))
  expect_true(any(grepl("cyl-8", tbl$term, fixed = TRUE)))
})

