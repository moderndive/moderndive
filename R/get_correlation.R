#' Get correlation value in a tidy way
#' 
#' Determine the Pearson correlation coefficient between two variables in
#' a data frame using pipeable and formula-friendly syntax
#'
#' @param data a data frame object
#' @param formula a formula with the response variable name on the left and the explanatory variable name on the right
#' 
#' @return A 1x1 data frame storing the correlation value
#' @importFrom magrittr "%>%"
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @export
#'
#' @examples
#' library(moderndive)
#' 
#' # Compute correlation between mpg and cyl:
#' mtcars %>% 
#'    get_correlation(formula = mpg ~ cyl)
get_correlation <- function(data, formula) {
    
  check_correlation_args(data, formula)
  
  outcome_variable <- formula %>% lhs() %>% all.vars()
  explanatory_variable <- formula %>% rhs() %>% all.vars()

  check_formula_args(data, formula, outcome_variable,
                     explanatory_variable)
  
  correlation <- stats::cor(data[[outcome_variable]],
             data[[explanatory_variable]])
  
  tibble::tibble(correlation)
}

check_correlation_args <- function(data, formula){
  if(!("data.frame" %in% class(data)))
    stop("The `data` argument must be a data frame.")
  
  if(!rlang::is_formula(formula))
    stop("The `formula` argument is not recognized as a formula.")
}

check_formula_args <- function(data, formula,
                               outcome_variable,
                               explanatory_variable) {
  
  if(is.null(rlang::f_lhs(formula)))
    stop(paste("A variable name must be given for the left hand side",
               "of the `formula`."))
  
  if(is.null(rlang::f_rhs(formula)))
    stop(paste("A variable name must be given for the right hand side",
               "of the `formula`."))
  
  if(length(explanatory_variable) > 1)
    stop(paste("The left hand side of the `formula` should only have one",
               "variable name"))
  
  if(!(outcome_variable %in% names(data)))
    stop(paste("The response variable `",
               outcome_variable,
               "cannot be found in this data frame.", call. = FALSE))
  
  if(!(explanatory_variable %in% names(data)))
    stop(paste("The explanatory variable `",
               explanatory_variable,
               "cannot be found in this data frame.", call. = FALSE))
}
