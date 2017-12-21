
ModernDive R Package <img src="images/hex_blue_text.png" align="right" width=125 />
-----------------------------------------------------------------------------------

R package accompanying ModernDive: An Introduction to Statistical and Data Sciences via R available at <http://moderndive.com/>.

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

``` r
devtools::install_github("moderndive/moderndive")

# Regression tables
get_regression_table(mpg ~ hp, data = mtcars)
get_regression_table(mpg ~ hp, data = mtcars, digits = 3, print = TRUE)

# Regression points
get_regression_points(mpg ~ hp, data = mtcars)

# Regression summaries
get_regression_summaries(mpg ~ hp, data = mtcars)
get_regression_summaries(mpg ~ hp, data = mtcars, digits = 5, print = TRUE)
```
