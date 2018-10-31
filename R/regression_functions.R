globalVariables(c(
  "term", ".resid", "AIC", "BIC", "deviance", "df.residual", "logLik", "ID", 
  "mse", "rmse", "residual", "r_squared", "adj_r_squared", "conf_low",
  "conf_high"
))

#' Get regression table
#'
#' Output regression table for an \code{lm()} regression in "tidy" format. This function
#' is a wrapper function for \code{broom::tidy()} and includes confidence
#' intervals in the output table by default.
#'
#' @param model an \code{lm()} model object
#' @param digits number of digits precision in output table
#' @param print If TRUE, return in print format suitable for R Markdown
#'
#' @return A tibble-formatted regression table along with lower and upper end 
#' points of all confidence intervals for all parameters \code{lower_ci} and 
#' \code{upper_ci}.
#' @importFrom stats lm
#' @importFrom stats predict
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom broom tidy
#' @importFrom tibble as_tibble
#' @importFrom janitor clean_names
#' @importFrom knitr kable
#' @export
#' @seealso \code{\link[broom]{tidy}}, \code{\link{get_regression_points}}, \code{\link{get_regression_summaries}}
#'
#' @examples
#' library(moderndive)
#' 
#' # Fit lm() regression:
#' mpg_model <- lm(mpg ~ cyl, data = mtcars)
#' 
#' # Get regression table:
#' get_regression_table(mpg_model)
get_regression_table <-
  function(model,
           digits = 3,
           print = FALSE) {
    
    input_checks(model, digits, print)
    
    outcome_variable <- formula(model) %>% lhs() %>% all.vars()
    explanatory_variable <- formula(model) %>% rhs() %>% all.vars()
    
    regression_table <- model %>%
      tidy(conf.int = TRUE) %>%
      mutate_if(is.numeric, round, digits = digits) %>%
      mutate(term = ifelse(term == "(Intercept)", "intercept", term)) %>%
      as_tibble() %>%
      clean_names() %>% 
      rename(
        lower_ci = conf_low,
        upper_ci = conf_high
      )
    
    if(print) {
      regression_table <- regression_table %>%
        kable()
    }
    
    return(regression_table)
  }


#' Get regression points
#'
#' Output information on each point/observation used in an \code{lm()} regression in 
#' "tidy" format. This function is a wrapper function for \code{broom::augment()} 
#' and renames the variables to have more intuitive names.
#'
#' @inheritParams get_regression_table
#' @param newdata A new data frame of points/observations to apply \code{model} to 
#' obtain new fitted values and/or predicted values y-hat. Note the format of 
#' \code{newdata} must match the format of the original \code{data} used to fit
#' \code{model}.
#'
#' @return A tibble-formatted regression table of outcome/response variable, 
#' all explanatory/predictor variables, the fitted/predicted value, and residual.
#' @importFrom dplyr select
#' @importFrom dplyr rename_at
#' @importFrom dplyr vars
#' @importFrom dplyr rename
#' @importFrom dplyr mutate
#' @importFrom dplyr everything
#' @importFrom dplyr mutate_if
#' @importFrom dplyr summarise
#' @importFrom stats formula 
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom broom augment
#' @importFrom tibble as_tibble
#' @importFrom janitor clean_names
#' @importFrom stringr str_c
#' @importFrom knitr kable
#' @importFrom rlang sym
#' @importFrom rlang ":="
#' @export
#' @seealso \code{\link[broom]{augment}}, \code{\link{get_regression_table}}, \code{\link{get_regression_summaries}}
#'
#' @examples
#' library(moderndive)
#' library(dplyr)
#' library(tibble)
#' 
#' # Fit lm() regression:
#' mpg_model <- lm(mpg ~ cyl, data = mtcars)
#' 
#' # Get information on all points in regression:
#' get_regression_points(mpg_model)
#' 
#' # Create training and test set based on mtcars: 
#' mtcars <- mtcars %>% 
#'   rownames_to_column(var = "model")
#' training_set <- mtcars %>% 
#'   sample_frac(0.5)
#' test_set <- mtcars %>% 
#'   anti_join(training_set, by = "model")
#' 
#' # Fit model to training set:
#' mpg_model_train <- lm(mpg ~ cyl, data = training_set)
#' 
#' # Make predictions on test set:
#' get_regression_points(mpg_model_train, newdata = test_set)
get_regression_points <-
  function(model,
           digits = 3,
           print = FALSE,
           newdata = NULL) {
    input_checks(model, digits, print)
    
    outcome_variable <- formula(model) %>% lhs() %>% all.vars()
    outcome_variable_hat <- str_c(outcome_variable, "_hat")
    explanatory_variable <- formula(model) %>% rhs() %>% all.vars()
    
    if(is.null(newdata)){
      # Get fitted values for all points used for regression
      regression_points <- model %>%
        augment() %>%
        select(!!c(outcome_variable, explanatory_variable, 
                   ".fitted", ".resid")) %>%
        rename_at(vars(".fitted"), ~ outcome_variable_hat) %>%
        rename(residual = .resid) 
    } else {
      assertive::assert_is_data.frame(newdata)
      
      # Get fitted values for newdata depending on whether newdata already has 
      # the outcome/response variable. If it does, include it and compute
      # residuals.
      if(outcome_variable %in% names(newdata)) {
        regression_points <- newdata %>%
          select(!!c(outcome_variable, explanatory_variable)) %>% 
          # Get fitted/predicted values
          mutate(y_hat = predict(model, newdata = newdata)) %>% 
          rename_at(vars("y_hat"), ~ outcome_variable_hat) %>% 
          # Compute residuals
          mutate(
            residual := !!sym(outcome_variable) - !!sym(outcome_variable_hat)
          )
      } else {
        regression_points <- model %>%
          augment(newdata = newdata) %>%
          select(!!c(explanatory_variable, ".fitted")) %>%
          rename_at(vars(".fitted"), ~ str_c(outcome_variable, "_hat"))
      }
    }
    
    # Final clean up
    regression_points <- regression_points %>%
      mutate_if(is.numeric, round, digits = digits) %>% 
      mutate(ID = 1:n()) %>%
      select(ID, everything()) %>% 
      as_tibble()
    
    if(print) {
      regression_points <- regression_points %>%
        kable()
    }
    
    return(regression_points)
  }



#' Get regression summary values
#'
#' Output scalar summary statistics for an \code{lm()} regression in "tidy" 
#' format. This function is a wrapper function for \code{broom::glance()}.
#'
#' @inheritParams get_regression_table
#'
#' @return A single-row tibble with regression summaries. Ex: \code{r_squared} and \code{mse}.
#' @importFrom dplyr select
#' @importFrom dplyr rename_at
#' @importFrom dplyr vars
#' @importFrom dplyr rename
#' @importFrom dplyr mutate
#' @importFrom dplyr everything
#' @importFrom dplyr mutate_if
#' @importFrom dplyr summarise
#' @importFrom dplyr bind_cols
#' @importFrom dplyr n
#' @importFrom stats formula
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom broom glance
#' @importFrom broom augment
#' @importFrom tibble as_tibble
#' @importFrom janitor clean_names
#' @importFrom knitr kable
#' @export
#' @seealso \code{\link[broom]{glance}}, \code{\link{get_regression_table}}, \code{\link{get_regression_points}}
#'
#' @examples
#' library(moderndive)
#' 
#' # Fit lm() regression:
#' mpg_model <- lm(mpg ~ cyl, data = mtcars)
#' 
#' # Get regression summaries:
#' get_regression_summaries(mpg_model)
get_regression_summaries <-
  function(model,
           digits = 3,
           print = FALSE) {
    
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
                         print = FALSE){
  # Since the `"glm"` class also contains the `"lm"` class
  if(length(class(model)) != 1 | !("lm" %in% class(model)) ){
    stop(paste("Only simple and multiple linear regression",
               "models are supported. Try again using `lm` for",
               "your models as appropriate."))
  }
  assertive::assert_is_numeric(digits)
  assertive::assert_is_logical(print)
}
