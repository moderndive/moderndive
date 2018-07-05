#' moderndive - Tidyverse-Friendly Introductory Linear Regression
#'
#' An R package for tidyverse-friendly introductory linear regression used in 
#' ModernDive: An Introduction to Statistical and Data Sciences via R available 
#' at \url{http://moderndive.com/} and DataCamp's Modeling with Data in the Tidyverse 
#' available at 
#' \url{https://www.datacamp.com/courses/modeling-with-data-in-the-tidyverse}. In 
#' particular datasets and wrapper functions meant for novices to generate tidy 
#' linear regression outputs.
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
NULL