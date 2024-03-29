% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/regression_functions.R
\name{get_regression_points}
\alias{get_regression_points}
\title{Get regression points}
\usage{
get_regression_points(
  model,
  digits = 3,
  print = FALSE,
  newdata = NULL,
  ID = NULL
)
}
\arguments{
\item{model}{an \code{lm()} model object}

\item{digits}{number of digits precision in output table}

\item{print}{If TRUE, return in print format suitable for R Markdown}

\item{newdata}{A new data frame of points/observations to apply \code{model} to
obtain new fitted values and/or predicted values y-hat. Note the format of
\code{newdata} must match the format of the original \code{data} used to fit
\code{model}.}

\item{ID}{A string indicating which variable in either the original data used to fit
\code{model} or \code{newdata} should be used as
an identification variable to distinguish the observational units
in each row. This variable will be the left-most variable in the output data
frame. If \code{ID} is unspecified, a column \code{ID} with values 1 through the number of
rows is returned as the identification variable.}
}
\value{
A tibble-formatted regression table of outcome/response variable,
all explanatory/predictor variables, the fitted/predicted value, and residual.
}
\description{
Output information on each point/observation used in an \code{lm()} regression in
"tidy" format. This function is a wrapper function for \code{broom::augment()}
and renames the variables to have more intuitive names.
}
\examples{
library(dplyr)
library(tibble)

# Convert rownames to column
mtcars <- mtcars \%>\%
  rownames_to_column(var = "automobile")

# Fit lm() regression:
mpg_model <- lm(mpg ~ cyl, data = mtcars)

# Get information on all points in regression:
get_regression_points(mpg_model, ID = "automobile")

# Create training and test set based on mtcars:
training_set <- mtcars \%>\%
  sample_frac(0.5)
test_set <- mtcars \%>\%
  anti_join(training_set, by = "automobile")

# Fit model to training set:
mpg_model_train <- lm(mpg ~ cyl, data = training_set)

# Make predictions on test set:
get_regression_points(mpg_model_train, newdata = test_set, ID = "automobile")
}
\seealso{
\code{\link[broom:reexports]{augment()}}, \code{\link[=get_regression_table]{get_regression_table()}}, \code{\link[=get_regression_summaries]{get_regression_summaries()}}
}
