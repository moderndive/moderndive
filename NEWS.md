# moderndive 0.2.0.9000

* Added minimally viable parallel slopes model plotting function `gg_parallel_slopes()`. To do in future: define a new `ggplot2` geom layer `geom_parallel_slopes()`.
* Added "Why `moderndive`?" vignette
* Added ID argument to `get_regression_points()` to return a column that ID's the 
observational units
* Removed all `assertive::assert()`
* Converted `house_prices$date` from `dttm` (date-time) to `date` per R4DS [comment](https://r4ds.had.co.nz/dates-and-times.html#creating-datetimes) on using simplest data type possible
* Added `DD_vs_SB` dataset of Dunkin Donuts and Starbucks in Eastern Massachusetts collected by @DelaneyMoran
* Original `pennies_sample` sample of 40 pennies from `pennies` has been renamed `orig_pennies_sample`. New `pennies_sample` consists of 50 pennies sampled from bank in Northampton, MA, USA on 2019/2/1.
* Added `pennies_resamples` data of 35 bootstrap resamples of new `pennies_sample`
* Added `promotions` data frame: tibble version of `openintro::gender.discrimination`


***


# moderndive 0.2.0

Updated package for:

- Use in DataCamp's [Modeling with Data in the Tidyverse](https://www.datacamp.com/courses/modeling-with-data-in-the-tidyverse), in particular added `evals` and `house_prices` datasets and updated `get_regression_table()` and `get_regression_points()` functions. 
- v0.4.0 of [ModernDive](https://moderndive.github.io/moderndive_book/) textbook

Details:

* Created `get_correlation()` function to omit `$` syntax and return a data frame
* Import `infer::rep_sample_n()` instead of our own defined version, as this function is [now included in `infer`](https://github.com/andrewpbray/infer/pull/82)
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

