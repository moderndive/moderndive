
## moderndive R Package <img src="https://github.com/moderndive/moderndive/blob/master/images/hex_blue_text.png?raw=true" align="right" width=125 />

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/moderndive)](https://cran.r-project.org/package=moderndive)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![Travis-CI Build
Status](https://travis-ci.org/moderndive/moderndive.svg?branch=master)](https://travis-ci.org/moderndive/moderndive)
[![GitHub Actions
Status](https://github.com/moderndive/moderndive/workflows/R-CMD-check/badge.svg)](https://github.com/moderndive/moderndive/actions)
[![Coverage
Status](https://img.shields.io/codecov/c/github/moderndive/moderndive/master.svg)](https://codecov.io/github/moderndive/moderndive?branch=master)
[![CRAN RStudio mirror
downloads](http://cranlogs.r-pkg.org/badges/moderndive)](http://www.r-pkg.org/pkg/moderndive)

An R package of datasets and wrapper functions for
[tidyverse](https://www.tidyverse.org/)-friendly introductory linear
regression used in "Statistical Inference via Data Science: A ModernDive
into R and the Tidyverse"" available at
[ModernDive.com](https://moderndive.com/).

## Installation

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

## Demo

Let’s fit a simple linear regression of teaching `score` (as evaluated
by students) over instructor age for 463 courses taught by 94
instructors at the UT Austin:

``` r
library(moderndive)
score_model <- lm(score ~ age, data = evals)
```

Among the many useful features of the `moderndive` package outlined in
our essay [“Why should you use the moderndive package for intro linear
regression?”](https://moderndive.github.io/moderndive/articles/why-moderndive.html)
we highlight three functions in particular as covered there.

We also mention the `geom_parallel_slopes()` function as **\#4**.

#### 1\. Get regression tables

Get a tidy regression table **with** confidence intervals:

``` r
get_regression_table(score_model)
```

    ## # A tibble: 2 x 7
    ##   term      estimate std_error statistic p_value lower_ci upper_ci
    ##   <chr>        <dbl>     <dbl>     <dbl>   <dbl>    <dbl>    <dbl>
    ## 1 intercept    4.46      0.127     35.2    0        4.21     4.71 
    ## 2 age         -0.006     0.003     -2.31   0.021   -0.011   -0.001

#### 2\. Get fitted/predicted values and residuals

Get information on each point/observation in your regression, including
fitted/predicted values & residuals, organized in a single data frame
with intuitive variable names:

``` r
get_regression_points(score_model)
```

    ## # A tibble: 463 x 5
    ##       ID score   age score_hat residual
    ##    <int> <dbl> <int>     <dbl>    <dbl>
    ##  1     1   4.7    36      4.25    0.452
    ##  2     2   4.1    36      4.25   -0.148
    ##  3     3   3.9    36      4.25   -0.348
    ##  4     4   4.8    36      4.25    0.552
    ##  5     5   4.6    59      4.11    0.488
    ##  6     6   4.3    59      4.11    0.188
    ##  7     7   2.8    59      4.11   -1.31 
    ##  8     8   4.1    51      4.16   -0.059
    ##  9     9   3.4    51      4.16   -0.759
    ## 10    10   4.5    40      4.22    0.276
    ## # … with 453 more rows

#### 3\. Get regression fit summaries

Get all the scalar summaries of a regression fit included in
`summary(score_model)` along with the mean-squared error and root
mean-squared error:

``` r
get_regression_summaries(score_model)
```

    ## # A tibble: 1 x 8
    ##   r_squared adj_r_squared   mse  rmse sigma statistic p_value    df
    ##       <dbl>         <dbl> <dbl> <dbl> <dbl>     <dbl>   <dbl> <dbl>
    ## 1     0.011         0.009 0.292 0.540 0.541      5.34   0.021     2

#### 4\. Plot parallel slopes models

Plot parallel slopes regression models involving one categorical and one
numerical explanatory/predictor variable (something you cannot do using
`ggplot2::geom_smooth()`).

``` r
library(ggplot2)
ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
  geom_point() +
  geom_parallel_slopes(se = FALSE)
```

![](man/figures/plot-example-1.png)<!-- -->

## Other features

#### 1\. Print markdown friendly tables

Want to output cleanly formatted tables in an R Markdown document? Just
add `print = TRUE` to any of the three `get_regression_*()`
functions.

``` r
get_regression_table(score_model, print = TRUE)
```

| term      | estimate | std\_error | statistic | p\_value | lower\_ci | upper\_ci |
| :-------- | -------: | ---------: | --------: | -------: | --------: | --------: |
| intercept |    4.462 |      0.127 |    35.195 |    0.000 |     4.213 |     4.711 |
| age       |  \-0.006 |      0.003 |   \-2.311 |    0.021 |   \-0.011 |   \-0.001 |

#### 2\. Predictions on new data

Want to apply your fitted model on new data to make predictions? No
problem\! Include a `newdata` data frame argument to
`get_regression_points()`.

For example, the Kaggle.com practice competition [House Prices: Advanced
Regression
Techniques](https://www.kaggle.com/c/house-prices-advanced-regression-techniques)
requires you to fit/train a model to the provided `train.csv` training
set to make predictions of house prices in the provided `test.csv` test
set. The following code performs these steps and outputs the predictions
in `submission.csv`:

``` r
library(tidyverse)
library(moderndive)

# Load in training and test set
train <- read_csv("https://github.com/moderndive/moderndive/raw/master/vignettes/train.csv")
test <- read_csv("https://github.com/moderndive/moderndive/raw/master/vignettes/test.csv")

# Fit model
house_model <- lm(SalePrice ~ YrSold, data = train)

# Make and submit predictions
submission <- get_regression_points(house_model, newdata = test, ID = "Id") %>%
  select(Id, SalePrice = SalePrice_hat)
write_csv(submission, "submission.csv")
```

The resulting `submission.csv` is formatted such that it can be
submitted on Kaggle, resulting in a “root mean squared logarithmic
error” leaderboard score of
0.42918.

![](https://github.com/moderndive/moderndive/raw/master/vignettes/leaderboard_orig.png)<!-- -->

## The Details

The three `get_regression` functions are wrappers of functions from the
[`broom`](https://CRAN.R-project.org/package=broom/vignettes/broom.html)
package for converting statistical analysis objects into tidy tibbles
along with a few added tweaks:

1.  `get_regression_table()` is a wrapper for `broom::tidy()`
2.  `get_regression_points()` is a wrapper for `broom::augment()`
3.  `get_regression_summaries()` is a wrapper for `broom::glance()`

Why did we create these wrappers?

  - The `broom` package function names `tidy()`, `augment()`, and
    `glance()` don’t mean anything to intro stats students, where as the
    `moderndive` package function names `get_regression_table()`,
    `get_regression_points()`, and `get_regression_summaries()` are more
    intuitive.
  - The default column/variable names in the outputs of the above 3
    functions are a little daunting for intro stats students to
    interpret. We cut out some of them and renamed many of them with
    more intuitive names. For example, compare the outputs of the
    `get_regression_points()` wrapper function and the parent
    `broom::augment()` function.

<!-- end list -->

``` r
get_regression_points(score_model)
```

    ## # A tibble: 463 x 5
    ##       ID score   age score_hat residual
    ##    <int> <dbl> <int>     <dbl>    <dbl>
    ##  1     1   4.7    36      4.25    0.452
    ##  2     2   4.1    36      4.25   -0.148
    ##  3     3   3.9    36      4.25   -0.348
    ##  4     4   4.8    36      4.25    0.552
    ##  5     5   4.6    59      4.11    0.488
    ##  6     6   4.3    59      4.11    0.188
    ##  7     7   2.8    59      4.11   -1.31 
    ##  8     8   4.1    51      4.16   -0.059
    ##  9     9   3.4    51      4.16   -0.759
    ## 10    10   4.5    40      4.22    0.276
    ## # … with 453 more rows

``` r
library(broom)
augment(score_model)
```

    ## # A tibble: 463 x 9
    ##    score   age .fitted .se.fit  .resid    .hat .sigma   .cooksd .std.resid
    ##    <dbl> <int>   <dbl>   <dbl>   <dbl>   <dbl>  <dbl>     <dbl>      <dbl>
    ##  1   4.7    36    4.25  0.0405  0.452  0.00560  0.542 0.00197        0.837
    ##  2   4.1    36    4.25  0.0405 -0.148  0.00560  0.542 0.000212      -0.274
    ##  3   3.9    36    4.25  0.0405 -0.348  0.00560  0.542 0.00117       -0.645
    ##  4   4.8    36    4.25  0.0405  0.552  0.00560  0.541 0.00294        1.02 
    ##  5   4.6    59    4.11  0.0371  0.488  0.00471  0.541 0.00193        0.904
    ##  6   4.3    59    4.11  0.0371  0.188  0.00471  0.542 0.000288       0.349
    ##  7   2.8    59    4.11  0.0371 -1.31   0.00471  0.538 0.0139        -2.43 
    ##  8   4.1    51    4.16  0.0261 -0.0591 0.00232  0.542 0.0000139     -0.109
    ##  9   3.4    51    4.16  0.0261 -0.759  0.00232  0.541 0.00229       -1.40 
    ## 10   4.5    40    4.22  0.0331  0.276  0.00374  0.542 0.000488       0.510
    ## # … with 453 more rows

-----

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
