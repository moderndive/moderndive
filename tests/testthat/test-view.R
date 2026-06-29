context("view")

test_that("View() renders a DT datatable inline when non-interactive", {
  # R CMD check / Rscript runs are non-interactive, so no mocking needed.
  expect_false(interactive())

  captured <- NULL
  testthat::local_mocked_bindings(
    view_datatable = function(x, title, ...) {
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
    view_datatable = function(x, title, ...) {
      captured <<- list(x = x, title = title)
      invisible(NULL)
    },
    .package = "moderndive"
  )

  suppressMessages(View(un_member_states_2024, title = "my custom title"))

  expect_identical(captured$title, "my custom title")
})

test_that("View() forwards n / full / seed / quiet to view_datatable()", {
  captured <- NULL
  testthat::local_mocked_bindings(
    view_datatable = function(x, title, n, full, seed, quiet) {
      captured <<- list(n = n, full = full, seed = seed, quiet = quiet)
      invisible(NULL)
    },
    .package = "moderndive"
  )

  suppressMessages(
    View(un_member_states_2024, n = 50, full = TRUE, seed = 42, quiet = TRUE)
  )

  expect_identical(captured$n, 50)
  expect_true(captured$full)
  expect_identical(captured$seed, 42)
  expect_true(captured$quiet)
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

# ---- sampling behaviour for large data --------------------------------------

test_that("view_datatable() samples down to n rows for large data (default)", {
  big <- data.frame(id = 1:5000, x = seq_len(5000))
  expect_message(
    result <- view_datatable(big, title = "Data: big", n = 1000),
    "random sample of 1,000 of 5,000 rows"
  )
  expect_equal(nrow(result$x$data), 1000)
})

test_that("view_datatable(full = TRUE) shows every row", {
  big <- data.frame(id = 1:5000, x = seq_len(5000))
  result <- view_datatable(big, title = "Data: big", full = TRUE)
  expect_equal(nrow(result$x$data), 5000)
})

test_that("view_datatable() leaves small data untouched (no message, no sample)", {
  small <- data.frame(id = 1:50)
  expect_silent(result <- view_datatable(small, title = "Data: small", n = 1000))
  expect_equal(nrow(result$x$data), 50)
})

test_that("view_datatable(seed = ) gives a reproducible sample", {
  big <- data.frame(id = 1:5000)
  r1 <- suppressMessages(view_datatable(big, title = "t", n = 100, seed = 42))
  r2 <- suppressMessages(view_datatable(big, title = "t", n = 100, seed = 42))
  expect_identical(r1$x$data$id, r2$x$data$id)
})

test_that("view_datatable(quiet = TRUE) suppresses the sample message", {
  big <- data.frame(id = 1:5000)
  expect_silent(view_datatable(big, title = "t", n = 100, quiet = TRUE))
})

test_that("sampling does not disturb the caller's RNG stream", {
  big <- data.frame(id = 1:5000)
  set.seed(76)
  a <- runif(1)
  set.seed(76)
  invisible(suppressMessages(view_datatable(big, title = "t", n = 100)))
  b <- runif(1)
  expect_equal(a, b)
})

test_that("sample_rows() preserves RNG and honours seed", {
  # reproducible with a seed
  s1 <- sample_rows(5000, 100, seed = 42)
  s2 <- sample_rows(5000, 100, seed = 42)
  expect_identical(s1, s2)
  # different seed -> (almost surely) different draw
  expect_false(identical(sample_rows(5000, 100, seed = 1),
                         sample_rows(5000, 100, seed = 2)))
  # global stream untouched even when a seed is passed
  set.seed(1)
  a <- runif(1)
  set.seed(1)
  invisible(sample_rows(5000, 100, seed = 42))
  b <- runif(1)
  expect_equal(a, b)
})

test_that("webr_html_table() builds a self-contained HTML table", {
  html <- webr_html_table(head(mtcars, 3), "Data: mtcars")
  expect_true(grepl("<table", html, fixed = TRUE))
  expect_true(grepl("Data: mtcars", html, fixed = TRUE))
  expect_true(grepl("<th>mpg</th>", html, fixed = TRUE))
  # self-contained: no external scripts or resources
  expect_false(grepl("<script", html, fixed = TRUE))
  expect_false(grepl("src=", html, fixed = TRUE))
  expect_false(grepl("href=", html, fixed = TRUE))
  # HTML-special characters in cells are escaped
  esc <- webr_html_table(data.frame(x = "a<b>&c", stringsAsFactors = FALSE), "t")
  expect_true(grepl("a&lt;b&gt;&amp;c", esc, fixed = TRUE))
})

test_that("in webR, view_datatable() pushes a static table through the viewer", {
  old_env <- Sys.getenv("WEBR", unset = NA)
  old_viewer <- getOption("viewer")
  Sys.setenv(WEBR = "1")
  on.exit({
    if (is.na(old_env)) Sys.unsetenv("WEBR") else Sys.setenv(WEBR = old_env)
    options(viewer = old_viewer)
  }, add = TRUE)
  pushed <- NULL
  options(viewer = function(url, ...) pushed <<- url)
  out <- view_datatable(head(mtcars, 3), "Data: mtcars")
  expect_null(out)
  expect_true(!is.null(pushed) && file.exists(pushed))
  expect_true(grepl("<table",
                    paste(readLines(pushed), collapse = ""), fixed = TRUE))
})

test_that("outside webR, view_datatable() still returns a DT widget", {
  skip_if_not_installed("DT")
  old_env <- Sys.getenv("WEBR", unset = NA)
  Sys.setenv(WEBR = "")
  on.exit(
    if (is.na(old_env)) Sys.unsetenv("WEBR") else Sys.setenv(WEBR = old_env),
    add = TRUE
  )
  expect_s3_class(view_datatable(head(mtcars, 3), "x"), "datatables")
})
