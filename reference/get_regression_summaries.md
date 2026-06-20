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

  an [`lm()`](https://rdrr.io/r/stats/lm.html) or
  [`glm()`](https://rdrr.io/r/stats/glm.html) model object

- digits:

  number of digits precision in output table

- print:

  If TRUE, return in print format suitable for R Markdown

## Value

A single-row tibble with regression summaries. Ex: `r_squared` and
`mse`.

## See also

[`glance()`](https://broom.tidymodels.org/reference/reexports.html),
[`get_regression_table()`](https://moderndive.github.io/moderndive/reference/get_regression_table.md),
[`get_regression_points()`](https://moderndive.github.io/moderndive/reference/get_regression_points.md)

## Examples

``` r
library(moderndive)

# Fit lm() regression:
life_exp_model <- lm(
  life_expectancy_2022 ~ gdp_per_capita,
  data = un_member_states_2024
)

# Get regression summaries:
get_regression_summaries(life_exp_model)
#> # A tibble: 1 × 9
#>   r_squared adj_r_squared   mse  rmse sigma statistic p_value    df  nobs
#>       <dbl>         <dbl> <dbl> <dbl> <dbl>     <dbl>   <dbl> <dbl> <dbl>
#> 1     0.343         0.339  31.4  5.60  5.63      97.0       0     1   188
```
