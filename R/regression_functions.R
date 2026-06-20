globalVariables(c(
  "term", ".resid", "AIC", "BIC", "deviance", "df.residual", "logLik", "ID",
  "mse", "rmse", "residual", "r_squared", "adj_r_squared", "conf_low",
  "conf_high"
))

#' Get regression table
#'
#' Output regression table for an `lm()` or `glm()` model in "tidy" format.
#' This function is a wrapper function for `broom::tidy()` and includes
#' confidence intervals in the output table by default.
#'
#' @param model an `lm()` or `glm()` model object
#' @inheritParams broom::tidy.lm
#' @param digits number of digits precision in output table
#' @param print If TRUE, return in print format suitable for R Markdown
#' @param default_categorical_levels If TRUE, do not change the non-baseline
#'  categorical variables in the term column. Otherwise non-baseline
#'  categorical variables will be displayed in the format
#'  "categorical_variable_name-level_name"
#' @param exponentiate If TRUE, exponentiate the coefficient estimates and
#'  confidence intervals. Useful for `glm()` models with log or logit links
#'  (returns rate or odds ratios respectively). Default `FALSE`.
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
#' @importFrom purrr imap
#' @importFrom stringr str_replace_all
#' @importFrom stringr coll
#' @export
#' @seealso [`tidy()`][broom::reexports], [get_regression_points()], [get_regression_summaries()]
#'
#' @examples
#' library(moderndive)
#'
#' # Fit lm() regression:
#' life_exp_model <- lm(
#'   life_expectancy_2022 ~ gdp_per_capita,
#'   data = un_member_states_2024
#' )
#'
#' # Get regression table:
#' get_regression_table(life_exp_model)
#'
#' # Vary confidence level of confidence intervals
#' get_regression_table(life_exp_model, conf.level = 0.99)
get_regression_table <- function(model, conf.level = 0.95, digits = 3,
                                 print = FALSE,
                                 default_categorical_levels = FALSE,
                                 exponentiate = FALSE) {
  input_checks(model, digits, print, default_categorical_levels)
  check_logical(exponentiate)

  regression_table <- model %>%
    tidy(conf.int = TRUE, conf.level = conf.level, exponentiate = exponentiate) %>%
    mutate_if(is.numeric, round, digits = digits) %>%
    mutate(term = ifelse(term == "(Intercept)", "intercept", term)) %>%
    as_tibble() %>%
    clean_names() %>%
    rename(
      lower_ci = conf_low,
      upper_ci = conf_high
    )

  # Apply factor-level pretty-printing to the `term` column directly. Doing
  # this AFTER `tidy()` (rather than mutating `model$coefficients` names)
  # avoids breaking `broom::tidy(glm, conf.int = TRUE)`, which calls
  # `confint.glm` → `profile.glm`; the profile refits rely on the original
  # coefficient names internally.
  if (!default_categorical_levels && length(model[["xlevels"]]) > 0) {
    delim <- "-"
    old_names <- unlist(imap(model[["xlevels"]], ~ paste0(.y, .x)))
    new_names <- unlist(imap(model[["xlevels"]], ~ paste0(.y, delim, .x)))
    names(new_names) <- old_names
    regression_table$term <- str_replace_all(regression_table$term, coll(new_names))
  }

  if (print) regression_table <- kable(regression_table)

  regression_table
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
#' @param ID A string indicating which variable in either the original data used
#'  to fit `model` or `newdata` should be used as
#' an identification variable to distinguish the observational units
#' in each row. This variable will be the left-most variable in the output data
#' frame. If `ID` is unspecified, a column `ID` with values 1 through the number 
#' of rows is returned as the identification variable.
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
#' @importFrom dplyr bind_cols
#' @importFrom stats formula
#' @importFrom stats fitted
#' @importFrom stats model.frame
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom broom augment
#' @importFrom tibble as_tibble
#' @importFrom tibble tibble
#' @importFrom janitor clean_names
#' @importFrom janitor make_clean_names
#' @importFrom stringr str_c
#' @importFrom knitr kable
#' @importFrom rlang sym
#' @importFrom rlang ":="
#' @importFrom stats na.omit
#' @importFrom stats terms
#' @export
#' @seealso [`augment()`][broom::reexports], [get_regression_table()], [get_regression_summaries()]
#'
#' @examples
#' library(dplyr)
#' library(moderndive)
#'
#' # Fit lm() regression:
#' life_exp_model <- lm(
#'   life_expectancy_2022 ~ gdp_per_capita,
#'   data = un_member_states_2024
#' )
#'
#' # Get information on all points in regression:
#' get_regression_points(life_exp_model, ID = "country")
#'
#' # Create training and test set based on un_member_states_2024:
#' training_set <- un_member_states_2024 %>%
#'   sample_frac(0.5)
#' test_set <- un_member_states_2024 %>%
#'   anti_join(training_set, by = "country")
#'
#' # Fit model to training set:
#' life_exp_model_train <- lm(
#'   life_expectancy_2022 ~ gdp_per_capita,
#'   data = training_set
#' )
#'
#' # Make predictions on test set:
#' get_regression_points(life_exp_model_train, newdata = test_set, ID = "country")
get_regression_points <-
  function(model, digits = 3, print = FALSE, newdata = NULL, ID = NULL) {
    input_checks(model, digits, print)
    if (!is.null(ID)) check_character(ID)
    if (!is.null(newdata)) check_data_frame(newdata)

    oi     <- outcome_info(model)
    pvars  <- predictor_vars(model)
    src    <- original_model_data(model)
    is_glm <- inherits(model, "glm")

    if (is.null(newdata)) {
      # Case 1: same data used to fit the model. Outcome is read from the
      # model frame on the scale the model was fit on (possibly transformed
      # for in-formula transforms like log(y)). For glm models, fitted
      # values are on the response scale (e.g. probabilities for logistic
      # regression) so residuals are y - p̂ rather than deviance residuals.
      mf <- stats::model.frame(model)
      fit <- if (is_glm) {
        as.numeric(stats::predict(model, type = "response"))
      } else {
        as.numeric(stats::fitted(model))
      }
      outcome_vals <- as.numeric(mf[[1]])

      pred_df <- predictor_columns(mf, src, pvars)

      regression_points <- tibble::tibble(!!oi$name := outcome_vals) %>%
        dplyr::bind_cols(pred_df)
      regression_points[[oi$name_hat]] <- fit
      regression_points$residual       <- outcome_vals - fit
    } else {
      # Case 2: predict on newdata. Predictors come from `newdata` so that
      # in-formula transforms (poly, scale, I, log) don't leak basis or
      # matrix columns into the output. For glm models, predictions are on
      # the response scale.
      missing_pvars <- setdiff(pvars, names(newdata))
      if (length(missing_pvars) > 0) {
        stop(
          "`newdata` is missing required predictor variable(s): ",
          paste(missing_pvars, collapse = ", ")
        )
      }

      fit <- if (is_glm) {
        as.numeric(stats::predict(model, newdata = newdata, type = "response"))
      } else {
        as.numeric(stats::predict(model, newdata = newdata))
      }
      pred_df <- newdata[, pvars, drop = FALSE]

      if (all(oi$vars %in% names(newdata))) {
        # 2a: outcome present — evaluate the LHS expression in `newdata` so
        # that residuals are on the same scale as the fitted model.
        outcome_vals <- as.numeric(eval(oi$expr, envir = newdata))
        regression_points <- tibble::tibble(!!oi$name := outcome_vals) %>%
          dplyr::bind_cols(pred_df)
        regression_points[[oi$name_hat]] <- fit
        regression_points$residual       <- outcome_vals - fit
      } else {
        # 2b: outcome missing — predicted values only.
        regression_points <- tibble::as_tibble(pred_df)
        regression_points[[oi$name_hat]] <- fit
      }
    }

    if (is.null(ID)) {
      regression_points <- regression_points %>%
        na.omit() %>%
        mutate(ID = 1:n()) %>%
        select(ID, everything())
    } else {
      if (is.null(newdata)) {
        if (is.null(src)) {
          stop("Could not locate source data to extract ID column `", ID, "`.")
        }
        if (!(ID %in% names(src))) {
          stop("ID column `", ID, "` not found in source data.")
        }
        mf <- stats::model.frame(model)
        identification_variable <- src[rownames(mf), , drop = FALSE][[ID]]
      } else {
        if (!(ID %in% names(newdata))) {
          stop("ID column `", ID, "` not found in `newdata`.")
        }
        identification_variable <- newdata[[ID]]
      }
      regression_points <- regression_points %>%
        mutate(ID = identification_variable) %>%
        na.omit() %>%
        select(ID, everything()) %>%
        rename_at(vars("ID"), ~ID)
    }

    regression_points <- regression_points %>%
      mutate_if(is.double, round, digits = digits) %>%
      tibble::as_tibble()

    if (print) regression_points <- knitr::kable(regression_points)

    regression_points
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
#' @importFrom stats residuals
#' @export
#' @seealso [`glance()`][broom::reexports], [get_regression_table()], [get_regression_points()]
#'
#' @examples
#' library(moderndive)
#'
#' # Fit lm() regression:
#' life_exp_model <- lm(
#'   life_expectancy_2022 ~ gdp_per_capita,
#'   data = un_member_states_2024
#' )
#'
#' # Get regression summaries:
#' get_regression_summaries(life_exp_model)
get_regression_summaries <-
  function(model, digits = 3, print = FALSE) {
    input_checks(model, digits, print)
    is_glm <- inherits(model, "glm")

    res <- if (is_glm) {
      as.numeric(stats::residuals(model, type = "response"))
    } else {
      as.numeric(stats::residuals(model))
    }
    mse_val <- mean(res^2, na.rm = TRUE)
    mse_and_rmse <- tibble::tibble(mse = mse_val, rmse = sqrt(mse_val))

    if (is_glm) {
      # glm has no R^2 / sigma / F-statistic. Keep the deviance/AIC/BIC
      # columns broom::glance() returns for glm models instead.
      regression_summaries <- model %>%
        glance() %>%
        mutate_if(is.numeric, round, digits = digits) %>%
        as_tibble() %>%
        clean_names() %>%
        bind_cols(mse_and_rmse) %>%
        select(mse, rmse, everything())
    } else {
      regression_summaries <- model %>%
        glance() %>%
        mutate_if(is.numeric, round, digits = digits) %>%
        select(-c(AIC, BIC, deviance, df.residual, logLik)) %>%
        as_tibble() %>%
        clean_names() %>%
        bind_cols(mse_and_rmse) %>%
        select(r_squared, adj_r_squared, mse, rmse, everything())
    }

    if (print) regression_summaries <- kable(regression_summaries)

    regression_summaries
  }


# Internal helpers for transform-aware extraction ----

# Resolve the LHS of the model formula into pieces we need: original variable
# name(s), the deparsed expression call, and a sanitized column name. For an
# untransformed LHS like `mpg`, `name` is the bare variable so existing output
# is unchanged. For a transformed LHS like `log(mpg)`, `name` is
# `make_clean_names()` of the expression (e.g. "log_mpg").
outcome_info <- function(model) {
  lhs_expr <- formula.tools::lhs(formula(model))
  expr_str <- paste(deparse(lhs_expr), collapse = "")
  lhs_vars <- all.vars(lhs_expr)
  transformed <- !(length(lhs_vars) == 1L && identical(expr_str, lhs_vars))
  name <- if (transformed) {
    janitor::make_clean_names(expr_str)
  } else {
    lhs_vars[1]
  }
  list(
    expr     = lhs_expr,
    vars     = lhs_vars,
    name     = name,
    name_hat = paste0(name, "_hat")
  )
}

# Original predictor variable names from the RHS, e.g. for
# `mpg ~ poly(hp, 2)` returns "hp".
predictor_vars <- function(model) {
  formula(model) %>%
    formula.tools::rhs() %>%
    all.vars()
}

# Try to recover the data frame the model was fit on. Returns NULL if the
# original data isn't reachable (e.g. fit with anonymous data).
original_model_data <- function(model) {
  tryCatch(
    eval(model$call$data, environment(formula(model))),
    error = function(e) NULL
  )
}

# Predictor columns to include in get_regression_points() output. Prefer the
# original (untransformed) columns from the source data, aligned to the rows
# that survived na.omit during fitting. If we can't reach the source data,
# fall back to the model frame minus the outcome.
predictor_columns <- function(mf, src, pvars) {
  if (!is.null(src) && all(pvars %in% names(src))) {
    out <- src[rownames(mf), pvars, drop = FALSE]
    rownames(out) <- NULL
    return(out)
  }
  mf[, -1, drop = FALSE]
}

# Check input functions ----
input_checks <- function(model, digits = 3, print = FALSE,
                         default_categorical_levels = FALSE) {
  if (!inherits(model, "lm")) {
    stop(paste(
      "Only `lm()` and `glm()` models are supported."
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
