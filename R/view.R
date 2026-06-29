#' View a data object inline when not in an interactive R session
#'
#' A drop-in replacement for [utils::View()]. In an interactive R session
#' it behaves identically to `utils::View()`, opening the RStudio /
#' R Console data viewer. In a non-interactive context such as an
#' R Markdown or Quarto document, where `utils::View()` typically errors,
#' it instead renders an interactive [DT::datatable()] inline so users
#' can still inspect the data without their document failing to render.
#'
#' For large data frames a client-side [DT::datatable()] is slow and warns
#' that the data is too big. So in non-interactive contexts, when `x` has more
#' than `n` rows and `full = FALSE`, `View()` shows a **random sample** of `n`
#' rows and emits a message saying so. This keeps "just look at the data" fast
#' for beginners while making the size limitation explicit. The interactive
#' `utils::View()` path is unaffected (RStudio's viewer handles large data
#' natively), so `n` / `full` / `seed` / `quiet` apply only to the inline `DT`
#' rendering.
#'
#' @param x an \R object which can be coerced to a data frame.
#' @param title title for the viewer window. Defaults to the name of `x`
#'   prefixed by `Data: `, matching the convention used by [utils::View()].
#' @param n maximum number of rows to show in the inline `DT::datatable()`.
#'   When `x` has more than `n` rows and `full = FALSE`, a random sample of
#'   `n` rows is shown instead of the whole data frame. Default `1000`.
#' @param full if `TRUE`, show every row of `x` in the inline table instead of
#'   sampling (may be slow, and `DT` may warn, for very large data).
#'   Default `FALSE`.
#' @param seed optional integer seed making the random sample reproducible.
#'   The global random-number stream is left unchanged regardless of whether
#'   `seed` is supplied. Default `NULL` (a fresh sample each call).
#' @param quiet if `TRUE`, suppress the message announcing that a random
#'   sample is being shown. Default `FALSE`.
#'
#' @return In an interactive session, invisibly returns `NULL` (called for
#'   the side effect of displaying `x` in a viewer). In a non-interactive
#'   session, returns a [DT::datatable()] htmlwidget -- except inside webR
#'   (where pandoc is unavailable), where it renders a self-contained static
#'   HTML table through the browser viewer and invisibly returns `NULL`.
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
#'
#'   # For large data a random sample is shown by default; override with:
#'   View(some_big_data, full = TRUE)   # all rows (may be slow)
#'   View(some_big_data, n = 500)       # sample 500 rows instead of 1000
#'   View(some_big_data, seed = 42)     # reproducible random sample
#'   View(some_big_data, quiet = TRUE)  # no "random sample" message
#' }
View <- function(x, title = NULL, n = 1000L, full = FALSE, seed = NULL,
                 quiet = FALSE) {
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
    return(view_datatable(x, title, n = n, full = full, seed = seed,
                          quiet = quiet))
  }
  view_dispatch(x, title)
}

# Internal wrappers so tests can mock `interactive()`, `utils::View()`, and
# the DT path via `testthat::local_mocked_bindings(.package = "moderndive")`.
# Per the testthat mocking guidance, mocking namespaced calls
# (`utils::View(...)`, `DT::datatable(...)`) from within this package is
# unreliable -- wrapping them in package-local helpers makes the mocks
# straightforward.
is_interactive <- function() {
  interactive()
}
view_dispatch <- function(x, title) {
  utils::View(x, title)  # nocov
}
view_datatable <- function(x, title, n = 1000L, full = FALSE, seed = NULL,
                           quiet = FALSE) {
  x <- as.data.frame(x)
  n_rows <- nrow(x)
  if (!isTRUE(full) && !is.na(n_rows) && n_rows > n) {
    idx <- sort(sample_rows(n_rows, n, seed))
    x <- x[idx, , drop = FALSE]
    if (!isTRUE(quiet)) {
      message(sprintf(
        paste0(
          "Showing a random sample of %s of %s rows so the interactive table ",
          "stays fast. Use `full = TRUE` for all rows, `n = <number>` to ",
          "resize the sample, `seed = <number>` to make it reproducible, or ",
          "`quiet = TRUE` to silence this message."
        ),
        format(n, big.mark = ","), format(n_rows, big.mark = ",")
      ))
    }
    title <- paste0(
      title,
      sprintf(
        " \u2014 random sample of %s of %s rows",
        format(n, big.mark = ","), format(n_rows, big.mark = ",")
      )
    )
  }
  if (in_webr()) {
    # webR has no pandoc, so a DT/htmlwidget cannot be saved as the
    # self-contained HTML the cell needs (DT::saveWidget() errors), and the
    # auto-print path is gated by interactive() == FALSE. Render a
    # self-contained static HTML table and push it through webR's viewer hook,
    # which quarto-webr turns into an inline iframe.
    return(view_webr_table(x, title))
  }
  DT::datatable(x, caption = title)
}

# TRUE when running inside webR (wasm R in the browser), where the DT path is
# unavailable (no pandoc); see view_webr_table().
in_webr <- function() {
  nzchar(Sys.getenv("WEBR")) || identical(R.version$os, "emscripten")
}

# Render `x` as a self-contained static HTML table and hand it to webR's viewer
# (installed by `webr::viewer_install()`), which emits a 'browse' message that
# the quarto-webr cell renders in an iframe. Needs no pandoc / htmlwidget deps.
view_webr_table <- function(x, title) {
  viewer <- getOption("viewer")
  if (!is.function(viewer)) {
    return(DT::datatable(x, caption = title))  # no webR viewer hook; fall back
  }
  f <- tempfile(fileext = ".html")
  writeLines(enc2utf8(webr_html_table(x, title)), f, useBytes = TRUE)
  viewer(f)
  invisible(NULL)
}

# Build a single self-contained HTML document: a scrollable, styled <table>
# with inline CSS only (no external JS/CSS), so it renders inside the cell's
# iframe verbatim.
webr_html_table <- function(x, caption) {
  x <- as.data.frame(x)
  esc <- function(s) {
    s <- gsub("&", "&amp;", s, fixed = TRUE)
    s <- gsub("<", "&lt;", s, fixed = TRUE)
    gsub(">", "&gt;", s, fixed = TRUE)
  }
  col_cells <- function(col) {
    out <- if (is.numeric(col)) {
      format(col, trim = TRUE, big.mark = ",", justify = "none")
    } else {
      as.character(col)
    }
    out[is.na(col)] <- "NA"
    esc(out)
  }
  cols <- lapply(x, col_cells)
  header <- paste0("<th>", esc(names(x)), "</th>", collapse = "")
  rows <- vapply(seq_len(nrow(x)), function(i) {
    cells <- paste0("<td>", vapply(cols, `[[`, character(1), i), "</td>",
                    collapse = "")
    paste0("<tr>", cells, "</tr>")
  }, character(1))
  style <- paste0(
    "<style>",
    "*{box-sizing:border-box}",
    "body{font-family:system-ui,-apple-system,Segoe UI,Roboto,sans-serif;",
    "margin:0;padding:0;color:#1b1b1b}",
    ".md-cap{font-weight:600;padding:8px 10px 4px;font-size:14px}",
    ".md-wrap{overflow:auto;max-height:460px;border:1px solid #e1e4e8;",
    "border-radius:6px;margin:6px}",
    "table{border-collapse:collapse;width:100%;font-size:13px}",
    "thead th{position:sticky;top:0;background:#1F3A6B;color:#fff;",
    "text-align:left;padding:6px 10px;white-space:nowrap}",
    "tbody td{border-top:1px solid #eaecef;padding:4px 10px;white-space:nowrap}",
    "tbody tr:nth-child(even){background:#f6f8fa}",
    "</style>"
  )
  paste0(
    "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"utf-8\">", style,
    "</head><body><div class=\"md-cap\">", esc(caption), "</div>",
    "<div class=\"md-wrap\"><table><thead><tr>", header,
    "</tr></thead><tbody>", paste0(rows, collapse = ""),
    "</tbody></table></div></body></html>"
  )
}

# Draw `size` row indices from seq_len(n_rows) -- optionally reproducibly via
# `seed` -- WITHOUT disturbing the caller's RNG stream, so an interleaved
# set.seed()/sample() in user code stays reproducible.
sample_rows <- function(n_rows, size, seed = NULL) {
  if (exists(".Random.seed", envir = globalenv(), inherits = FALSE)) {
    old <- get(".Random.seed", envir = globalenv(), inherits = FALSE)
    on.exit(assign(".Random.seed", old, envir = globalenv()), add = TRUE)
  }
  if (!is.null(seed)) {
    set.seed(seed)
  }
  sample.int(n_rows, size)
}
