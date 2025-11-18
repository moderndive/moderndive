# moderndive - Tidyverse-Friendly Introductory Linear Regression

Datasets and wrapper functions for tidyverse-friendly introductory
linear regression, used in "Statistical Inference via Data Science: A
ModernDive into R and the tidyverse" available at
<https://moderndive.com/>.

## See also

Useful links:

- <https://moderndive.github.io/moderndive/>

- <https://github.com/moderndive/moderndive/>

- Report bugs at <https://github.com/moderndive/moderndive/issues>

## Author

**Maintainer**: Albert Y. Kim <albert.ys.kim@gmail.com>
([ORCID](https://orcid.org/0000-0001-7824-306X))

Authors:

- Chester Ismay <chester.ismay@gmail.com>
  ([ORCID](https://orcid.org/0000-0003-2820-2547))

Other contributors:

- Andrew Bray <abray@reed.edu>
  ([ORCID](https://orcid.org/0000-0002-4037-7414)) \[contributor\]

- Delaney Moran <delaneyemoran@gmail.com> \[contributor\]

- Evgeni Chasnovski <evgeni.chasnovski@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-1617-4019)) \[contributor\]

- Will Hopper <wjhopper510@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-7848-1946)) \[contributor\]

- Benjamin S. Baumer <ben.baumer@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-3279-0516)) \[contributor\]

- Marium Tapal <mariumtapal@gmail.com>
  ([ORCID](https://orcid.org/0000-0001-5093-6462)) \[contributor\]

- Wayne Ndlovu <waynedndlovu5@gmail.com> \[contributor\]

- Catherine Peppers <cpeppers@smith.edu> \[contributor\]

- Annah Mutaya <annahmutaya18@gmail.com> \[contributor\]

- Anushree Goswami <anushreeegoswami@gmail.com> \[contributor\]

- Ziyue Yang <zyang2k@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-9299-8327)) \[contributor\]

- Clara Li <clarasepianli@gmail.com>
  ([ORCID](https://orcid.org/0000-0003-2456-0849)) \[contributor\]

- Caroline McKenna <carolinemckenna101@gmail.com> \[contributor\]

- Catherine Park <jcathyp@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-8273-9620)) \[contributor\]

- Abbie Benfield <abbidabbers@gmail.com> \[contributor\]

- Georgia Gans <georgiagans@live.com> \[contributor\]

- Kacey Jean-Jacques <kjeanjacques@smith.edu> \[contributor\]

- Swaha Bhattacharya <itsswahabhattacharya@gmail.com> \[contributor\]

- Vivian Almaraz <viviansofia101@gmail.com> \[contributor\]

- Elle Jo Whalen <ewhalen@smith.edu> \[contributor\]

- Jacqueline Chen <jchen76@smith.edu> \[contributor\]

- Michelle Flesaker <mflesaker@smith.edu> \[contributor\]

- Irene Foster <ifoster25@smith.edu> \[contributor\]

- Aushanae Haller <aushanaenhaller@gmail.com> \[contributor\]

- Benjamin Bruncati <kbruncati@smith.edu>
  ([ORCID](https://orcid.org/0000-0001-8545-5984)) \[contributor\]

- Quinn White <quinnarlise@gmail.com>
  ([ORCID](https://orcid.org/0000-0001-5399-0237)) \[contributor\]

- Tianshu Zhang <tzhang26@smith.edu>
  ([ORCID](https://orcid.org/0000-0002-3004-4472)) \[contributor\]

- Katelyn Diaz <katndiaz@gmail.com>
  ([ORCID](https://orcid.org/0000-0001-6108-1682)) \[contributor\]

- Rose Porta <rporta@smith.edu> \[contributor\]

- Renee Wu <rwu30@smith.edu> \[contributor\]

- Arris Moise <amoise@smith.edu> \[contributor\]

- Kate Phan <kphan@smith.edu> \[contributor\]

- Grace Hartley <grace.hartley@gmail.com> \[contributor\]

- Silas Weden <silasweden@gmail.com> \[contributor\]

- Emma Vejcik <evejcik@gmail.com> \[contributor\]

- Nikki Schuldt <nikkischuldt@gmail.com> \[contributor\]

- Tess Goldmann <tessgoldmann@aol.com> \[contributor\]

- Hongtong Lin <cccynthialht@gmail.com> \[contributor\]

- Alejandra Munoz <amunozgarcia@smith.edu> \[contributor\]

- Elina Gordon-Halpern <egordonhalpern@smith.edu> \[contributor\]

- Haley Schmidt <heschmidt00@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-6184-2266)) \[contributor\]

## Examples

``` r
library(moderndive)

# Fit regression model:
mpg_model <- lm(mpg ~ hp, data = mtcars)

# Regression tables:
get_regression_table(mpg_model)
#> # A tibble: 2 × 7
#>   term      estimate std_error statistic p_value lower_ci upper_ci
#>   <chr>        <dbl>     <dbl>     <dbl>   <dbl>    <dbl>    <dbl>
#> 1 intercept   30.1        1.63     18.4        0   26.8     33.4  
#> 2 hp          -0.068      0.01     -6.74       0   -0.089   -0.048

# Information on each point in a regression:
get_regression_points(mpg_model)
#> # A tibble: 32 × 6
#>       ID   mpg .rownames            hp mpg_hat residual
#>    <int> <dbl> <chr>             <dbl>   <dbl>    <dbl>
#>  1     1  21   Mazda RX4           110    22.6   -1.59 
#>  2     2  21   Mazda RX4 Wag       110    22.6   -1.59 
#>  3     3  22.8 Datsun 710           93    23.8   -0.954
#>  4     4  21.4 Hornet 4 Drive      110    22.6   -1.19 
#>  5     5  18.7 Hornet Sportabout   175    18.2    0.541
#>  6     6  18.1 Valiant             105    22.9   -4.84 
#>  7     7  14.3 Duster 360          245    13.4    0.917
#>  8     8  24.4 Merc 240D            62    25.9   -1.47 
#>  9     9  22.8 Merc 230             95    23.6   -0.817
#> 10    10  19.2 Merc 280            123    21.7   -2.51 
#> # ℹ 22 more rows

# Regression summaries
get_regression_summaries(mpg_model)
#> # A tibble: 1 × 9
#>   r_squared adj_r_squared   mse  rmse sigma statistic p_value    df  nobs
#>       <dbl>         <dbl> <dbl> <dbl> <dbl>     <dbl>   <dbl> <dbl> <dbl>
#> 1     0.602         0.589  14.0  3.74  3.86      45.5       0     1    32

# Plotting parallel slopes models
library(ggplot2)
ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
  geom_point() +
  geom_parallel_slopes(se = FALSE)
```
