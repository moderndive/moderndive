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

### Additional tests
test_that("tidy_summary errors if df is not a data frame", {
  x <- 1:5
  expect_error(
    tidy_summary(x),
    "must be a data frame"
  )
})

test_that("tidy_summary default columns matches explicit columns", {
  df_small <- tibble::tibble(
    category = factor(c("A", "B", "A")),
    value    = c(1, 2, 3),
    flag     = c(TRUE, FALSE, TRUE)
  )
  
  res_default <- tidy_summary(df_small, na.rm = TRUE) |>
    dplyr::arrange(column, ifelse(is.na(group), "", group))
  res_explicit <- tidy_summary(
    df_small,
    columns = c(category, value, flag),
    na.rm = TRUE
  ) |>
    dplyr::arrange(column, ifelse(is.na(group), "", group))
  
  expect_equal(res_default, res_explicit)
})

test_that("tidy_summary works with numeric-only data", {
  df_num <- tibble::tibble(
    a = c(1, 2, 3),
    b = c(10, 20, 30)
  )
  
  res <- tidy_summary(df_num, na.rm = TRUE)
  
  expect_equal(nrow(res), 2L)
  expect_setequal(res$column, c("a", "b"))
  expect_true(all(res$type == "numeric"))
  
  # For numeric columns, group is always NA
  expect_true(all(is.na(res$group)))
  
  # n should be non-missing counts
  expect_true(all(res$n == 3L))
})

test_that("tidy_summary works with categorical-only data", {
  df_cat <- tibble::tibble(
    fct = factor(c("A", "A", "B")),
    chr = c("x", "x", "y"),
    lgc = c(TRUE, FALSE, TRUE)
  )
  
  res <- tidy_summary(df_cat, na.rm = TRUE)
  
  # three levels for fct (A,B), two for chr (x,y), two for lgc (TRUE,FALSE)
  expect_true(all(res$type %in% c("factor", "character", "logical")))
  
  # Numeric summary stats should be NA
  expect_true(all(is.na(res$min)))
  expect_true(all(is.na(res$Q1)))
  expect_true(all(is.na(res$mean)))
  expect_true(all(is.na(res$median)))
  expect_true(all(is.na(res$Q3)))
  expect_true(all(is.na(res$max)))
  expect_true(all(is.na(res$sd)))
  
  # n should equal counts per group
  counts_manual <- list(
    fct = table(df_cat$fct),
    chr = table(df_cat$chr),
    lgc = table(df_cat$lgc)
  )
  
  # Check for one of them to keep it simple
  fct_res <- res[res$column == "fct", ]
  expect_equal(
    sort(fct_res$n),
    sort(as.integer(counts_manual$fct))
  )
})

test_that("tidy_summary classifies mixed types including 'other' and skips them", {
  df_mixed <- tibble::tibble(
    num = c(1, 2, 3),
    chr = c("a", "b", "a"),
    fct = factor(c("x", "x", "y")),
    lgc = c(TRUE, FALSE, TRUE),
    date = as.Date("2020-01-01") + 0:2  # will be type "other"
  )
  
  res <- tidy_summary(df_mixed, columns = c(num, chr, fct, lgc, date), na.rm = TRUE)
  
  # date is type "other" and should not show up in the final summary
  expect_false("date" %in% res$column)
  
  # All other types should appear
  expect_true(all(c("num", "chr", "fct", "lgc") %in% res$column))
  
  # type column should only list the handled types
  expect_true(all(res$type %in% c("numeric", "character", "factor", "logical")))
})

test_that("tidy_summary errors for numeric column with NA when na.rm is FALSE", {
  df_na <- tibble::tibble(
    x = c(1, NA, 3)
  )
  
  # min/quantile/mean without na.rm will error inside tidy_summary
  expect_error(
    tidy_summary(df_na, columns = c(x)),
    regexp = "missing values"
  )
})

test_that("tidy_summary handles numeric NA correctly with na.rm = TRUE", {
  df_na <- tibble::tibble(
    x = c(1, NA, 3)
  )
  
  res <- tidy_summary(df_na, columns = c(x), na.rm = TRUE)
  
  expect_equal(res$column, "x")
  expect_equal(res$type, "numeric")
  
  # n should ignore the NA
  expect_equal(res$n, 2L)
  
  # Summary stats should be computed on non-missing values only
  expect_equal(res$min, 1)
  expect_equal(res$max, 3)
  expect_equal(res$median, 2)
})

test_that("tidy_summary returns expected structure for mixed numeric and categorical", {
  df_mix <- tibble::tibble(
    category = factor(c("A", "B", "A", "B")),
    value    = c(1, 2, 3, 4),
    flag     = c(TRUE, FALSE, TRUE, FALSE)
  )
  
  res <- tidy_summary(df_mix, columns = c(category, value, flag), na.rm = TRUE)
  
  # One numeric row, 2 factor rows, 2 logical rows
  expect_equal(sum(res$type == "numeric"), 1L)
  expect_equal(sum(res$type == "factor"), 2L)
  expect_equal(sum(res$type == "logical"), 2L)
  
  # For numeric row: group is NA, n equals row count
  num_row <- res[res$type == "numeric", ]
  expect_true(is.na(num_row$group))
  expect_equal(num_row$n, 4L)
  
  # For categorical/logical rows: group not NA, n is counts by level
  cat_log_rows <- res[res$type != "numeric", ]
  expect_false(any(is.na(cat_log_rows$group)))
  expect_true(all(cat_log_rows$n %in% c(2L)))  # each level appears twice
})
