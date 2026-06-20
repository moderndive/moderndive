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
View(x, title = NULL)
```

## Arguments

- x:

  an R object which can be coerced to a data frame.

- title:

  title for the viewer window. Defaults to the name of `x` prefixed by
  `Data: `, matching the convention used by
  [`utils::View()`](https://rdrr.io/r/utils/View.html).

## Value

In an interactive session, invisibly returns `NULL` (called for the side
effect of displaying `x` in a viewer). In a non-interactive session,
returns a [`DT::datatable()`](https://rdrr.io/pkg/DT/man/datatable.html)
htmlwidget.

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
} # }
```
