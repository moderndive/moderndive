#' View a data object with a clearer error in non-interactive contexts
#'
#' A drop-in replacement for [utils::View()] that emits an actionable error
#' when called from a non-interactive context such as an R Markdown or
#' Quarto document, rather than the cryptic platform-specific errors
#' `utils::View()` produces. Behaves identically to `utils::View()` in an
#' interactive R session.
#'
#' @param x an \R object which can be coerced to a data frame with
#'   non-zero numbers of rows and columns.
#' @param title title for the viewer window. Defaults to the name of `x`
#'   prefixed by `Data: `, matching the convention used by [utils::View()].
#'
#' @return Invisibly returns `NULL`. Called for the side effect of
#'   displaying `x` in a viewer.
#' @export
#' @seealso [utils::View()]
#'
#' @examples
#' \dontrun{
#'   # In an interactive R session, behaves like utils::View():
#'   View(mtcars)
#' }
View <- function(x, title = NULL) {
  if (!is_interactive()) {
    stop(
      "`View()` only works in an interactive R session. ",
      "It cannot be used inside R Markdown, Quarto, or other ",
      "non-interactive contexts. Try `print(head(x))`, ",
      "`dplyr::glimpse(x)`, or `knitr::kable(head(x))` instead.",
      call. = FALSE
    )
  }
  if (is.null(title)) {
    title <- paste("Data:", deparse1(substitute(x)))
  }
  view_dispatch(x, title)
}

# Internal wrappers so tests can mock both `interactive()` and `utils::View()`
# via `testthat::local_mocked_bindings(.package = "moderndive")`. Per the
# testthat mocking guidance, mocking namespaced calls (`utils::View(...)`)
# from within this package is unreliable — wrapping them in package-local
# helpers makes the mocks straightforward.
is_interactive <- function() {
  interactive()
}
view_dispatch <- function(x, title) {
  utils::View(x, title)  # nocov
}
