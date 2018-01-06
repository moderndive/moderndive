
ModernDive R Package <img src="https://github.com/moderndive/moderndive/blob/master/images/hex_blue_text.png?raw=true" align="right" width=125 />
-------------------------------------------------------------------------------------------------------------------------------------------------

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/moderndive)](https://cran.r-project.org/package=moderndive) [![Travis-CI Build Status](https://travis-ci.org/moderndive/moderndive.svg?branch=master)](https://travis-ci.org/moderndive/moderndive)

Accompaniment R Package to ModernDive - An Introduction to Statistical and Data Sciences via R available at <http://moderndive.com/>.

Installation
------------

Get the released version from CRAN:

``` r
install.packages("moderndive")
```

Or the development version from GitHub:

``` r
# If you haven't installed devtools yet, do so:
# install.packages("devtools")
devtools::install_github("moderndive/moderndive")
```

Demo
----

The following three `get_regression_OUTPUT()` functions are tidyverse-friendly wrappers meant for the novice regression user. They have more intuitive/verb-like function names than the corresponding `broom` commands:

-   `get_regression_table()`: a wrapper to `tidy()` to return the regression table.
-   `get_regression_points()`: a wrapper to `augment()` to return a table of all regression points
-   `get_regression_summaries()`: a wrapper to `glance()` to return summary statistics about the regression

Furthermore

-   The outputs are returned as tibbles
-   It cleans the output format eliminating all information not pertinent for simple analyses
-   You can set the output to be `knitr::kable()` suitable for R Markdown output via `print = TRUE`
-   You can control the pseudoprecision via the `digits` argument

``` r
library(moderndive)
library(dplyr)

# Regression tables
get_regression_table(mpg ~ hp, data = mtcars)
```

    ## # A tibble: 2 x 7
    ##        term estimate std_error statistic p_value conf_low conf_high
    ##       <chr>    <dbl>     <dbl>     <dbl>   <dbl>    <dbl>     <dbl>
    ## 1 intercept   30.099     1.634    18.421       0   26.762    33.436
    ## 2        hp   -0.068     0.010    -6.742       0   -0.089    -0.048

``` r
get_regression_table(mpg ~ hp + wt, data = mtcars, digits = 4, print = TRUE)
```

| term      |  estimate|  std\_error|  statistic|  p\_value|  conf\_low|  conf\_high|
|:----------|---------:|-----------:|----------:|---------:|----------:|-----------:|
| intercept |   37.2273|      1.5988|    23.2847|    0.0000|    33.9574|     40.4972|
| hp        |   -0.0318|      0.0090|    -3.5187|    0.0015|    -0.0502|     -0.0133|
| wt        |   -3.8778|      0.6327|    -6.1287|    0.0000|    -5.1719|     -2.5837|

``` r
# Regression points. For residual analysis for example
mtcars <- mtcars %>% 
  mutate(cyl = as.factor(cyl))
get_regression_points(mpg ~ hp + cyl, data = mtcars)
```

    ## # A tibble: 32 x 5
    ##      mpg    hp    cyl mpg_hat residual
    ##    <dbl> <dbl> <fctr>   <dbl>    <dbl>
    ##  1  21.0   110      6  20.038    0.962
    ##  2  21.0   110      6  20.038    0.962
    ##  3  22.8    93      4  26.415   -3.615
    ##  4  21.4   110      6  20.038    1.362
    ##  5  18.7   175      8  15.922    2.778
    ##  6  18.1   105      6  20.158   -2.058
    ##  7  14.3   245      8  14.240    0.060
    ##  8  24.4    62      4  27.160   -2.760
    ##  9  22.8    95      4  26.366   -3.566
    ## 10  19.2   123      6  19.726   -0.526
    ## # ... with 22 more rows

``` r
# Regression summaries
get_regression_summaries(mpg ~ hp, data = mtcars)
```

    ## # A tibble: 1 x 6
    ##   r_squared adj_r_squared sigma statistic p_value    df
    ##       <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>
    ## 1     0.602         0.589 3.863     45.46       0     2

``` r
get_regression_summaries(mpg ~ hp, data = mtcars, digits = 5, print = TRUE)
```

|  r\_squared|  adj\_r\_squared|    sigma|  statistic|  p\_value|   df|
|-----------:|----------------:|--------:|----------:|---------:|----:|
|     0.60244|          0.58919|  3.86296|    45.4598|         0|    2|

------------------------------------------------------------------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
