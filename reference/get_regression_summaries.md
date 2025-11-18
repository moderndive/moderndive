# Get regression summary values

Output scalar summary statistics for an
[`lm()`](https://rdrr.io/r/stats/lm.html) regression in "tidy" format.
This function is a wrapper function for
[`broom::glance()`](https://generics.r-lib.org/reference/glance.html).

## Usage

``` r
get_regression_summaries(model, digits = 3, print = FALSE)
```

## Arguments

- model:

  an [`lm()`](https://rdrr.io/r/stats/lm.html) model object

- digits:

  number of digits precision in output table

- print:

  If TRUE, return in print format suitable for R Markdown

## Value

A single-row tibble with regression summaries. Ex: `r_squared` and
`mse`.

## See also

[`glance()`](https://broom.tidymodels.org/reference/reexports.html),
[`get_regression_table()`](moderndive.github.io/moderndive/reference/get_regression_table.md),
[`get_regression_points()`](moderndive.github.io/moderndive/reference/get_regression_points.md)

## Examples

``` r
library(moderndive)

# Fit lm() regression:
mpg_model <- lm(mpg ~ cyl, data = mtcars)

# Get regression summaries:
get_regression_summaries(mpg_model)
#> # A tibble: 1 × 9
#>   r_squared adj_r_squared   mse  rmse sigma statistic p_value    df  nobs
#>       <dbl>         <dbl> <dbl> <dbl> <dbl>     <dbl>   <dbl> <dbl> <dbl>
#> 1     0.726         0.717  9.64  3.10  3.21      79.6       0     1    32
```
