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
  
  # Check `model`
  expect_error(
    get_regression_table(model = vec)
  )
  expect_error(
    get_regression_summaries(model = species_glm)
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
