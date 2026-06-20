.onAttach <- function(libname, pkgname) {
  if (!interactive()) {
    packageStartupMessage(
      "moderndive's `View()` renders a DT::datatable() inline here ",
      "instead of erroring like `utils::View()`."
    )
  }
}
