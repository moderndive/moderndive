# View a data object inline when not in an interactive R session

A drop-in replacement for
[`utils::View()`](https://rdrr.io/r/utils/View.html). In an interactive
R session it behaves identically to
[`utils::View()`](https://rdrr.io/r/utils/View.html), opening the
RStudio / R Console data viewer. In a non-interactive context such as an
R Markdown or Quarto document, where
[`utils::View()`](https://rdrr.io/r/utils/View.html) typically errors,
it instead renders an interactive
[`DT::datatable()`](https://rdrr.io/pkg/DT/man/datatable.html) inline so
users can still inspect the data without their document failing to
render.

## Usage

``` r
View(x, title = NULL, n = 1000L, full = FALSE, seed = NULL, quiet = FALSE)
```

## Arguments

- x:

  an R object which can be coerced to a data frame.

- title:

  title for the viewer window. Defaults to the name of `x` prefixed by
  `Data: `, matching the convention used by
  [`utils::View()`](https://rdrr.io/r/utils/View.html).

- n:

  maximum number of rows to show in the inline
  [`DT::datatable()`](https://rdrr.io/pkg/DT/man/datatable.html). When
  `x` has more than `n` rows and `full = FALSE`, a random sample of `n`
  rows is shown instead of the whole data frame. Default `1000`.

- full:

  if `TRUE`, show every row of `x` in the inline table instead of
  sampling (may be slow, and `DT` may warn, for very large data).
  Default `FALSE`.

- seed:

  optional integer seed making the random sample reproducible. The
  global random-number stream is left unchanged regardless of whether
  `seed` is supplied. Default `NULL` (a fresh sample each call).

- quiet:

  if `TRUE`, suppress the message announcing that a random sample is
  being shown. Default `FALSE`.

## Value

In an interactive session, invisibly returns `NULL` (called for the side
effect of displaying `x` in a viewer). In a non-interactive session,
returns a [`DT::datatable()`](https://rdrr.io/pkg/DT/man/datatable.html)
htmlwidget – except inside webR (where pandoc is unavailable), where it
renders a self-contained static HTML table through the browser viewer
and invisibly returns `NULL`.

## Details

For large data frames a client-side
[`DT::datatable()`](https://rdrr.io/pkg/DT/man/datatable.html) is slow
and warns that the data is too big. So in non-interactive contexts, when
`x` has more than `n` rows and `full = FALSE`, `View()` shows a **random
sample** of `n` rows and emits a message saying so. This keeps "just
look at the data" fast for beginners while making the size limitation
explicit. The interactive
[`utils::View()`](https://rdrr.io/r/utils/View.html) path is unaffected
(RStudio's viewer handles large data natively), so `n` / `full` / `seed`
/ `quiet` apply only to the inline `DT` rendering.

## See also

[`utils::View()`](https://rdrr.io/r/utils/View.html),
[`DT::datatable()`](https://rdrr.io/pkg/DT/man/datatable.html)

## Examples

``` r
if (FALSE) { # \dontrun{
  # In an interactive R session, behaves like utils::View():
  View(un_member_states_2024)

  # In an R Markdown or Quarto document, renders an interactive
  # DT::datatable() inline instead of erroring:
  View(un_member_states_2024)

  # For large data a random sample is shown by default; override with:
  View(some_big_data, full = TRUE)   # all rows (may be slow)
  View(some_big_data, n = 500)       # sample 500 rows instead of 1000
  View(some_big_data, seed = 42)     # reproducible random sample
  View(some_big_data, quiet = TRUE)  # no "random sample" message
} # }
```
