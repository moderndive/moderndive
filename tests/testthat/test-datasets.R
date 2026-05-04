context("datasets")

test_that("pennies_resamples has correct replicate column (issue #130)", {
  data("pennies_resamples", package = "moderndive")

  # Each of the 35 student names corresponds to one replicate (1..35),
  # and each replicate is a sample of 50 pennies.
  expect_identical(nrow(pennies_resamples), 35L * 50L)
  expect_setequal(unique(pennies_resamples$replicate), 1:35)
  expect_identical(length(unique(pennies_resamples$name)), 35L)

  # Each replicate corresponds to exactly one name and 50 rows
  per_replicate <- table(pennies_resamples$replicate)
  expect_true(all(per_replicate == 50L))

  name_per_replicate <- pennies_resamples %>%
    dplyr::group_by(replicate) %>%
    dplyr::summarise(n_names = dplyr::n_distinct(name), .groups = "drop")
  expect_true(all(name_per_replicate$n_names == 1L))
})
