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

  an [`lm()`](https://rdrr.io/r/stats/lm.html) model object

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
[`get_regression_table()`](moderndive.github.io/moderndive/reference/get_regression_table.md),
[`get_regression_summaries()`](moderndive.github.io/moderndive/reference/get_regression_summaries.md)

## Examples

``` r
library(dplyr)
library(tibble)

# Convert rownames to column
mtcars <- mtcars %>%
  rownames_to_column(var = "automobile")

# Fit lm() regression:
mpg_model <- lm(mpg ~ cyl, data = mtcars)

# Get information on all points in regression:
get_regression_points(mpg_model, ID = "automobile")
#> # A tibble: 32 × 5
#>    automobile          mpg   cyl mpg_hat residual
#>    <chr>             <dbl> <dbl>   <dbl>    <dbl>
#>  1 Mazda RX4          21       6    20.6    0.37 
#>  2 Mazda RX4 Wag      21       6    20.6    0.37 
#>  3 Datsun 710         22.8     4    26.4   -3.58 
#>  4 Hornet 4 Drive     21.4     6    20.6    0.77 
#>  5 Hornet Sportabout  18.7     8    14.9    3.82 
#>  6 Valiant            18.1     6    20.6   -2.53 
#>  7 Duster 360         14.3     8    14.9   -0.578
#>  8 Merc 240D          24.4     4    26.4   -1.98 
#>  9 Merc 230           22.8     4    26.4   -3.58 
#> 10 Merc 280           19.2     6    20.6   -1.43 
#> # ℹ 22 more rows

# Create training and test set based on mtcars:
training_set <- mtcars %>%
  sample_frac(0.5)
test_set <- mtcars %>%
  anti_join(training_set, by = "automobile")

# Fit model to training set:
mpg_model_train <- lm(mpg ~ cyl, data = training_set)

# Make predictions on test set:
get_regression_points(mpg_model_train, newdata = test_set, ID = "automobile")
#> # A tibble: 16 × 5
#>    automobile            mpg   cyl mpg_hat residual
#>    <chr>               <dbl> <dbl>   <dbl>    <dbl>
#>  1 Mazda RX4            21       6    20.4    0.629
#>  2 Datsun 710           22.8     4    25.8   -2.96 
#>  3 Duster 360           14.3     8    15.0   -0.684
#>  4 Merc 240D            24.4     4    25.8   -1.36 
#>  5 Merc 280             19.2     6    20.4   -1.17 
#>  6 Merc 450SLC          15.2     8    15.0    0.216
#>  7 Lincoln Continental  10.4     8    15.0   -4.58 
#>  8 Chrysler Imperial    14.7     8    15.0   -0.284
#>  9 Fiat 128             32.4     4    25.8    6.64 
#> 10 Honda Civic          30.4     4    25.8    4.64 
#> 11 Toyota Corolla       33.9     4    25.8    8.14 
#> 12 Toyota Corona        21.5     4    25.8   -4.26 
#> 13 Pontiac Firebird     19.2     8    15.0    4.22 
#> 14 Fiat X1-9            27.3     4    25.8    1.54 
#> 15 Ford Pantera L       15.8     8    15.0    0.816
#> 16 Volvo 142E           21.4     4    25.8   -4.36 
```
