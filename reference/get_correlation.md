# Get correlation value in a tidy way

Determine the Pearson correlation coefficient between an outcome
variable on the left-hand side of `formula` and one or more explanatory
variables on the right-hand side, using pipeable and formula-friendly
syntax.

## Usage

``` r
get_correlation(data, formula, na.rm = FALSE, wide = FALSE, quiet = FALSE, ...)
```

## Arguments

- data:

  a data frame object

- formula:

  a formula with the outcome variable on the left and one or more
  explanatory variables on the right (e.g. `y ~ x` or
  `y ~ x1 + x2 + x3`).

- na.rm:

  a logical value indicating whether NA values should be stripped before
  the computation proceeds.

- wide:

  if `TRUE` and the formula has more than one right-hand-side variable,
  pivot the result wider so that each predictor becomes a column. Has no
  effect on single-predictor formulas. Default `FALSE`.

- quiet:

  if `TRUE`, suppress the informational message that points to
  `corrr::correlate()` for full pairwise correlation matrices. Default
  `FALSE`.

- ...:

  further arguments passed to
  [`stats::cor()`](https://rdrr.io/r/stats/cor.html)

## Value

A tibble. For a single right-hand side variable, a 1×1 tibble (or 1 row
per group) with column `cor`. For multiple right-hand side variables:
long format (default) with columns `predictor` and `cor` (plus any
grouping variables), or wide format (`wide = TRUE`) with one column per
predictor.

## Details

For a single right-hand side variable, the result is a 1-column tibble
(or one row per group if `data` is grouped) named `cor`. For multiple
right-hand side variables, the result is a long tibble with one row per
(predictor, group) combination by default; pass `wide = TRUE` to pivot
it to one column per predictor.

## Examples

``` r
library(moderndive)
library(dplyr)

# Single explanatory variable:
un_member_states_2024 %>%
  get_correlation(formula = life_expectancy_2022 ~ gdp_per_capita, na.rm = TRUE)
#> # A tibble: 1 × 1
#>     cor
#>   <dbl>
#> 1 0.585

# Multiple explanatory variables — long format:
un_member_states_2024 %>%
  get_correlation(
    formula = life_expectancy_2022 ~ gdp_per_capita + fertility_rate_2022 + hdi_2022,
    na.rm   = TRUE,
    quiet   = TRUE
  )
#> # A tibble: 3 × 2
#>   predictor              cor
#>   <chr>                <dbl>
#> 1 gdp_per_capita       0.585
#> 2 fertility_rate_2022 -0.815
#> 3 hdi_2022             0.889

# Multiple explanatory variables — wide format:
un_member_states_2024 %>%
  get_correlation(
    formula = life_expectancy_2022 ~ gdp_per_capita + fertility_rate_2022 + hdi_2022,
    wide    = TRUE,
    na.rm   = TRUE,
    quiet   = TRUE
  )
#> # A tibble: 1 × 3
#>   gdp_per_capita fertility_rate_2022 hdi_2022
#>            <dbl>               <dbl>    <dbl>
#> 1          0.585              -0.815    0.889

# Group by one variable:
un_member_states_2024 %>%
  group_by(continent) %>%
  get_correlation(formula = life_expectancy_2022 ~ gdp_per_capita, na.rm = TRUE)
#> # A tibble: 6 × 2
#>   continent       cor
#>   <fct>         <dbl>
#> 1 Africa        0.474
#> 2 Asia          0.658
#> 3 Europe        0.685
#> 4 North America 0.505
#> 5 Oceania       0.703
#> 6 South America 0.262

# Group by two variables:
un_member_states_2024 %>%
  group_by(continent, income_group_2024) %>%
  get_correlation(formula = life_expectancy_2022 ~ gdp_per_capita, na.rm = TRUE)
#> # A tibble: 21 × 3
#> # Groups:   continent [6]
#>    continent income_group_2024      cor
#>    <fct>     <fct>                <dbl>
#>  1 Africa    Low income           0.321
#>  2 Africa    Lower middle income  0.535
#>  3 Africa    Upper middle income  0.395
#>  4 Africa    High income         NA    
#>  5 Asia      Low income           0.396
#>  6 Asia      Lower middle income  0.527
#>  7 Asia      Upper middle income  0.121
#>  8 Asia      High income          0.415
#>  9 Europe    Lower middle income NA    
#> 10 Europe    Upper middle income -0.320
#> # ℹ 11 more rows
```
