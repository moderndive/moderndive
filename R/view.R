#' View a data object inline when not in an interactive R session
#'
#' A drop-in replacement for [utils::View()]. In an interactive R session
#' it behaves identically to `utils::View()`, opening the RStudio /
#' R Console data viewer. In a non-interactive context such as an
#' R Markdown or Quarto document, where `utils::View()` typically errors,
#' it instead renders an interactive [DT::datatable()] inline so users
#' can still inspect the data without their document failing to render.
#'
#' @param x an \R object which can be coerced to a data frame.
#' @param title title for the viewer window. Defaults to the name of `x`
#'   prefixed by `Data: `, matching the convention used by [utils::View()].
#'
#' @return In an interactive session, invisibly returns `NULL` (called for
#'   the side effect of displaying `x` in a viewer). In a non-interactive
#'   session, returns a [DT::datatable()] htmlwidget.
#' @export
#' @seealso [utils::View()], [DT::datatable()]
#'
#' @examples
#' \dontrun{
#'   # In an interactive R session, behaves like utils::View():
#'   View(un_member_states_2024)
#'
#'   # In an R Markdown or Quarto document, renders an interactive
#'   # DT::datatable() inline instead of erroring:
#'   View(un_member_states_2024)
#' }
View <- function(x, title = NULL) {
  if (is.null(title)) {
    title <- paste("Data:", deparse1(substitute(x)))
  }
  if (!is_interactive()) {
    message(
      "Note: base R's `View()` typically errors in non-interactive contexts ",
      "such as R Markdown or Quarto. `moderndive::View()` is set up to not ",
      "error in those contexts: it renders an interactive table inline ",
      "using `DT::datatable()` instead."
    )
    return(view_datatable(x, title))
  }
  view_dispatch(x, title)
}

# Internal wrappers so tests can mock `interactive()`, `utils::View()`, and
# the DT path via `testthat::local_mocked_bindings(.package = "moderndive")`.
# Per the testthat mocking guidance, mocking namespaced calls
# (`utils::View(...)`, `DT::datatable(...)`) from within this package is
# unreliable — wrapping them in package-local helpers makes the mocks
# straightforward.
is_interactive <- function() {
  interactive()
}
view_dispatch <- function(x, title) {
  utils::View(x, title)  # nocov
}
view_datatable <- function(x, title) {
  DT::datatable(as.data.frame(x), caption = title)
}
