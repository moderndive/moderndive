#' moderndive - Tidyverse-Friendly Introductory Linear Regression
#'
#' Datasets and wrapper functions for tidyverse-friendly introductory linear
#' regression, used in "Statistical Inference via Data Science: A ModernDive
#' into R and the tidyverse" available at <https://moderndive.com/>.
#'
#' @name moderndive
#' @examples
#' library(moderndive)
#'
#' # Fit regression model:
#' life_exp_model <- lm(
#'   life_expectancy_2022 ~ gdp_per_capita,
#'   data = un_member_states_2024
#' )
#'
#' # Regression tables:
#' get_regression_table(life_exp_model)
#'
#' # Information on each point in a regression:
#' get_regression_points(life_exp_model)
#'
#' # Regression summaries
#' get_regression_summaries(life_exp_model)
#'
#' # Plotting parallel slopes models
#' library(ggplot2)
#' ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
#'   geom_point() +
#'   geom_parallel_slopes(se = FALSE)
"_PACKAGE"
