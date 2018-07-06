#' moderndive - Tidyverse-Friendly Introductory Linear Regression
#'
#' Datasets and wrapper functions for idyverse-friendly introductory linear
#' regression, used in ModernDive: An Introduction to Statistical and Data
#' Sciences via R available at \url{http://moderndive.com/} and DataCamp's
#' Modeling with Data in the Tidyverse available at
#' \url{https://www.datacamp.com/courses/modeling-with-data-in-the-tidyverse}.
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