#' moderndive: Accompaniment Package to ModernDive - An Introduction to 
#' Statistical and Data Sciences via R
#'
#' An accompaniment R package to ModernDive: An Introduction to Statistical and 
#' Data Sciences via R available at \url{http://moderndive.com/}, in particular 
#' wrapper functions targeted at novices to easily generate tidy linear 
#' regression output in Chapter 6: Data Modeling with Regression.
#'
#' @docType package
#' @name moderndive
#' @examples
#' # Example usage:
#' library(moderndive)
#' library(dplyr)
#' 
#' # Regression tables
#' get_regression_table(mpg ~ hp, data = mtcars)
#' get_regression_table(mpg ~ hp + wt, data = mtcars, digits = 4, print = TRUE)
#' 
#' # Regression points. For residual analysis for example
#' mtcars <- mtcars %>% 
#'   mutate(cyl = as.factor(cyl))
#' get_regression_points(mpg ~ hp + cyl, data = mtcars)
#' 
#' # Regression summaries
#' get_regression_summaries(mpg ~ hp, data = mtcars)
#' get_regression_summaries(mpg ~ hp, data = mtcars, digits = 5, print = TRUE)
NULL