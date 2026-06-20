# Changelog

## moderndive 0.8.0.9000

- Fix issue [\#58](https://github.com/moderndive/moderndive/issues/58)
- Add in unit tests to bring test coverage back to 100%
- [`get_regression_points()`](https://moderndive.github.io/moderndive/reference/get_regression_points.md)
  and
  [`get_regression_summaries()`](https://moderndive.github.io/moderndive/reference/get_regression_summaries.md)
  now handle in-formula transformations on either side of the model
  formula (e.g. `lm(log(y) ~ poly(x, 2))`). LHS transforms previously
  errored; they now produce a sanitized outcome column on the model’s
  scale (e.g. `log_mpg`, `log_mpg_hat`). RHS transforms no longer leak
  basis matrices or wrapper columns
  ([`poly()`](https://rdrr.io/r/stats/poly.html) matrix columns,
  [`scale()`](https://rdrr.io/r/base/scale.html),
  [`I()`](https://rdrr.io/r/base/AsIs.html)) into the points table; the
  original predictor variable is shown instead. The `.rownames` column
  is no longer leaked into the output.
- [`get_regression_table()`](https://moderndive.github.io/moderndive/reference/get_regression_table.md),
  [`get_regression_points()`](https://moderndive.github.io/moderndive/reference/get_regression_points.md),
  and
  [`get_regression_summaries()`](https://moderndive.github.io/moderndive/reference/get_regression_summaries.md)
  now accept [`glm()`](https://rdrr.io/r/stats/glm.html) model objects
  (resolves issue
  [\#20](https://github.com/moderndive/moderndive/issues/20)). For
  [`glm()`](https://rdrr.io/r/stats/glm.html) models,
  [`get_regression_points()`](https://moderndive.github.io/moderndive/reference/get_regression_points.md)
  returns fitted values and residuals on the response scale
  (e.g. probabilities for logistic regression).
  [`get_regression_summaries()`](https://moderndive.github.io/moderndive/reference/get_regression_summaries.md)
  returns a glm-shaped summary (`mse`, `rmse`, `deviance`,
  `null_deviance`, `aic`, `bic`, `log_lik`, `df_residual`, `df_null`,
  `nobs`) — R² columns are not included since they don’t apply to glm.
  [`get_regression_table()`](https://moderndive.github.io/moderndive/reference/get_regression_table.md)
  gains an `exponentiate` argument (default `FALSE`) for returning
  odds/rate ratios for log/logit-link models.
- Internal: factor-level pretty-printing in
  [`get_regression_table()`](https://moderndive.github.io/moderndive/reference/get_regression_table.md)
  is now applied to the tidy output’s `term` column rather than
  `model$coefficients` names, which avoids breaking `confint.glm`’s
  profile-likelihood refits.
- Drop redundant `@docType package` tag from `R/moderndive.R` (resolves
  issue [\#133](https://github.com/moderndive/moderndive/issues/133)).
  The `"_PACKAGE"` sentinel was already in place, so the
  `moderndive-package` alias is generated correctly.
- Fix `pennies_resamples` so the `replicate` column is correctly
  numbered 1..35 instead of being uniformly `1` (resolves issue
  [\#130](https://github.com/moderndive/moderndive/issues/130)). The bug
  was an
  [`ungroup()`](https://dplyr.tidyverse.org/reference/group_by.html)
  missing in the `data-raw/process_data_sets.R` pipeline, so
  `mutate(replicate = 1:n())` ran per-group on a single-row nested
  tibble. The dataset has been regenerated; row count and structure are
  otherwise unchanged.
- New
  [`View()`](https://moderndive.github.io/moderndive/reference/View.md)
  wrapper (resolves issue
  [\#99](https://github.com/moderndive/moderndive/issues/99)). In an
  interactive R session it behaves identically to
  [`utils::View()`](https://rdrr.io/r/utils/View.html). In
  non-interactive contexts (R Markdown, Quarto, scripts) where
  [`utils::View()`](https://rdrr.io/r/utils/View.html) typically errors,
  it instead renders an interactive
  [`DT::datatable()`](https://rdrr.io/pkg/DT/man/datatable.html) inline
  so documents can still knit/render. `DT` is now in `Imports`. A short
  [`packageStartupMessage()`](https://rdrr.io/r/base/message.html) is
  emitted only on non-interactive attach to explain the override;
  interactive sessions see no extra message. Attaching `moderndive`
  masks [`utils::View`](https://rdrr.io/r/utils/View.html).
- Documentation examples now use `moderndive` datasets instead of base R
  / `ggplot2` ones.
  [`View()`](https://moderndive.github.io/moderndive/reference/View.md),
  [`get_correlation()`](https://moderndive.github.io/moderndive/reference/get_correlation.md),
  [`get_regression_table()`](https://moderndive.github.io/moderndive/reference/get_regression_table.md),
  [`get_regression_points()`](https://moderndive.github.io/moderndive/reference/get_regression_points.md),
  [`get_regression_summaries()`](https://moderndive.github.io/moderndive/reference/get_regression_summaries.md),
  [`plot_3d_regression()`](https://moderndive.github.io/moderndive/reference/plot_3d_regression.md),
  and the package-level overview now use `un_member_states_2024` (with
  `life_expectancy_2022 ~ gdp_per_capita`-style models).
  [`geom_categorical_model()`](https://moderndive.github.io/moderndive/reference/geom_categorical_model.md)
  now uses `evals` (`score ~ rank`) instead of
  [`ggplot2::mpg`](https://ggplot2.tidyverse.org/reference/mpg.html)
  (`hwy ~ drv`).
- `_pkgdown.yml`: site `url:` now includes the `https://` scheme so
  [`pkgdown::check_pkgdown()`](https://pkgdown.r-lib.org/reference/check_pkgdown.html)
  matches it against the URL listed in `DESCRIPTION`.
- `README`: added descriptive `alt` text to the hex-sticker image.
- [`get_correlation()`](https://moderndive.github.io/moderndive/reference/get_correlation.md)
  now accepts multiple right-hand-side variables in the formula
  (e.g. `mpg ~ hp + cyl + wt`) (resolves issue
  [\#29](https://github.com/moderndive/moderndive/issues/29)). The
  default output is a long tibble with one row per predictor; pass
  `wide = TRUE` for one column per predictor. Single-RHS behavior is
  unchanged. A one-time message points users to `corrr::correlate()` if
  they want a full pairwise correlation matrix; suppress it with
  `quiet = TRUE`.
- New
  [`plot_3d_regression()`](https://moderndive.github.io/moderndive/reference/plot_3d_regression.md)
  function for interactive 3D scatterplots with a fitted regression
  plane (resolves issue
  [\#27](https://github.com/moderndive/moderndive/issues/27)). Pass a
  formula `z ~ x + y` and the function returns a
  \[`plotly`\]\[plotly::plotly\] htmlwidget. `plotly` is in `Suggests`;
  install it with `install.packages("plotly")` to use this function.

## moderndive 0.7.0

CRAN release: 2024-09-01

- Added `un_member_states_2024` data for upcoming ModernDive v2 updates
- Added `spotify_by_genre` data for upcoming ModernDive v2 updates
- Added
  [`tidy_summary()`](https://moderndive.github.io/moderndive/reference/tidy_summary.md)
  function to summarize data frame columns for upcoming ModernDive v2
  updates
- Added `old_faithful_2024` data for upcoming ModernDive v2 updates
- Added `coffee_quality` data for upcoming ModernDive v2 updates
- Added `almonds_sample` data for upcoming ModernDive v2 updates

## moderndive 0.6.1

CRAN release: 2024-06-30

- Added `almonds_bowl` and `almonds_sample_100` data for upcoming
  ModernDive v2 updates to Inference chapters
- Added `early_january_2023_weather` and `envoy_flights` data for
  upcoming ModernDive v2 updates derived from data in the `nycflights23`
  package

## moderndive 0.5.5

CRAN release: 2022-12-01

- Addressing `broom` reverse dependency issue
  <https://github.com/moderndive/moderndive/issues/128>

## moderndive 0.5.4

CRAN release: 2022-05-13

- Added `early_january_weather` consisting of January subset of
  [`nycflights13::weather`](https://rdrr.io/pkg/nycflights13/man/weather.html)
- Added 10 datasets curated by [@wjhopper](https://github.com/wjhopper)
  [@lacombe129](https://github.com/lacombe129) and
  [@sastoudt](https://github.com/sastoudt) for ideal use in intro
  statistics courses ([@beanumber](https://github.com/beanumber) and
  [@mariumtapal](https://github.com/mariumtapal) did preliminary pull
  request management and code reviews)
  1.  @statsmed-sheep
      [@caroline-mckenna](https://github.com/caroline-mckenna)
      [@zyang2k](https://github.com/zyang2k)
      [@CJParkNW](https://github.com/CJParkNW) added `coffee_quality`
      dataset: 1340 samples of coffee tested for their quality level
  2.  @abbidabbers [@georgiagans](https://github.com/georgiagans)
      [@kaceyjj](https://github.com/kaceyjj) added `amazon_books`
      dataset: sample of books available for purchase on Amazon.com
  3.  @ewhalen1 [@vivala1](https://github.com/vivala1)
      [@Swaha294](https://github.com/Swaha294)
      [@CCccc-76](https://github.com/CCccc-76) added `ipf_lifts`
      consisting of international power lifting results
  4.  @i-m-foster [@mflesaker](https://github.com/mflesaker)
      [@ajhaller](https://github.com/ajhaller) added `babies` on
      maternal smoking and infant health
  5.  @tianshu-zhang [@q-w-a](https://github.com/q-w-a)
      [@kbruncati](https://github.com/kbruncati)
      [@katelyndiaz](https://github.com/katelyndiaz) added
      `ev_charging`: information from 3,395 high resolution electric
      vehicle charging sessions.
  6.  @rwu08 [@arrismo](https://github.com/arrismo)
      [@rporta23](https://github.com/rporta23)
      [@katephan](https://github.com/katephan) added
      `ma_traffic_2020_vs_2019` consisting of collisions information
      sourced from reports produced by the Massachusetts Traffic Data
      Management System.
  7.  @amutaya [@catherinepeppers](https://github.com/catherinepeppers)
      [@agoswa](https://github.com/agoswa)
      [@wndlovu](https://github.com/wndlovu) added `mass_traffic_2020`
      consisting of traffic data for 13 Massachusetts counties
  8.  @shirleyzhang-1999 [@hartlegr](https://github.com/hartlegr)
      [@silasweden](https://github.com/silasweden) added
      `mario_kart_auction` dataset
  9.  @heschmidt [@evejcik](https://github.com/evejcik)
      [@tessgold](https://github.com/tessgold)
      [@nikkischuldt](https://github.com/nikkischuldt) added `avocados`
      consisting of avocado prices dataset downloaded from the Hass
      Avocado Board website in May of 2018.
  10. @hongtonglin [@alejanmg](https://github.com/alejanmg)
      [@egordonhalpern](https://github.com/egordonhalpern) added
      `saratoga_houses` random sample of 1057 houses taken from full
      Saratoga Housing Data.

## moderndive 0.5.3

CRAN release: 2022-01-20

- Added `alaska_flights` consisting of Alaska Airlines subset of
  [`nycflights13::flights`](https://rdrr.io/pkg/nycflights13/man/flights.html)

## moderndive 0.5.2

CRAN release: 2021-07-21

- Changed printing of non-baseline categorical variable levels in
  regression table to be cleaner
  [\#102](https://github.com/moderndive/moderndive/issues/102)
- Added explicit `conf.level` argument to
  [`get_regression_table()`](https://moderndive.github.io/moderndive/reference/get_regression_table.md)
  inherited from
  [`broom::tidy.lm()`](https://broom.tidymodels.org/reference/tidy.lm.html)
- Improved main package vignette based on feedback from
  [@lwjohnst86](https://github.com/lwjohnst86) &
  [@lisamr](https://github.com/lisamr)
- Added JOSE publication in `vignettes/paper.md`
- Fixed `pkgdown` and `covr` issues, defragged documentation.

## moderndive 0.5.1

CRAN release: 2021-01-08

- Use vdiffr conditionally

## moderndive 0.5.0

CRAN release: 2020-07-19

- Modified `vignettes/why-moderndive.Rmd` main vignette
- Updated
  [`geom_parallel_slopes()`](https://moderndive.github.io/moderndive/reference/geom_parallel_slopes.md)
  with new arguments:
  - Use `fullrange=TRUE` to draw regression lines over the entire
    support of the x-axis (by [@wjhopper](https://github.com/wjhopper))
  - Use `level` to set different level of confidence interval shading
    (by [@echasnovski](https://github.com/echasnovski))
- Added new function
  [`geom_categorical_model()`](https://moderndive.github.io/moderndive/reference/geom_categorical_model.md)
  for visualizing regression models with one categorical
  explanatory/predictor variable (by
  [@wjhopper](https://github.com/wjhopper))
- Add deprecation warning message to
  [`gg_parallel_slopes()`](https://moderndive.github.io/moderndive/reference/gg_parallel_slopes.md)
  directing users to use
  [`geom_parallel_slopes()`](https://moderndive.github.io/moderndive/reference/geom_parallel_slopes.md)
  instead (by [@mariumtapal](https://github.com/mariumtapal))

## moderndive 0.4.0

CRAN release: 2019-11-04

- Added
  [`geom_parallel_slopes()`](https://moderndive.github.io/moderndive/reference/geom_parallel_slopes.md)
  geom extension to `ggplot2` package to plot parallel slopes regression
  models with one numerical and one categorical variable (this is not
  possible using
  [`ggplot2::geom_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html)).
  Note this renders
  [`gg_parallel_slopes()`](https://moderndive.github.io/moderndive/reference/gg_parallel_slopes.md)
  function added in v0.3.0 obsolete.
- Added example of
  [`geom_parallel_slopes()`](https://moderndive.github.io/moderndive/reference/geom_parallel_slopes.md)
  to “Why `moderndive`?” vignette
- Added student names (permission obtained in all cases) to
  `pennies_resamples` data frame columns
- [`get_correlation()`](https://moderndive.github.io/moderndive/reference/get_correlation.md)
  now:
  - Respects
    [`dplyr::group_by()`](https://dplyr.tidyverse.org/reference/group_by.html)
    grouping
  - Can handle missing data by either passing `na.rm = TRUE` argument or
    by passing standard `stats:cor(use = "complete.obs")` argument via
    `...`

## moderndive 0.3.0

CRAN release: 2019-07-18

- Added minimally viable “parallel slopes” regression model plotting
  function
  [`gg_parallel_slopes()`](https://moderndive.github.io/moderndive/reference/gg_parallel_slopes.md).
  In the future we hope to define a new `ggplot2` geom.
- Added “Why `moderndive`?” vignette
- Added ID argument to
  [`get_regression_points()`](https://moderndive.github.io/moderndive/reference/get_regression_points.md)
  to return a column that identifies the observational units/rows
- Datasets:
  - Added `DD_vs_SB`: Dunkin Donuts and Starbucks in Eastern
    Massachusetts data collected by
    [@DelaneyMoran](https://github.com/DelaneyMoran)
  - Added `promotions`: tibble version of
    `openintro::gender.discrimination` used to illustrate permutation
    test.
  - Added `MA_schools`: Relationship between SAT scores and
    socio-economic status for Massachusetts high schools.
  - Added `mythbusters_yawn`: Data from study on Mythbusters show on
    whether yawning is
  - Added `promotions_shuffled`: one instance of `promotions` with
    `gender` permuted/shuffled
  - Original `pennies_sample` sample of 40 pennies from `pennies` has
    been renamed `orig_pennies_sample`. New `pennies_sample` consists of
    50 pennies sampled from bank in Northampton, MA, USA on 2019/2/1.
  - Added `pennies_resamples`: 35 bootstrap resamples of new
    `pennies_sample`
  - Added `movies_genre`: random sample of 32 action and 36 romance
    movies from `ggplot2movies::movies`  
- Removed all `assertive::assert()` code
- Converted `house_prices$date` from `dttm` (date-time) to `date` per
  R4DS
  [comment](https://r4ds.had.co.nz/dates-and-times.html#creating-datetimes)
  on using simplest data type possible

## moderndive 0.2.0

CRAN release: 2018-07-06

Updated package for:

- Use in DataCamp’s Modeling with Data in the Tidyverse, in particular
  added `evals` and `house_prices` datasets and updated
  [`get_regression_table()`](https://moderndive.github.io/moderndive/reference/get_regression_table.md)
  and
  [`get_regression_points()`](https://moderndive.github.io/moderndive/reference/get_regression_points.md)
  functions.
- v0.4.0 of [ModernDive](https://moderndive.com/) textbook

Details:

- Created
  [`get_correlation()`](https://moderndive.github.io/moderndive/reference/get_correlation.md)
  function to omit `$` syntax and return a data frame
- Import
  [`infer::rep_sample_n()`](https://infer.tidymodels.org/reference/rep_sample_n.html)
  instead of our own defined version, as this function is [now included
  in `infer`](https://github.com/tidymodels/infer/pull/82)
- Added `evals`, `house_prices`, `tactile_prop_red`, `pennies_sample`
  and `mythbusters_yawn` datasets
- Added mean squared error and root mean squared error to output of
  [`get_regression_summaries()`](https://moderndive.github.io/moderndive/reference/get_regression_summaries.md)
- Added `newdata` argument to
  [`get_regression_points()`](https://moderndive.github.io/moderndive/reference/get_regression_points.md).
  When:
  - Original outcome variable is included in `newdata`, output it as
    well as `residual` (See Issue 17).
  - Otherwise omit `residual`
- Removed `tidyverse` from Depends, Imports, or Suggests

## moderndive 0.1.1

CRAN release: 2018-01-22

Fixed broken url in
[`?bowl_samples`](https://moderndive.github.io/moderndive/reference/bowl_samples.md)

## moderndive 0.1.0

CRAN release: 2018-01-22

- Added three `get_regression_*` functions meant for novice R
  users/regression fitters that process regression model outputs
- Added datasets:
  - `pennies`: 800 pennies to be treated as a population from which to
    simulate sampling a numerical variable from (`year` of minting)
  - `bowl`: Bowl of 2400 balls of which 900 are red to be treated as a
    population from which to simulate sampling a categorical variable
    from (`color`). Also known as the urn sampling framework .
  - `bowl_samples`: data from tactile version of sampling from `bowl`
    done in class: 10 groups sampled n=50 balls from and counted the
    number red \[ADD MODERNDIVE LINK\]
