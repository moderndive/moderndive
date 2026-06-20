# Get regression points

Output information on each point/observation used in an
[`lm()`](https://rdrr.io/r/stats/lm.html) regression in "tidy" format.
This function is a wrapper function for
[`broom::augment()`](https://generics.r-lib.org/reference/augment.html)
and renames the variables to have more intuitive names.

## Usage

``` r
get_regression_points(
  model,
  digits = 3,
  print = FALSE,
  newdata = NULL,
  ID = NULL
)
```

## Arguments

- model:

  an [`lm()`](https://rdrr.io/r/stats/lm.html) or
  [`glm()`](https://rdrr.io/r/stats/glm.html) model object

- digits:

  number of digits precision in output table

- print:

  If TRUE, return in print format suitable for R Markdown

- newdata:

  A new data frame of points/observations to apply `model` to obtain new
  fitted values and/or predicted values y-hat. Note the format of
  `newdata` must match the format of the original `data` used to fit
  `model`.

- ID:

  A string indicating which variable in either the original data used to
  fit `model` or `newdata` should be used as an identification variable
  to distinguish the observational units in each row. This variable will
  be the left-most variable in the output data frame. If `ID` is
  unspecified, a column `ID` with values 1 through the number of rows is
  returned as the identification variable.

## Value

A tibble-formatted regression table of outcome/response variable, all
explanatory/predictor variables, the fitted/predicted value, and
residual.

## See also

[`augment()`](https://broom.tidymodels.org/reference/reexports.html),
[`get_regression_table()`](https://moderndive.github.io/moderndive/reference/get_regression_table.md),
[`get_regression_summaries()`](https://moderndive.github.io/moderndive/reference/get_regression_summaries.md)

## Examples

``` r
library(dplyr)
library(moderndive)

# Fit lm() regression:
life_exp_model <- lm(
  life_expectancy_2022 ~ gdp_per_capita,
  data = un_member_states_2024
)

# Get information on all points in regression:
get_regression_points(life_exp_model, ID = "country")
#> # A tibble: 188 × 5
#>    country   life_expectancy_2022 gdp_per_capita life_expectancy_2022…¹ residual
#>    <chr>                    <dbl>          <dbl>                  <dbl>    <dbl>
#>  1 Afghanis…                 53.6           356.                   71.5   -17.8 
#>  2 Albania                   79.5          6810.                   72.3     7.17
#>  3 Algeria                   78.0          4343.                   72.0     6.05
#>  4 Andorra                   83.4         41993.                   76.9     6.49
#>  5 Angola                    62.1          3000.                   71.8    -9.69
#>  6 Antigua …                 77.8         19920.                   74.0     3.77
#>  7 Argentina                 78.3         13651.                   73.2     5.11
#>  8 Armenia                   76.1          7018.                   72.3     3.80
#>  9 Australia                 83.1         65100.                   80.0     3.13
#> 10 Austria                   82.3         52085.                   78.3     4.02
#> # ℹ 178 more rows
#> # ℹ abbreviated name: ¹​life_expectancy_2022_hat

# Create training and test set based on un_member_states_2024:
training_set <- un_member_states_2024 %>%
  sample_frac(0.5)
test_set <- un_member_states_2024 %>%
  anti_join(training_set, by = "country")

# Fit model to training set:
life_exp_model_train <- lm(
  life_expectancy_2022 ~ gdp_per_capita,
  data = training_set
)

# Make predictions on test set:
get_regression_points(life_exp_model_train, newdata = test_set, ID = "country")
#> # A tibble: 94 × 5
#>    country   life_expectancy_2022 gdp_per_capita life_expectancy_2022…¹ residual
#>    <chr>                    <dbl>          <dbl>                  <dbl>    <dbl>
#>  1 Afghanis…                 53.6           356.                   72.4  -18.7  
#>  2 Algeria                   78.0          4343.                   72.9    5.14 
#>  3 Antigua …                 77.8         19920.                   74.8    3.00 
#>  4 Barbados                  78.6         20239.                   74.8    3.71 
#>  5 Belarus                   74.3          7888.                   73.3    0.96 
#>  6 Belize                    75.8          6984.                   73.2    2.61 
#>  7 Benin                     62.2          1303.                   72.5  -10.3  
#>  8 Bhutan                    72.3          3560.                   72.8   -0.479
#>  9 Bolivia                   72.5          3600.                   72.8   -0.294
#> 10 Burkina …                 63.4           830.                   72.5   -9.01 
#> # ℹ 84 more rows
#> # ℹ abbreviated name: ¹​life_expectancy_2022_hat
```
