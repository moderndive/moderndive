context("plot_3d_regression")

test_that("plot_3d_regression validates `data` is a data frame", {
  expect_error(
    plot_3d_regression(1:10, mpg ~ hp + wt),
    "must be a data frame"
  )
})

test_that("plot_3d_regression validates `formula` is a formula", {
  expect_error(
    plot_3d_regression(mtcars, "mpg ~ hp + wt"),
    "not recognized as a formula"
  )
})

test_that("plot_3d_regression validates `n` is numeric", {
  expect_error(
    plot_3d_regression(mtcars, mpg ~ hp + wt, n = "lots"),
    "numeric"
  )
})

test_that("plot_3d_regression rejects multi-variable LHS", {
  expect_error(
    plot_3d_regression(mtcars, mpg + cyl ~ hp + wt),
    "exactly one outcome"
  )
})

test_that("plot_3d_regression rejects RHS that doesn't have exactly two variables", {
  expect_error(
    plot_3d_regression(mtcars, mpg ~ hp),
    "exactly two predictor"
  )
  expect_error(
    plot_3d_regression(mtcars, mpg ~ hp + wt + cyl),
    "exactly two predictor"
  )
})

test_that("plot_3d_regression rejects missing variables", {
  expect_error(
    plot_3d_regression(mtcars, mpg ~ hp + nonexistent),
    "nonexistent"
  )
})

test_that("plot_3d_regression rejects non-numeric variables", {
  df <- mtcars
  df$cyl_chr <- as.character(df$cyl)
  expect_error(
    plot_3d_regression(df, mpg ~ hp + cyl_chr),
    "must be numeric"
  )
})

test_that("plot_3d_regression rejects in-formula transformations", {
  expect_error(
    plot_3d_regression(mtcars, log(mpg) ~ hp + wt),
    "transformations.*not supported"
  )
  expect_error(
    plot_3d_regression(mtcars, mpg ~ log(hp) + wt),
    "transformations.*not supported"
  )
  expect_error(
    plot_3d_regression(mtcars, mpg ~ I(hp^2) + wt),
    "transformations.*not supported"
  )
})

test_that("plot_3d_regression errors helpfully if plotly is not installed", {
  testthat::local_mocked_bindings(
    is_plotly_available = function() FALSE,
    .package            = "moderndive"
  )

  expect_error(
    plot_3d_regression(mtcars, mpg ~ hp + wt),
    "requires the `plotly` package"
  )
})

test_that("plot_3d_regression returns a plotly object on the happy path", {
  skip_if_not_installed("plotly")

  # Capture the args build_3d_plot would receive. We don't actually call
  # plotly here — the rendering branch is marked nocov.
  captured <- NULL
  testthat::local_mocked_bindings(
    build_3d_plot = function(data, outcome_var, predictor_vars,
                             x_seq, y_seq, z_pred) {
      captured <<- list(
        data           = data,
        outcome_var    = outcome_var,
        predictor_vars = predictor_vars,
        x_seq          = x_seq,
        y_seq          = y_seq,
        z_pred         = z_pred
      )
      structure(list(), class = "plotly")
    },
    .package = "moderndive"
  )

  out <- plot_3d_regression(mtcars, mpg ~ hp + wt, n = 10)
  expect_s3_class(out, "plotly")

  expect_identical(captured$outcome_var, "mpg")
  expect_identical(captured$predictor_vars, c("hp", "wt"))
  expect_length(captured$x_seq, 10L)
  expect_length(captured$y_seq, 10L)
  expect_equal(dim(captured$z_pred), c(10L, 10L))

  # The grid spans the data range
  expect_equal(min(captured$x_seq), min(mtcars$hp))
  expect_equal(max(captured$x_seq), max(mtcars$hp))
  expect_equal(min(captured$y_seq), min(mtcars$wt))
  expect_equal(max(captured$y_seq), max(mtcars$wt))

  # Plane heights should match a directly-fitted lm on the same formula
  fitted_lm <- lm(mpg ~ hp + wt, data = mtcars)
  grid <- expand.grid(hp = captured$x_seq, wt = captured$y_seq)
  expected_z <- matrix(predict(fitted_lm, grid), nrow = 10)
  expect_equal(captured$z_pred, expected_z, tolerance = 1e-8)
})
