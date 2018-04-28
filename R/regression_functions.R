globalVariables(c(
  "term",
  ".resid",
  "AIC",
  "BIC",
  "deviance",
  "df.residual",
  "logLik",
  "ID", 
  "mse",
  "rmse",
  "residual",
  "r_squared",
  "adj_r_squared"
))

#' Get regression table
#'
#' Wrapper for tidy \code{lm()} regression function output
#'
#' @param model a model object (Currently only \code{lm} is supported)
#' @param digits number of digits precision in output table
#' @param print If TRUE, return in print format suitable for R Markdown
#' @param ... other arguments passed to lm()
#'
#' @return A tibble or nicely formatted table
#' @import dplyr
#' @importFrom stats lm
#' @importFrom magrittr "%>%"
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom broom tidy
#' @importFrom tibble as_tibble
#' @importFrom janitor clean_names
#' @importFrom knitr kable
#' @export
#'
#' @examples
#' mpg_model <- lm(mpg ~ cyl, data = mtcars)
#' get_regression_table(mpg_model)
get_regression_table <-
  function(model,
           digits = 3,
           print = FALSE,
           ...) {
    
    input_checks(model, digits, print)
    
    outcome_variable <- formula(model) %>% lhs() %>% all.vars()
    explanatory_variable <- formula(model) %>% rhs() %>% all.vars()
    
    regression_table <- model %>%
      tidy(conf.int = TRUE) %>%
      mutate_if(is.numeric, round, digits = digits) %>%
      mutate(term = ifelse(term == "(Intercept)", "intercept", term)) %>%
      as_tibble() %>%
      clean_names()
    
    if(print) {
      regression_table <- regression_table %>%
        kable()
    }
    
    return(regression_table)
  }


#' Get regression points
#'
#' Wrapper for tidy \code{lm()} regression function fit output
#'
#' @inheritParams get_regression_table
#' @param newdata a new data frame to fit the regression to/make predictions on.
#'
#' @return A tibble or nicely formatted table
#' @import dplyr
#' @import rlang
#' @importFrom stats formula 
#' @importFrom magrittr "%>%"
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom broom augment
#' @importFrom tibble as_tibble
#' @importFrom janitor clean_names
#' @importFrom stringr str_c
#' @importFrom knitr kable
#' @export
#'
#' @examples
#' library(dplyr)
#' library(tibble)
#' 
#' # Get information on all points in regression
#' mpg_model <- lm(mpg ~ cyl, data = mtcars)
#' get_regression_points(mpg_model)
#' 
#' # Convert rownames to column
#' data("mtcars")
#' mtcars <- mtcars %>% 
#'   rownames_to_column(var = "model")
#'
#' # Create training and test set.
#' training_set <- mtcars %>% 
#'   sample_frac(0.5)
#' test_set <- mtcars %>% 
#'   anti_join(training_set, by = "model")
#' 
#' # Fit model to training set, predict on test set
#' mpg_model_train <- lm(mpg ~ cyl, data = training_set)
#' get_regression_points(mpg_model_train, newdata = test_set)
get_regression_points <-
  function(model,
           digits = 3,
           print = FALSE,
           newdata = NULL) {
    
    input_checks(model, digits, print)
    
    outcome_variable <- formula(model) %>% lhs() %>% all.vars()
    explanatory_variable <- formula(model) %>% rhs() %>% all.vars()
    
    if(is.null(newdata)){
      # Get fitted values for all points used for regression
      regression_points <- model %>%
        augment() %>%
        mutate_if(is.numeric, round, digits = digits) %>%
        select(!!c(outcome_variable, explanatory_variable, 
                   ".fitted", ".resid")) %>%
        rename_at(vars(".fitted"), ~ str_c(outcome_variable, "_hat")) %>%
        rename(residual = .resid) %>%
        as_tibble() %>% 
        mutate(ID = 1:n()) %>%
        select(ID, everything())
    } else {
      assertive::assert_is_data.frame(newdata)
      
      # Get fitted values for newdata
      regression_points <- model %>%
        augment(newdata = newdata) %>%
        mutate_if(is.numeric, round, digits = digits) %>%
        select(!!c(outcome_variable, explanatory_variable, ".fitted")) %>%
        rename_at(vars(".fitted"), ~ str_c(outcome_variable, "_hat")) %>%
        as_tibble() 
    }
    
    if(print) {
      regression_points <- regression_points %>%
        kable()
    }
    
    return(regression_points)
  }



#' Get regression summary values
#'
#' Wrapper for \code{lm()} regression function fit summary data
#'
#' @inheritParams get_regression_table
#'
#' @return data frame with summaries
#' @import dplyr
#' @importFrom stats formula
#' @importFrom magrittr "%>%"
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom broom glance
#' @importFrom broom augment
#' @importFrom tibble as_tibble
#' @importFrom janitor clean_names
#' @importFrom knitr kable
#' @export
#'
#' @examples
#' mpg_model <- lm(mpg ~ cyl, data = mtcars)
#' get_regression_summaries(mpg_model)
get_regression_summaries <-
  function(model,
           digits = 3,
           print = FALSE,
           ...) {
    
    input_checks(model, digits, print)
    
    outcome_variable <- formula(model) %>% lhs() %>% all.vars()
    explanatory_variable <- formula(model) %>% rhs() %>% all.vars()
    
    mse_and_rmse <- model %>%
      augment() %>% 
      select(!!c(outcome_variable, explanatory_variable, 
                 ".fitted", ".resid")) %>%
      rename_at(vars(".fitted"), ~ str_c(outcome_variable, "_hat")) %>%
      rename(residual = .resid) %>% 
      summarise(mse = mean(residual^2), rmse = sqrt(mse))
      
    regression_summaries <- model %>%
      glance() %>%
      mutate_if(is.numeric, round, digits = digits) %>%
      select(-c(AIC, BIC, deviance, df.residual, logLik)) %>%
      as_tibble() %>%
      clean_names() %>% 
      bind_cols(mse_and_rmse) %>% 
      select(r_squared, adj_r_squared, mse, rmse, everything())
    
    if (print) {
      regression_summaries <- regression_summaries %>%
        kable()
    }
    
    return(regression_summaries)
  }

input_checks <- function(model,
                         digits = 3,
                         print = FALSE,
                         ...){
  # Since the `"glm"` class also contains the `"lm"` class
  if(length(class(model)) != 1 | !("lm" %in% class(model)) ){
    stop(paste("Only simple and multiple linear regression",
               "models are supported. Try again using `lm` for",
               "your models as appropriate."))
  }
  assertive::assert_is_numeric(digits)
  assertive::assert_is_logical(print)
}
