#' moderndive - Accompaniment Package to ModernDive: An Introduction to 
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
#' # Regression models
#' mpg_model <- lm(mpg ~ hp, data = mtcars)
#' mpg_mlr_model <- lm(mpg ~ hp + wt, data = mtcars)
#' mpg_mlr_model2 <- lm(mpg ~ hp + cyl, data = mtcars)
#'
#' # Regression tables
#' get_regression_table(model = mpg_model)
#' get_regression_table(mpg_mlr_model, digits = 4, print = TRUE)
#'
#' # Regression points. For residual analysis for example
#' get_regression_points(mpg_mlr_model2)
#'
#' # Regression summaries
#' get_regression_summaries(mpg_model)
#' 
#' # Can also use `%>%`
#' mpg_model %>% get_regression_summaries(digits = 5, print = TRUE)
NULL