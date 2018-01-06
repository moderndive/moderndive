context("get_regression")

test_that("`data` is a data frame", {
  vec <- 1:10
  expect_error(get_regression_table(formula = vec ~ NULL, data = vec))
})

test_that("regression_table inputs are valid", {
  expect_error(get_regression_table(
    formula = mpg ~ NULL,
    digits = "blah",
    data = mtcars
  ))
  expect_error(get_regression_table(formula = ~ mpg, data = mtcars))
  
  expect_error(get_regression_table(formula = disp + drat ~ mpg, data = mtcars))
  
  expect_error(get_regression_points(formula = rats ~ mpg, data = mtcars))
  
  expect_error(get_regression_table(formula = mpg ~ rats + cats, data = mtcars))
  
  expect_error(get_regression_points(formula = mpg ~ rats + drat, data = mtcars))
  
})

test_that("README code works", {
#  expect_silent(get_regression_table(mpg ~ hp, data = mtcars))
  expect_silent(get_regression_table(
    mpg ~ hp + wt,
    data = mtcars,
    digits = 4,
    print = TRUE
  ))
  
  expect_silent(mtcars %>% dplyr::mutate(cyl = as.factor(cyl)) %>%
                  get_regression_points(formula = mpg ~ hp + cyl, 
                                        data = .))
  
  expect_silent(get_regression_summaries(mpg ~ hp, data = mtcars))
  
  expect_silent(get_regression_summaries(
    mpg ~ hp,
    data = mtcars,
    digits = 5,
    print = TRUE
  ))
})