globalVariables(c(
  "term", ".resid", "AIC", "BIC", "deviance", "df.residual", "logLik", "ID",
  "mse", "rmse", "residual", "r_squared", "adj_r_squared", "conf_low",
  "conf_high"
))

#' Get regression table
#'
#' Output regression table for an `lm()` regression in "tidy" format. This function
#' is a wrapper function for `broom::tidy()` and includes confidence
#' intervals in the output table by default.
#'
#' @param model an `lm()` model object
#' @inheritParams broom::tidy.lm
#' @param digits number of digits precision in output table
#' @param print If TRUE, return in print format suitable for R Markdown
#' @param default_categorical_levels If TRUE, do not change the non-baseline
#'  categorical variables in the term column. Otherwise non-baseline 
#'  categorical variables will be displayed in the format 
#'  "categorical_variable_name: level_name"
#'
#' @return A tibble-formatted regression table along with lower and upper end
#' points of all confidence intervals for all parameters `lower_ci` and
#' `upper_ci`; the confidence levels default to 95\%. 
#' @importFrom stats lm
#' @importFrom stats predict
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom broom tidy
#' @importFrom tibble as_tibble
#' @importFrom janitor clean_names
#' @importFrom knitr kable
#' @export
#' @seealso [`tidy()`][broom::reexports], [get_regression_points()], [get_regression_summaries()]
#'
#' @examples
#' library(moderndive)
#'
#' # Fit lm() regression:
#' mpg_model <- lm(mpg ~ cyl, data = mtcars)
#'
#' # Get regression table:
#' get_regression_table(mpg_model)
#' 
#' # Vary confidence level of confidence intervals
#' get_regression_table(mpg_model, conf.level = 0.99)
get_regression_table <- function(model, conf.level = 0.95, digits = 3, print = FALSE, default_categorical_levels = FALSE) {
  # Check inputs
  input_checks(model, digits, print)

  # Define outcome and explanatory/predictor variables
  outcome_variable <- formula(model) %>%
    lhs() %>%
    all.vars()
  explanatory_variable <- formula(model) %>%
    rhs() %>%
    all.vars()
  cat_explanatory_variable <- names(model[["xlevels"]])

  # Create output tibble
  regression_table <- model %>%
    tidy(conf.int = TRUE, conf.level) %>%
    mutate_if(is.numeric, round, digits = digits) %>%
    mutate(term = ifelse(term == "(Intercept)", "intercept", term)) %>%
    as_tibble() %>%
    clean_names() %>%
    rename(
      lower_ci = conf_low,
      upper_ci = conf_high
    ) %>% mutate(term = extract_cat_names(term, cat_explanatory_variable,
                                          default_categorical_levels))

  # Transform to markdown
  if (print) {
    regression_table <- regression_table %>%
      kable()
  }

  return(regression_table)
}


#' Get regression points
#'
#' Output information on each point/observation used in an `lm()` regression in
#' "tidy" format. This function is a wrapper function for `broom::augment()`
#' and renames the variables to have more intuitive names.
#'
#' @inheritParams get_regression_table
#' @param newdata A new data frame of points/observations to apply `model` to
#' obtain new fitted values and/or predicted values y-hat. Note the format of
#' `newdata` must match the format of the original `data` used to fit
#' `model`.
#' @param ID A string indicating which variable in either the original data used to fit
#' `model` or `newdata` should be used as
#' an identification variable to distinguish the observational units
#' in each row. This variable will be the left-most variable in the output data
#' frame. If `ID` is unspecified, a column `ID` with values 1 through the number of
#' rows is returned as the identification variable.
#'
#' @return A tibble-formatted regression table of outcome/response variable,
#' all explanatory/predictor variables, the fitted/predicted value, and residual.
#' @importFrom dplyr select
#' @importFrom dplyr rename_at
#' @importFrom dplyr vars
#' @importFrom dplyr rename
#' @importFrom dplyr mutate
#' @importFrom dplyr pull
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
#' @importFrom stats na.omit
#' @export
#' @seealso [`augment()`][broom::reexports], [get_regression_table()], [get_regression_summaries()]
#'
#' @examples
#' library(dplyr)
#' library(tibble)
#'
#' # Convert rownames to column
#' mtcars <- mtcars %>%
#'   rownames_to_column(var = "automobile")
#'
#' # Fit lm() regression:
#' mpg_model <- lm(mpg ~ cyl, data = mtcars)
#'
#' # Get information on all points in regression:
#' get_regression_points(mpg_model, ID = "automobile")
#'
#' # Create training and test set based on mtcars:
#' training_set <- mtcars %>%
#'   sample_frac(0.5)
#' test_set <- mtcars %>%
#'   anti_join(training_set, by = "automobile")
#'
#' # Fit model to training set:
#' mpg_model_train <- lm(mpg ~ cyl, data = training_set)
#'
#' # Make predictions on test set:
#' get_regression_points(mpg_model_train, newdata = test_set, ID = "automobile")
get_regression_points <-
  function(model, digits = 3, print = FALSE, newdata = NULL, ID = NULL) {
    # Check inputs
    input_checks(model, digits, print)
    if (!is.null(ID)) {
      check_character(ID)
    }
    if (!is.null(newdata)) {
      check_data_frame(newdata)
    }

    # Define outcome and explanatory/predictor variables
    outcome_variable <- formula(model) %>%
      lhs() %>%
      all.vars()
    outcome_variable_hat <- str_c(outcome_variable, "_hat")
    explanatory_variable <- formula(model) %>%
      rhs() %>%
      all.vars()

    # Compute all fitted/predicted values and residuals for three possible
    # cases/scenarios
    if (is.null(newdata)) {
      # Case 1: For the same data set used to fit model, compute fitted values
      # and residuals
      regression_points <- model %>%
        augment() %>%
        select(!!c(outcome_variable, explanatory_variable, ".fitted", ".resid")) %>%
        rename_at(vars(".fitted"), ~outcome_variable_hat) %>%
        rename(residual = .resid)
    } else {
      # Two cases when we wanted to return point information on a new data set,
      # newdata, different than the one used to fit the model with:
      if (outcome_variable %in% names(newdata)) {
        # Case 2.a) If outcome variable is included, we can compute both fitted
        # values and residuals.
        regression_points <- newdata %>%
          select(!!c(outcome_variable, explanatory_variable)) %>%
          # Compute fitted values
          mutate(y_hat = predict(model, newdata = newdata)) %>%
          rename_at(vars("y_hat"), ~outcome_variable_hat) %>%
          # Compute residuals
          mutate(residual := !!sym(outcome_variable) - !!sym(outcome_variable_hat))
      } else {
        # Case 2.b) If outcome variable is not included, we can only return
        # predicted values and not the residuals. This corresponds to typical
        # prediction scenario.
        regression_points <- model %>%
          # Compute fitted values:
          augment(newdata = newdata) %>%
          select(!!c(explanatory_variable, ".fitted")) %>%
          rename_at(vars(".fitted"), ~ str_c(outcome_variable, "_hat"))
      }
    }

    # Set identification variable for three possible cases/scenarios
    if (is.null(ID)) {
      # Case 1: If ID argument is not specified, set as ID variable as 1 through
      # number of rows
      regression_points <- regression_points %>%
        na.omit() %>%
        mutate(ID = 1:n()) %>%
        select(ID, everything())
    } else {
      # Two cases when ID argument is specified:
      if (is.null(newdata)) {
        # Case 2.a) When computing fitted values and residuals for the same data
        # used to fit the model, extract ID variable from original model fit.
        identification_variable <- eval(model$call$data, environment(formula(model))) %>%
          pull(!!ID)
      } else {
        # Case 2.b) When computing predicted values for a new dataset newdata than
        # the one used to fit the model, extract ID variable from newdata.
        identification_variable <- newdata %>%
          pull(!!ID)
      }
      # Set ID variable
      regression_points <- regression_points %>%
        na.omit() %>%
        mutate(ID = identification_variable) %>%
        select(ID, everything()) %>%
        rename_at(vars("ID"), ~ID)
    }

    # Final clean-up
    regression_points <- regression_points %>%
      mutate_if(is.double, round, digits = digits) %>%
      as_tibble()

    # Transform to markdown
    if (print) {
      regression_points <- regression_points %>%
        kable()
    }

    return(regression_points)
  }



#' Get regression summary values
#'
#' Output scalar summary statistics for an `lm()` regression in "tidy"
#' format. This function is a wrapper function for `broom::glance()`.
#'
#' @inheritParams get_regression_table
#'
#' @return A single-row tibble with regression summaries. Ex: `r_squared` and `mse`.
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
#' @seealso [`glance()`][broom::reexports], [get_regression_table()], [get_regression_points()]
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
  function(model, digits = 3, print = FALSE) {
    # Check inputs
    input_checks(model, digits, print)

    # Define outcome and explanatory/predictor variables
    outcome_variable <- formula(model) %>%
      lhs() %>%
      all.vars()
    explanatory_variable <- formula(model) %>%
      rhs() %>%
      all.vars()

    # Compute mean-squared error and root mean-squared error
    mse_and_rmse <- model %>%
      augment() %>%
      select(!!c(outcome_variable, explanatory_variable, ".fitted", ".resid")) %>%
      rename_at(vars(".fitted"), ~ str_c(outcome_variable, "_hat")) %>%
      rename(residual = .resid) %>%
      summarise(mse = mean(residual^2), rmse = sqrt(mse))

    # Create output tibble
    regression_summaries <- model %>%
      glance() %>%
      mutate_if(is.numeric, round, digits = digits) %>%
      select(-c(AIC, BIC, deviance, df.residual, logLik)) %>%
      as_tibble() %>%
      clean_names() %>%
      bind_cols(mse_and_rmse) %>%
      select(r_squared, adj_r_squared, mse, rmse, everything())

    # Transform to markdown
    if (print) {
      regression_summaries <- regression_summaries %>%
        kable()
    }

    return(regression_summaries)
  }


# Extract explanatory categorical variable levels ----

# helper function to escape regex characters from a variable name
remove_re_char <- function(string){
  # taken from the `escapeRegex` function in the Hmisc package
  gsub("([.|()\\^{}+$*?]|\\[|\\])", "\\\\\\1", string)
}

extract_cat_names <- function(term, cat_names, default_categorical_levels) {
    if ((!default_categorical_levels) & (length(cat_names) > 0)) {
      # if none of the x variables are categorical, do nothing
      # only change how we display non-baseline levels of categorical variables
      # if at least one of the x variables are categorical AND the user
      # does not want the default categorical levels
      
      # we need to handle the case where a factor is defined within the regression
      # equation
      cat_names <- remove_re_char(cat_names)
      cat_names <- cat_names[order(nchar(cat_names), decreasing = T)]
      
      # the xlevels should only be matched at the beginning of the term
      matches <-
        as.character(stringr::str_extract(term, paste0("(", "^", cat_names, ")", collapse = "|")))
      not_matched <- c(1, which(is.na(matches)))
      # force intercept term to always be in the not_matched group
      if (length(matches) > 0) {
        matches <-
          paste0(matches, ": ", stringr::str_sub(term, nchar(matches) + 1, nchar(term)))
        matches[not_matched] <- term[not_matched]
        return(matches)
      } else{
        return(term)
      }
    } else {
      return(term)
    }
  }


# Check input functions ----
input_checks <- function(model, digits = 3, print = FALSE, default_categorical_levels= FALSE) {
  # Since the `"glm"` class also contains the `"lm"` class
  if (length(class(model)) != 1 | !("lm" %in% class(model))) {
    stop(paste(
      "Only simple linear regression",
      "models are supported. Try again using only `lm()`",
      "models as appropriate."
    ))
  }
  check_numeric(digits)
  check_logical(print)
  check_logical(default_categorical_levels)
}

check_numeric <- function(input) {
  if (!is.numeric(input)) {
    stop("The input entry must be numeric.")
  }
}

check_logical <- function(input) {
  if (!is.logical(input)) {
    stop("The input must be logical.")
  }
}

check_character <- function(input) {
  if (!is.character(input)) {
    stop("The input must be a character.")
  }
}

check_data_frame <- function(input) {
  if (!is.data.frame(input)) {
    stop("The input must be a data frame.")
  }
}
