library(testthat)
library(dplyr)
library(moderndive)

# Unit tests
test_that("tidy_summary handles numeric columns correctly", {
  result <- tidy_summary(un_member_states_2024, columns = c(population_2024))
  
  expect_equal(nrow(result), 1)
  expect_equal(result$column, "population_2024")
  expect_equal(result$type, "numeric")
  expect_true(all(result$min <= result$Q1))
  expect_true(all(result$Q1 <= result$median))
  expect_true(all(result$median <= result$Q3))
  expect_true(all(result$Q3 <= result$max))
})

test_that("tidy_summary handles categorical (factor) columns correctly", {
  result <- tidy_summary(un_member_states_2024, columns = c(continent))
  
  expect_equal(nrow(result), 6) # 3 continents
  expect_equal(unique(result$column), "continent")
  expect_equal(unique(result$type), "factor")
  expect_true(all(is.na(result$min)))
  expect_true(all(is.na(result$Q1)))
  expect_true(all(is.na(result$median)))
  expect_true(all(is.na(result$Q3)))
  expect_true(all(is.na(result$max)))
})

test_that("tidy_summary handles logical columns correctly", {
  result <- tidy_summary(un_member_states_2024, columns = c(has_nuclear_weapons_2024))
  
  expect_equal(nrow(result), 2)
  expect_equal(unique(result$column), "has_nuclear_weapons_2024")
  expect_equal(unique(result$type), "logical")
  expect_true(all(is.na(result$min)))
  expect_true(all(is.na(result$Q1)))
  expect_true(all(is.na(result$median)))
  expect_true(all(is.na(result$Q3)))
  expect_true(all(is.na(result$max)))
})

test_that("tidy_summary handles multiple columns of different types correctly", {
  result <- tidy_summary(
    un_member_states_2024, 
    columns = c(population_2024, continent, has_nuclear_weapons_2024))
  
  expect_equal(nrow(result), 9) # 1 numeric + 6 categorical + 2 logical
  expect_equal(sum(result$type == "numeric"), 1)
  expect_equal(sum(result$type == "factor"), 6)
  expect_equal(sum(result$type == "logical"), 2)
})

test_that("tidy_summary handles empty data frame with error", {
  empty_df <- un_member_states_2024[0, ]
  expect_error(
    tidy_summary(
      empty_df, 
      columns = c(population_2024, continent, has_nuclear_weapons_2024)))
})

test_that("tidy_summary returns correct summary for GDP per capita", {
  result <- tidy_summary(un_member_states_2024, columns = c(gdp_per_capita), 
                         na.rm = TRUE)
  
  expect_equal(nrow(result), 1)
  expect_equal(result$column, "gdp_per_capita")
  expect_equal(result$type, "numeric")
  expect_true(all(result$min <= result$Q1))
  expect_true(all(result$Q1 <= result$median))
  expect_true(all(result$median <= result$Q3))
  expect_true(all(result$Q3 <= result$max))
})
