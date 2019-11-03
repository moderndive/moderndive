#' moderndive - Tidyverse-Friendly Introductory Linear Regression
#'
#' Datasets and wrapper functions for tidyverse-friendly introductory linear
#' regression, used in "Statistical Inference via Data Science: A ModernDive 
#' into R and the tidyverse" available at \url{https://moderndive.com/}.
#'
#' @docType package
#' @name moderndive
#' @examples
#' library(moderndive)
#' 
#' # Fit regression model:
#' mpg_model <- lm(mpg ~ hp, data = mtcars)
#'
#' # Regression tables:
#' get_regression_table(mpg_model)
#'
#' # Information on each point in a regression:
#' get_regression_points(mpg_model)
#'
#' # Regression summaries
#' get_regression_summaries(mpg_model)
#' 
#' # Plotting parallel slopes models
#' ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
#'   geom_point() +
#'   geom_parallel_slopes(se = FALSE)
NULL
