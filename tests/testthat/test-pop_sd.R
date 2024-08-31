# Load the testthat package
library(testthat)

# Test 1: Check if the function correctly calculates the population standard deviation

test_that("pop_sd calculates population standard deviation correctly", {
  x <- c(2, 4, 6, 8, 10)
  result <- pop_sd(x)
  expected_result <- sqrt(mean(x^2) - mean(x)^2)
  expect_equal(result, expected_result)
})

# Test 2: Check if the function stops with a non-numeric vector
test_that("pop_sd throws an error for non-numeric input", {
  x <- c("a", "b", "c")
  expect_error(pop_sd(x), "Input must be a numeric vector.")
})

# Test 3: Check if the function works within a dplyr pipeline
test_that("pop_sd works within a dplyr pipeline", {
  df <- data.frame(weight = c(2, 4, 6, 8, 10))
  result <- df |> 
    summarize(population_mean = mean(weight), 
              population_sd = pop_sd(weight))
  
  expected_sd <- sqrt(mean(df$weight^2) - mean(df$weight)^2)
  expect_equal(result$population_sd, expected_sd)
})

# Test 4: Check if the function handles a single numeric value
test_that("pop_sd handles a single numeric value", {
  x <- 5
  result <- pop_sd(x)
  expect_equal(result, 0)  # Population SD of a single value is 0
})

# Test 5: Check if the function handles NA values
test_that("pop_sd handles NA values", {
  x <- c(2, 4, 6, NA, 10)
  result <- pop_sd(na.omit(x))  # Using na.omit to remove NAs
  expected_result <- sqrt(mean(na.omit(x)^2) - mean(na.omit(x))^2)
  expect_equal(result, expected_result)
})

