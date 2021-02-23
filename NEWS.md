# moderndive 0.5.1.9000

* Changed printing of non-baseline categorical variable levels in regression table to be cleaner #102



***



# moderndive 0.5.1

* Use vdiffr conditionally



***



# moderndive 0.5.0

* Modified `vignettes/why-moderndive.Rmd` main vignette
* Updated `geom_parallel_slopes()` with new arguments:
    + Use `fullrange=TRUE` to draw regression lines over the entire support of the x-axis (by @wjhopper)
    + Use `level` to set different level of confidence interval shading (by @echasnovski)
* Added new function `geom_categorical_model()` for visualizing regression models with one categorical explanatory/predictor variable (by @wjhopper)
* Add deprecation warning message to `gg_parallel_slopes()` directing users to use `geom_parallel_slopes()` instead (by @mariumtapal)



***



# moderndive 0.4.0

* Added `geom_parallel_slopes()` geom extension to `ggplot2` package to plot parallel slopes regression models with one numerical and one categorical variable (this is not possible using `ggplot2::geom_smooth()`). Note this renders `gg_parallel_slopes()` function added in v0.3.0 obsolete.
* Added example of `geom_parallel_slopes()` to "Why `moderndive`?" vignette
* Added student names (permission obtained in all cases) to `pennies_resamples` data frame columns
* `get_correlation()` now:
    + Respects `dplyr::group_by()` grouping
    + Can handle missing data by either passing `na.rm = TRUE` argument or by passing standard `stats:cor(use = "complete.obs")` argument via `...`



***



# moderndive 0.3.0

* Added minimally viable "parallel slopes" regression model plotting function `gg_parallel_slopes()`. In the future we hope to define a new `ggplot2` geom.
* Added "Why `moderndive`?" vignette
* Added ID argument to `get_regression_points()` to return a column that identifies the 
observational units/rows
* Datasets:
    + Added `DD_vs_SB`: Dunkin Donuts and Starbucks in Eastern Massachusetts data collected by @DelaneyMoran
    + Added `promotions`: tibble version of `openintro::gender.discrimination` used to illustrate permutation test.
    + Added `MA_schools`: Relationship between SAT scores and socio-economic status for Massachusetts high schools.
    + Added `mythbusters_yawn`: Data from study on Mythbusters show on whether yawning is
    + Added `promotions_shuffled`: one instance of `promotions` with `gender` permuted/shuffled
    + Original `pennies_sample` sample of 40 pennies from `pennies` has been renamed `orig_pennies_sample`. New `pennies_sample` consists of 50 pennies sampled from bank in Northampton, MA, USA on 2019/2/1.
    + Added `pennies_resamples`: 35 bootstrap resamples of new `pennies_sample`
    + Added `movies_genre`: random sample of 32 action and 36 romance movies from `ggplot2movies::movies`        
* Removed all `assertive::assert()` code
* Converted `house_prices$date` from `dttm` (date-time) to `date` per R4DS [comment](https://r4ds.had.co.nz/dates-and-times.html#creating-datetimes) on using simplest data type possible



***



# moderndive 0.2.0

Updated package for:

- Use in DataCamp's [Modeling with Data in the Tidyverse](https://www.datacamp.com/courses/modeling-with-data-in-the-tidyverse), in particular added `evals` and `house_prices` datasets and updated `get_regression_table()` and `get_regression_points()` functions. 
- v0.4.0 of [ModernDive](https://moderndive.com/) textbook

Details:

* Created `get_correlation()` function to omit `$` syntax and return a data frame
* Import `infer::rep_sample_n()` instead of our own defined version, as this function is [now included in `infer`](https://github.com/tidymodels/infer/pull/82)
* Added `evals`, `house_prices`, `tactile_prop_red`, `pennies_sample` and `mythbusters_yawn` datasets
* Added mean squared error and root mean squared error to output of `get_regression_summaries()`
* Added `newdata` argument to `get_regression_points()`. When:
    - Original outcome variable is included in `newdata`, output it as well as `residual` (See Issue 17).
    - Otherwise omit `residual`
* Removed `tidyverse` from Depends, Imports, or Suggests


***


# moderndive 0.1.1

Fixed broken url in `?bowl_samples`


***


# moderndive 0.1.0

* Added three `get_regression_*` functions meant for novice R users/regression fitters that process regression model outputs
* Added datasets:
    + `pennies`: 800 pennies to be treated as a population from which to simulate sampling a numerical variable from (`year` of minting)
    + `bowl`: Bowl of 2400 balls of which 900 are red to be treated as a population from which to simulate sampling a categorical variable from (`color`). Also known as the urn sampling framework \url{https://en.wikipedia.org/wiki/Urn_problem}. 
    + `bowl_samples`: data from tactile version of sampling from `bowl` done in class: 10 groups sampled n=50 balls from  and counted the number red [ADD MODERNDIVE LINK]
