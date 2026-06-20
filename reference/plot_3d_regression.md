# Interactive 3D scatterplot with a fitted regression plane

Build an interactive 3D scatterplot of an outcome against two numeric
predictors, overlaid with the fitted plane from `lm(formula, data)`.
Returns a [`plotly`](https://rdrr.io/pkg/plotly/man/plotly.html)
htmlwidget that you can render in an R Markdown / Quarto document or in
the RStudio Viewer.

## Usage

``` r
plot_3d_regression(data, formula, n = 25)
```

## Arguments

- data:

  a data frame containing the three variables in `formula`.

- formula:

  a formula of the form `z ~ x + y`: a single outcome on the left-hand
  side and exactly two predictor variables on the right-hand side.
  In-formula transformations (e.g. `log(z) ~ x + y`) are not supported
  in this version — apply transformations to `data` beforehand.

- n:

  grid resolution per axis used to draw the regression plane. Default
  `25`.

## Value

A [`plotly`](https://rdrr.io/pkg/plotly/man/plotly.html) htmlwidget
object.

## Details

Requires the suggested package `plotly`. Install it with
`install.packages("plotly")` if you see an error about it being missing.

## See also

[`get_regression_table()`](https://moderndive.github.io/moderndive/reference/get_regression_table.md),
[`get_regression_points()`](https://moderndive.github.io/moderndive/reference/get_regression_points.md)

## Examples

``` r
if (FALSE) { # \dontrun{
  library(moderndive)
  plot_3d_regression(
    un_member_states_2024,
    life_expectancy_2022 ~ gdp_per_capita + fertility_rate_2022
  )
} # }
```
