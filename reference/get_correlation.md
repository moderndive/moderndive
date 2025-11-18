# Get correlation value in a tidy way

Determine the Pearson correlation coefficient between two variables in a
data frame using pipeable and formula-friendly syntax

## Usage

``` r
get_correlation(data, formula, na.rm = FALSE, ...)
```

## Arguments

- data:

  a data frame object

- formula:

  a formula with the response variable name on the left and the
  explanatory variable name on the right

- na.rm:

  a logical value indicating whether NA values should be stripped before
  the computation proceeds.

- ...:

  further arguments passed to
  [`stats::cor()`](https://rdrr.io/r/stats/cor.html)

## Value

A 1x1 data frame storing the correlation value

## Examples

``` r
library(moderndive)

# Compute correlation between mpg and cyl:
mtcars %>%
  get_correlation(formula = mpg ~ cyl)
#>         cor
#> 1 -0.852162

# Group by one variable:
library(dplyr)
mtcars %>%
  group_by(am) %>%
  get_correlation(formula = mpg ~ cyl)
#> # A tibble: 2 × 2
#>      am    cor
#>   <dbl>  <dbl>
#> 1     0 -0.796
#> 2     1 -0.826

# Group by two variables:
mtcars %>%
  group_by(am, gear) %>%
  get_correlation(formula = mpg ~ cyl)
#> # A tibble: 4 × 3
#> # Groups:   am [2]
#>      am  gear    cor
#>   <dbl> <dbl>  <dbl>
#> 1     0     3 -0.645
#> 2     0     4 -0.959
#> 3     1     4 -0.601
#> 4     1     5 -0.961
```
