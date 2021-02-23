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
  expect_warning(
    get_regression_points(mpg_mlr_model2, newdata = newcars)
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
  terms <-
    c("intercept",
      "aaaa",
      "babab",
      "c_c-x",
      "xx-xx",
      "not intercept and not categorical")
  xlevels <- c("a", "b", "i", "c", "x")
  expect_equal(
    moderndive:::extract_cat_names(terms, xlevels, FALSE),
    c(
      "intercept",
      "a: aaa",
      "b: abab",
      "c: _c-x",
      "x: x-xx",
      "not intercept and not categorical"
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