context("view")

test_that("View() renders a DT datatable inline when non-interactive", {
  # R CMD check / Rscript runs are non-interactive, so no mocking needed.
  expect_false(interactive())

  captured <- NULL
  testthat::local_mocked_bindings(
    view_datatable = function(x, title) {
      captured <<- list(x = x, title = title)
      structure(list(), class = "datatables")
    },
    .package = "moderndive"
  )

  expect_message(
    result <- View(un_member_states_2024),
    "DT::datatable"
  )

  expect_s3_class(result, "datatables")
  expect_identical(captured$x, un_member_states_2024)
  expect_identical(captured$title, "Data: un_member_states_2024")
})

test_that("View() forwards an explicit title argument when non-interactive", {
  captured <- NULL
  testthat::local_mocked_bindings(
    view_datatable = function(x, title) {
      captured <<- list(x = x, title = title)
      invisible(NULL)
    },
    .package = "moderndive"
  )

  suppressMessages(View(un_member_states_2024, title = "my custom title"))

  expect_identical(captured$title, "my custom title")
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

  View(un_member_states_2024)

  expect_identical(captured$x, un_member_states_2024)
  # Title should default to "Data: <name of x>", matching utils::View() convention
  expect_identical(captured$title, "Data: un_member_states_2024")
})

test_that("View() forwards an explicit title to utils::View() interactively", {
  captured <- NULL

  testthat::local_mocked_bindings(
    is_interactive = function() TRUE,
    view_dispatch  = function(x, title) {
      captured <<- list(x = x, title = title)
      invisible(NULL)
    },
    .package       = "moderndive"
  )

  View(un_member_states_2024, title = "my custom title")

  expect_identical(captured$title, "my custom title")
})

test_that("view_datatable() returns a DT htmlwidget", {
  result <- view_datatable(un_member_states_2024, title = "Data: un_member_states_2024")
  expect_s3_class(result, "datatables")
})
