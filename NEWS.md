# moderndive 0.1.1.9000

* Import `infer::rep_sample_n()` instead of our own defined version, as this function is now in `infer` on CRAN
* Added `evals`, `house_prices`, `tactile_prop_red` datasets
* Added mean squared error and root mean squared error to output of `get_regression_summaries()`
* Added `newdata` argument to `get_regression_points()`. When outcome variable is in `newdata`, output the outcome variable's observed value, fitted value, and residual (See Issue 17).
* Removed `tidyverse` from Depends, Imports, or Suggests

# moderndive 0.1.1

Fixed broken url in `?bowl_samples`

# moderndive 0.1.0

* Added three `get_regression_*` functions meant for novice R users/regression fitters that process regression model outputs
* Added datasets:
    + `pennies`: 800 pennies to be treated as a population from which to simulate sampling a numerical variable from (`year` of minting)
    + `bowl`: Bowl of 2400 balls of which 900 are red to be treated as a population from which to simulate sampling a categorical variable from (`color`). Also known as the urn sampling framework \url{https://en.wikipedia.org/wiki/Urn_problem}. 
    + `bowl_samples`: data from tactile version of sampling from `bowl` done in class: 10 groups sampled n=50 balls from  and counted the number red [ADD MODERNDIVE LINK]

