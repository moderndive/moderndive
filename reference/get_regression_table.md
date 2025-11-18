# Get regression table

Output regression table for an [`lm()`](https://rdrr.io/r/stats/lm.html)
regression in "tidy" format. This function is a wrapper function for
[`broom::tidy()`](https://generics.r-lib.org/reference/tidy.html) and
includes confidence intervals in the output table by default.

## Usage

``` r
get_regression_table(
  model,
  conf.level = 0.95,
  digits = 3,
  print = FALSE,
  default_categorical_levels = FALSE
)
```

## Arguments

- model:

  an [`lm()`](https://rdrr.io/r/stats/lm.html) model object

- conf.level:

  The confidence level to use for the confidence interval if
  `conf.int = TRUE`. Must be strictly greater than 0 and less than 1.
  Defaults to 0.95, which corresponds to a 95 percent confidence
  interval.

- digits:

  number of digits precision in output table

- print:

  If TRUE, return in print format suitable for R Markdown

- default_categorical_levels:

  If TRUE, do not change the non-baseline categorical variables in the
  term column. Otherwise non-baseline categorical variables will be
  displayed in the format "categorical_variable_name-level_name"

## Value

A tibble-formatted regression table along with lower and upper end
points of all confidence intervals for all parameters `lower_ci` and
`upper_ci`; the confidence levels default to 95\\

## See also

[`tidy()`](https://broom.tidymodels.org/reference/reexports.html),
[`get_regression_points()`](moderndive.github.io/moderndive/reference/get_regression_points.md),
[`get_regression_summaries()`](moderndive.github.io/moderndive/reference/get_regression_summaries.md)

## Examples

``` r
library(moderndive)

# Fit lm() regression:
mpg_model <- lm(mpg ~ cyl, data = mtcars)

# Get regression table:
get_regression_table(mpg_model)
#> # A tibble: 2 × 7
#>   term      estimate std_error statistic p_value lower_ci upper_ci
#>   <chr>        <dbl>     <dbl>     <dbl>   <dbl>    <dbl>    <dbl>
#> 1 intercept    37.9      2.07      18.3        0    33.6     42.1 
#> 2 cyl          -2.88     0.322     -8.92       0    -3.53    -2.22

# Vary confidence level of confidence intervals
get_regression_table(mpg_model, conf.level = 0.99)
#> # A tibble: 2 × 7
#>   term      estimate std_error statistic p_value lower_ci upper_ci
#>   <chr>        <dbl>     <dbl>     <dbl>   <dbl>    <dbl>    <dbl>
#> 1 intercept    37.9      2.07      18.3        0    32.2     43.6 
#> 2 cyl          -2.88     0.322     -8.92       0    -3.76    -1.99
```
