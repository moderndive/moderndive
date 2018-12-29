context("get_regression")

test_that("`model` is an `lm` object", {
  vec <- 1:10
  expect_error(get_regression_table(model = vec))
})

library(dplyr)
library(tibble)
mpg_null <- lm(mpg ~ NULL, data = mtcars)
data(mtcars)
mtcars <- mtcars %>% 
  rownames_to_column(var = "automobile") %>% 
  mutate(cyl = as.factor(cyl))
mpg_cyl <- lm(mpg ~ cyl, data = mtcars)

iris_binary <- iris %>% 
  mutate(virginica = Species == "virginica")
species_glm <- glm(virginica ~ Sepal.Width, data = iris_binary)

test_that("function inputs are valid", {
  # Check `digits`
  expect_error(get_regression_table(
    model = mpg_null,
    digits = "blah"
  ))

  # Check `print`
  expect_error(get_regression_points(
    model = mpg_cyl,
    digits = 5,
    print = "yes"
  ))

  # Check `print` again
  expect_silent(get_regression_points(
    model = mpg_cyl,
    digits = 4,
    print = TRUE
  ))
  
  # # Check ID
  expect_silent(get_regression_points(
    model = mpg_cyl,
    ID = "automobile",
    newdata = NULL
  ))
  
  # Check newdata
  expect_silent(get_regression_points(
    model = mpg_cyl,
    newdata = mtcars
  ))
  expect_silent(get_regression_points(
    model = mpg_cyl,
    newdata = NULL
  ))
  
  # Check `model`
  expect_error(get_regression_summaries(
    model = species_glm
  ))
  
})

test_that("README code works", {
  # Convert cyl to factor variable
  mtcars <- mtcars %>% 
    mutate(cyl = as.factor(cyl))
  
  # Regression models
  mpg_model <- lm(mpg ~ hp, data = mtcars)
  mpg_mlr_model <- lm(mpg ~ hp + wt, data = mtcars)
  mpg_mlr_model2 <- lm(mpg ~ hp + cyl, data = mtcars)
  
  # Regression tables
  expect_silent(get_regression_table(model = mpg_model))
  expect_silent(get_regression_table(mpg_mlr_model, 
                                     digits = 4, print = TRUE))
  
  # Regression points. For residual analysis for example
  expect_silent(get_regression_points(mpg_mlr_model2))
  # Case when true observed outcome variable is included and hence we can
  # compute fitted/predicted values and residuals
  newcars <- slice(mtcars, 1:3)
  expect_silent(get_regression_points(mpg_mlr_model2, newdata = newcars))
  # Case when true observed outcome variable is NOT included and hence we 
  # CANNOT compute fitted/predicted values and residuals
  newcars <- slice(mtcars, 1:3) %>% 
    select(-mpg)
  expect_silent(get_regression_points(mpg_mlr_model2, newdata = newcars))

  
  # Regression summaries
  expect_silent(get_regression_summaries(mpg_model))
  expect_silent(mpg_model %>% 
                  get_regression_summaries(digits = 5, print = TRUE))
 })
