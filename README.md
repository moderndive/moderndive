
moderndive R Package <img src="https://github.com/moderndive/moderndive/blob/master/images/hex_blue_text.png?raw=true" align="right" width=125 />
-------------------------------------------------------------------------------------------------------------------------------------------------

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/moderndive)](https://cran.r-project.org/package=moderndive) [![Travis-CI Build Status](https://travis-ci.org/moderndive/moderndive.svg?branch=master)](https://travis-ci.org/moderndive/moderndive) [![Coverage Status](https://img.shields.io/codecov/c/github/moderndive/moderndive/master.svg)](https://codecov.io/github/moderndive/moderndive?branch=master)[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/moderndive)](http://www.r-pkg.org/pkg/moderndive)

An R package of datasets and wrapper functions for [tidyverse](https://www.tidyverse.org/)-friendly introductory linear regression used in

-   ModernDive: An Introduction to Statistical and Data Sciences via R available at [ModernDive.com](http://moderndive.com/)
-   DataCamp's [Modeling with Data in the Tidyverse](https://www.datacamp.com/courses/modeling-with-data-in-the-tidyverse)

Installation
------------

Get the released version from CRAN:

``` r
install.packages("moderndive")
```

Or the development version from GitHub:

``` r
# If you haven't installed remotes yet, do so:
# install.packages("remotes")
remotes::install_github("moderndive/moderndive")
```

Demo
----

The following three `get_regression_OUTPUT()` functions are tidyverse-friendly wrapper functions meant for the novice regression user. They have more intuitive/verb-like function names than the corresponding `broom` package commands:

-   `get_regression_table()`: a wrapper to `tidy()` to return the regression table
-   `get_regression_points()`: a wrapper to `augment()` to return a table of all regression points
-   `get_regression_summaries()`: a wrapper to `glance()` to return summary statistics about the regression

Furthermore

-   `get_regression_table()` returns confidence intervals (not just p-values) by default
-   The outputs are returned as [tibbles](https://blog.rstudio.com/2016/03/24/tibble-1-0-0/)
-   It cleans the output format by eliminating all information not pertinent to novice regression users
-   You can set the output to be in `knitr::kable()` markdown format, suitable for printing in R Markdown documents, via `print = TRUE`

``` r
library(moderndive)
library(dplyr)
```

``` r
# Convert cyl to factor variable
mtcars <- mtcars %>% 
  mutate(cyl = as.factor(cyl))

# Regression models
mpg_model <- lm(mpg ~ hp, data = mtcars)
mpg_mlr_model <- lm(mpg ~ hp + wt, data = mtcars)
mpg_mlr_model2 <- lm(mpg ~ hp + cyl, data = mtcars)

# Regression tables
get_regression_table(model = mpg_model)
```

    ## # A tibble: 2 x 7
    ##   term      estimate std_error statistic p_value lower_ci upper_ci
    ##   <chr>        <dbl>     <dbl>     <dbl>   <dbl>    <dbl>    <dbl>
    ## 1 intercept   30.1        1.63     18.4        0   26.8     33.4  
    ## 2 hp          -0.068      0.01     -6.74       0   -0.089   -0.048

``` r
get_regression_table(mpg_mlr_model, digits = 4, print = TRUE)
```

| term      |  estimate|  std\_error|  statistic|  p\_value|  lower\_ci|  upper\_ci|
|:----------|---------:|-----------:|----------:|---------:|----------:|----------:|
| intercept |   37.2273|      1.5988|    23.2847|    0.0000|    33.9574|    40.4972|
| hp        |   -0.0318|      0.0090|    -3.5187|    0.0015|    -0.0502|    -0.0133|
| wt        |   -3.8778|      0.6327|    -6.1287|    0.0000|    -5.1719|    -2.5837|

``` r
# Regression points. For residual analysis for example
get_regression_points(mpg_mlr_model2)
```

    ## # A tibble: 32 x 6
    ##       ID   mpg    hp cyl   mpg_hat residual
    ##    <int> <dbl> <dbl> <fct>   <dbl>    <dbl>
    ##  1     1  21     110 6        20.0    0.962
    ##  2     2  21     110 6        20.0    0.962
    ##  3     3  22.8    93 4        26.4   -3.62 
    ##  4     4  21.4   110 6        20.0    1.36 
    ##  5     5  18.7   175 8        15.9    2.78 
    ##  6     6  18.1   105 6        20.2   -2.06 
    ##  7     7  14.3   245 8        14.2    0.06 
    ##  8     8  24.4    62 4        27.2   -2.76 
    ##  9     9  22.8    95 4        26.4   -3.57 
    ## 10    10  19.2   123 6        19.7   -0.526
    ## # ... with 22 more rows

``` r
mtcars_new <- mtcars %>% 
  slice(1:3)

# Make predictions on newdata
get_regression_points(mpg_mlr_model2, newdata = mtcars_new)
```

    ## # A tibble: 3 x 6
    ##      ID   mpg    hp cyl   mpg_hat residual
    ##   <int> <dbl> <dbl> <fct>   <dbl>    <dbl>
    ## 1     1  21     110 6        20.0    0.962
    ## 2     2  21     110 6        20.0    0.962
    ## 3     3  22.8    93 4        26.4   -3.62

``` r
# Regression summaries
get_regression_summaries(mpg_model)
```

    ## # A tibble: 1 x 8
    ##   r_squared adj_r_squared   mse  rmse sigma statistic p_value    df
    ##       <dbl>         <dbl> <dbl> <dbl> <dbl>     <dbl>   <dbl> <dbl>
    ## 1     0.602         0.589  14.0  3.74  3.86      45.5       0     2

``` r
# Can also use `%>%`
mpg_model %>% get_regression_summaries(digits = 5, print = TRUE)
```

|  r\_squared|  adj\_r\_squared|       mse|      rmse|    sigma|  statistic|  p\_value|   df|
|-----------:|----------------:|---------:|---------:|--------:|----------:|---------:|----:|
|     0.60244|          0.58919|  13.98982|  3.740297|  3.86296|    45.4598|         0|    2|

------------------------------------------------------------------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
