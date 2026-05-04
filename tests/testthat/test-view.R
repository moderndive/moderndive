context("view")

test_that("View() errors with an informative message when non-interactive", {
  # R CMD check / Rscript runs are non-interactive, so no mocking needed.
  expect_false(interactive())

  expect_error(
    View(mtcars),
    "interactive R session"
  )
  expect_error(
    View(mtcars),
    "R Markdown"
  )
})

test_that("View() delegates to utils::View() in an interactive session", {
  captured <- NULL

  testthat::local_mocked_bindings(
    is_interactive = function() TRUE,
    view_dispatch  = function(x, title) {
      captured <<- list(x = x, title = title)
      invisible(NULL)
    },
    .package       = "moderndive"
  )

  View(mtcars)

  expect_identical(captured$x, mtcars)
  # Title should default to "Data: <name of x>", matching utils::View() convention
  expect_identical(captured$title, "Data: mtcars")
})

test_that("View() forwards an explicit title argument", {
  captured <- NULL

  testthat::local_mocked_bindings(
    is_interactive = function() TRUE,
    view_dispatch  = function(x, title) {
      captured <<- list(x = x, title = title)
      invisible(NULL)
    },
    .package       = "moderndive"
  )

  View(mtcars, title = "my custom title")

  expect_identical(captured$title, "my custom title")
})
