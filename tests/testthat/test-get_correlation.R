context("get_correlation")
library(tibble)
library(dplyr)

df <- tibble(
  vec1 = 1:10,
  vec2 = seq(from = 5, to = 50, by = 5),
  vec3 = c(1:9, NA)
)



test_that("arguments are appropriate", {
  expect_error(
    get_correlation(vec1,
      formula = vec1 ~ NULL
    )
  )

  expect_error(
    df %>%
      get_correlation(formula = vec1 ~ NULL)
  )

  expect_error(
    df %>%
      get_correlation(formula = NULL ~ vec2)
  )

  expect_error(
    df %>%
      get_correlation(formula = vec2)
  )
})

test_that("variables are in data frame", {
  expect_error(
    mtcars %>%
      get_correlation(formula = mpg2 ~ disp)
  )

  expect_error(
    mtcars %>%
      get_correlation(formula = mpg2 ~ disp2)
  )

  expect_error(
    mtcars %>%
      get_correlation(formula = mpg ~ disp2)
  )

  expect_equal(
    object = mtcars %>%
      get_correlation(formula = mpg ~ disp) %>%
      pull(),
    expected = cor(mtcars$mpg, mtcars$disp)
  )

  expect_error(
    mtcars %>%
      get_correlation(formula = mpg ~ disp + hp)
  )
})


test_that("missing data handled correctly", {
  expect_true(
    df %>%
      get_correlation(formula = vec1 ~ vec3) %>%
      pull(cor) %>%
      is.na()
  )

  expect_equal(
    df %>%
      get_correlation(formula = vec1 ~ vec3, na.rm = TRUE) %>%
      pull(cor),
    1
  )

  expect_equal(
    df %>%
      get_correlation(formula = vec1 ~ vec3, use = "complete.obs") %>%
      pull(cor),
    1
  )
})

## ------------------------------------------------------------------
## Extra tests for helpers and grouped-data branch
## ------------------------------------------------------------------

test_that("check_correlation_args validates data and formula types", {
  # data is not a data.frame
  expect_error(
    check_correlation_args(1:3, mpg ~ disp),
    "data.*data frame"
  )
  
  # formula is not a formula
  expect_error(
    check_correlation_args(mtcars, "mpg ~ disp"),
    "formula.*not recognized as a formula"
  )
  
  # valid data and formula pass silently
  expect_silent(
    check_correlation_args(mtcars, mpg ~ disp)
  )
})

test_that("check_formula_args errors on missing lhs or rhs", {
  # Build formulas with missing sides using rlang
  f_lhs_missing <- rlang::new_formula(NULL, rlang::sym("vec2"))
  f_rhs_missing <- rlang::new_formula(rlang::sym("vec1"), NULL)
  
  # Missing left-hand side
  expect_error(
    check_formula_args(
      data = df,
      formula = f_lhs_missing,
      outcome_variable = character(0),
      explanatory_variable = "vec2"
    ),
    "left hand side"
  )
  
  # Missing right-hand side
  expect_error(
    check_formula_args(
      data = df,
      formula = f_rhs_missing,
      outcome_variable = "vec1",
      explanatory_variable = character(0)
    ),
    "right hand side"
  )
  
  # Correct formula passes silently
  expect_silent(
    check_formula_args(
      data = mtcars,
      formula = mpg ~ disp,
      outcome_variable = "mpg",
      explanatory_variable = "disp"
    )
  )
})

test_that("get_correlation works with grouped data", {
  grouped <- mtcars %>%
    group_by(cyl)
  
  res <- grouped %>%
    get_correlation(formula = mpg ~ disp)
  
  # One row per group
  expect_s3_class(res, "data.frame")
  expect_equal(nrow(res), dplyr::n_distinct(mtcars$cyl))
  
  # Grouping variable should be present in the result
  expect_true("cyl" %in% names(res))
  
  # Correlations should match manual grouped calculation
  manual <- grouped %>%
    summarise(cor = cor(mpg, disp), .groups = "drop")
  
  expect_equal(
    res$cor,
    manual$cor
  )
})

test_that("get_correlation forwards extra arguments to cor()", {
  # Use `method = "spearman"` to check that ... is passed through
  out_pearson <- mtcars %>%
    get_correlation(formula = mpg ~ disp)
  
  out_spearman <- mtcars %>%
    get_correlation(formula = mpg ~ disp, method = "spearman")
  
  expect_false(is.na(out_pearson$cor))
  expect_false(is.na(out_spearman$cor))
  
  # Spearman and Pearson should generally differ for these variables
  expect_false(isTRUE(all.equal(out_pearson$cor, out_spearman$cor)))
})
