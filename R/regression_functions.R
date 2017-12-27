globalVariables(c("term", ".resid", "AIC", "BIC", "deviance", "df.residual", "logLik"))

#' Get regression table
#' 
#' Wrapper for \code{lm()} regression function
#'
#' @param formula regression formula
#' @param data data frame
#' @param digits number of digits precision in output table
#' @param print If true, return in print format suitable for R Markdown
#' @param ... other arguments passed to lm()
#'
#' @return table
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
#' get_regression_table(mpg ~ cyl, data = mtcars)
get_regression_table <- function(formula, data, digits = 3, print = FALSE, ...){
  outcome_variable <- formula %>% lhs() %>% all.vars()
  explanatory_variable <- formula %>% rhs() %>% all.vars()
  
  regression_table <- lm(formula = formula, data = data, ...) %>%
    tidy(conf.int = TRUE) %>%
    mutate_if(is.numeric, round, digits=digits) %>%
    mutate(term = ifelse(term == "(Intercept)", "intercept", term)) %>% 
    as_tibble() %>%
    clean_names()
  
  if(print){
    regression_table <- regression_table %>% 
      kable()
  }
  
  return(regression_table)
}


#' Get regression points
#' 
#' Wrapper for \code{lm()} regression function
#'
#' @inheritParams get_regression_table
#'
#' @return table
#' @import dplyr
#' @import rlang
#' @importFrom stats lm
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
#' get_regression_points(mpg ~ cyl, data = mtcars)
get_regression_points <- function(formula, data, digits = 3, print = FALSE, ...){
  outcome_variable <- formula %>% lhs() %>% all.vars()
  explanatory_variable <- formula %>% rhs() %>% all.vars()
  
  regression_points <- lm(formula = formula, data = data) %>%
    augment() %>%
    mutate_if(is.numeric, round, digits = digits) %>%
    select(!!c(outcome_variable, explanatory_variable, ".fitted", ".resid")) %>% 
    rename_at(vars(".fitted"), ~str_c(outcome_variable, "_hat")) %>%
    rename(residual = .resid) %>%
    as_tibble() %>%
    clean_names() 
  
  if(print){
    regression_points <- regression_points %>% 
      kable()
  }
  
  return(regression_points)
}



#' Get regression points
#' 
#' Wrapper for \code{lm()} regression function
#'
#' @inheritParams get_regression_table
#'
#' @return table
#' @import dplyr
#' @importFrom stats lm
#' @importFrom magrittr "%>%"
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom broom glance
#' @importFrom tibble as_tibble
#' @importFrom janitor clean_names
#' @importFrom knitr kable
#' @export
#'
#' @examples
#' get_regression_summaries(mpg ~ cyl, data = mtcars)
get_regression_summaries <- function(formula, data, digits = 3, print = FALSE, ...){
  outcome_variable <- formula %>% lhs() %>% all.vars()
  explanatory_variable <- formula %>% rhs() %>% all.vars()
  
  regression_summaries <- lm(formula = formula, data = data) %>%
    glance() %>%
    mutate_if(is.numeric, round, digits = digits) %>%
    select(-c(AIC, BIC, deviance, df.residual, logLik)) %>%
    as_tibble() %>%
    clean_names()
  
  if(print){
    regression_summaries <- regression_summaries %>% 
      kable()
  }
  
  return(regression_summaries)
}