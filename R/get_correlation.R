#' Get correlation value in a tidy way
#'
#' Determine the Pearson correlation coefficient between two variables in
#' a data frame using pipeable and formula-friendly syntax
#'
#' @param data a data frame object
#' @param formula a formula with the response variable name on the left and
#' the explanatory variable name on the right
#' @param na.rm a logical value indicating whether NA values should be stripped
#' before the computation proceeds.
#' @param ... further arguments passed to [stats::cor()]
#'
#' @return A 1x1 data frame storing the correlation value
#' @importFrom magrittr "%>%"
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom dplyr all_of
#' @importFrom dplyr group_vars
#' @importFrom dplyr select
#' @importFrom dplyr summarize
#' @importFrom stats cor
#' @export
#'
#' @examples
#' library(moderndive)
#'
#' # Compute correlation between mpg and cyl:
#' mtcars %>%
#'   get_correlation(formula = mpg ~ cyl)
#'
#' # Group by one variable:
#' library(dplyr)
#' mtcars %>%
#'   group_by(am) %>%
#'   get_correlation(formula = mpg ~ cyl)
#'
#' # Group by two variables:
#' mtcars %>%
#'   group_by(am, gear) %>%
#'   get_correlation(formula = mpg ~ cyl)
get_correlation <- function(data, formula, na.rm = FALSE, ...) {
  check_correlation_args(data, formula)

  outcome_variable <- formula %>%
    lhs() %>%
    all.vars()
  explanatory_variable <- formula %>%
    rhs() %>%
    all.vars()
  grouping_variables <- data %>%
    group_vars()

  check_formula_args(data, formula, outcome_variable, explanatory_variable)

  # select only the two numerical variables of interest (and if applicable grouping
  # variables)
  if (length(grouping_variables) == 0) {
    correlation <- data %>%
      select(all_of(outcome_variable), all_of(explanatory_variable))
  } else {
    correlation <- data %>%
      select(all_of(outcome_variable), all_of(explanatory_variable), 
             all_of(grouping_variables))
  }

  # handle missing data
  if (na.rm == FALSE) {
    correlation <- correlation %>%
      summarize(cor = cor(!!sym(outcome_variable), !!sym(explanatory_variable), ...))
  } else {
    correlation <- correlation %>%
      summarize(cor = cor(!!sym(outcome_variable), !!sym(explanatory_variable),
        use = "complete.obs", ...
      ))
  }

  correlation
}

check_correlation_args <- function(data, formula) {
  if (!("data.frame" %in% class(data))) {
    stop("The `data` argument must be a data frame.")
  }

  if (!rlang::is_formula(formula)) {
    stop("The `formula` argument is not recognized as a formula.")
  }
}

check_formula_args <- function(data, formula,
                               outcome_variable,
                               explanatory_variable) {
  if (is.null(rlang::f_lhs(formula))) {
    stop(paste(
      "A variable name must be given for the left hand side",
      "of the `formula`."
    ))
  }

  if (is.null(rlang::f_rhs(formula))) {
    stop(paste(
      "A variable name must be given for the right hand side",
      "of the `formula`."
    ))
  }

  if (length(explanatory_variable) > 1) {
    stop(paste(
      "The right hand side of the `formula` should only have one",
      "variable name"
    ))
  }

  if (!(outcome_variable %in% names(data))) {
    stop(paste("The response variable `",
      outcome_variable,
      "cannot be found in this data frame.",
      call. = FALSE
    ))
  }

  if (!(explanatory_variable %in% names(data))) {
    stop(paste("The explanatory variable `",
      explanatory_variable,
      "cannot be found in this data frame.",
      call. = FALSE
    ))
  }
}
