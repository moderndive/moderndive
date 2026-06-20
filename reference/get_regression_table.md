# Get regression table

Output regression table for an [`lm()`](https://rdrr.io/r/stats/lm.html)
or [`glm()`](https://rdrr.io/r/stats/glm.html) model in "tidy" format.
This function is a wrapper function for
[`broom::tidy()`](https://generics.r-lib.org/reference/tidy.html) and
includes confidence intervals in the output table by default.

## Usage

``` r
get_regression_table(
  model,
  conf.level = 0.95,
  digits = 3,
  print = FALSE,
  default_categorical_levels = FALSE,
  exponentiate = FALSE
)
```

## Arguments

- model:

  an [`lm()`](https://rdrr.io/r/stats/lm.html) or
  [`glm()`](https://rdrr.io/r/stats/glm.html) model object

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

- exponentiate:

  If TRUE, exponentiate the coefficient estimates and confidence
  intervals. Useful for [`glm()`](https://rdrr.io/r/stats/glm.html)
  models with log or logit links (returns rate or odds ratios
  respectively). Default `FALSE`.

## Value

A tibble-formatted regression table along with lower and upper end
points of all confidence intervals for all parameters `lower_ci` and
`upper_ci`; the confidence levels default to 95\\

## See also

[`tidy()`](https://broom.tidymodels.org/reference/reexports.html),
[`get_regression_points()`](https://moderndive.github.io/moderndive/reference/get_regression_points.md),
[`get_regression_summaries()`](https://moderndive.github.io/moderndive/reference/get_regression_summaries.md)

## Examples

``` r
library(moderndive)

# Fit lm() regression:
life_exp_model <- lm(
  life_expectancy_2022 ~ gdp_per_capita,
  data = un_member_states_2024
)

# Get regression table:
get_regression_table(life_exp_model)
#> # A tibble: 2 × 7
#>   term           estimate std_error statistic p_value lower_ci upper_ci
#>   <chr>             <dbl>     <dbl>     <dbl>   <dbl>    <dbl>    <dbl>
#> 1 intercept          71.4     0.479    149.         0     70.5     72.4
#> 2 gdp_per_capita      0       0          9.85       0      0        0  

# Vary confidence level of confidence intervals
get_regression_table(life_exp_model, conf.level = 0.99)
#> # A tibble: 2 × 7
#>   term           estimate std_error statistic p_value lower_ci upper_ci
#>   <chr>             <dbl>     <dbl>     <dbl>   <dbl>    <dbl>    <dbl>
#> 1 intercept          71.4     0.479    149.         0     70.2     72.7
#> 2 gdp_per_capita      0       0          9.85       0      0        0  
```
