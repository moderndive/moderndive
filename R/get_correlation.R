#' Get correlation value in a tidy way
#'
#' Determine the Pearson correlation coefficient between an outcome variable
#' on the left-hand side of `formula` and one or more explanatory variables
#' on the right-hand side, using pipeable and formula-friendly syntax.
#'
#' For a single right-hand side variable, the result is a 1-column tibble
#' (or one row per group if `data` is grouped) named `cor`. For multiple
#' right-hand side variables, the result is a long tibble with one row per
#' (predictor, group) combination by default; pass `wide = TRUE` to pivot
#' it to one column per predictor.
#'
#' @param data a data frame object
#' @param formula a formula with the outcome variable on the left and one
#'   or more explanatory variables on the right (e.g. `y ~ x` or
#'   `y ~ x1 + x2 + x3`).
#' @param na.rm a logical value indicating whether NA values should be
#'   stripped before the computation proceeds.
#' @param wide if `TRUE` and the formula has more than one right-hand-side
#'   variable, pivot the result wider so that each predictor becomes a
#'   column. Has no effect on single-predictor formulas. Default `FALSE`.
#' @param quiet if `TRUE`, suppress the informational message that points
#'   to `corrr::correlate()` for full pairwise correlation matrices.
#'   Default `FALSE`.
#' @param ... further arguments passed to [stats::cor()]
#'
#' @return A tibble. For a single right-hand side variable, a 1×1 tibble
#'   (or 1 row per group) with column `cor`. For multiple right-hand side
#'   variables: long format (default) with columns `predictor` and `cor`
#'   (plus any grouping variables), or wide format (`wide = TRUE`) with
#'   one column per predictor.
#' @importFrom magrittr "%>%"
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom dplyr all_of
#' @importFrom dplyr across
#' @importFrom dplyr any_of
#' @importFrom dplyr group_vars
#' @importFrom dplyr select
#' @importFrom dplyr summarize
#' @importFrom tidyr pivot_longer
#' @importFrom tidyr pivot_wider
#' @importFrom tibble as_tibble
#' @importFrom stats cor
#' @export
#'
#' @examples
#' library(moderndive)
#' library(dplyr)
#'
#' # Single explanatory variable:
#' mtcars %>%
#'   get_correlation(formula = mpg ~ cyl)
#'
#' # Multiple explanatory variables — long format:
#' mtcars %>%
#'   get_correlation(formula = mpg ~ hp + cyl + wt, quiet = TRUE)
#'
#' # Multiple explanatory variables — wide format:
#' mtcars %>%
#'   get_correlation(
#'     formula = mpg ~ hp + cyl + wt,
#'     wide    = TRUE,
#'     quiet   = TRUE
#'   )
#'
#' # Group by one variable:
#' mtcars %>%
#'   group_by(am) %>%
#'   get_correlation(formula = mpg ~ cyl)
#'
#' # Group by two variables:
#' mtcars %>%
#'   group_by(am, gear) %>%
#'   get_correlation(formula = mpg ~ cyl)
get_correlation <- function(data, formula, na.rm = FALSE,
                            wide = FALSE, quiet = FALSE, ...) {
  check_correlation_args(data, formula)

  outcome_variable <- formula %>%
    lhs() %>%
    all.vars()
  explanatory_variables <- formula %>%
    rhs() %>%
    all.vars()
  grouping_variables <- data %>%
    group_vars()

  check_formula_args(data, formula, outcome_variable, explanatory_variables)

  # Helper that mirrors the historical na.rm semantics: only inject
  # `use = "complete.obs"` when na.rm = TRUE, otherwise leave `use` alone
  # so that anything the user passes via `...` (e.g. `use = "everything"`,
  # `method = "spearman"`) takes effect without conflict.
  cor_pair <- function(x, y) {
    if (isTRUE(na.rm)) {
      cor(x, y, use = "complete.obs", ...)
    } else {
      cor(x, y, ...)
    }
  }

  # Single-predictor branch: keep the historical 1×1 (or n-groups × 1) output.
  if (length(explanatory_variables) == 1L) {
    cols <- c(outcome_variable, explanatory_variables, grouping_variables)
    correlation <- data %>%
      select(all_of(cols)) %>%
      summarize(cor = cor_pair(
        !!sym(outcome_variable),
        !!sym(explanatory_variables)
      ))
    return(correlation)
  }

  # Multi-predictor branch.
  if (!isTRUE(quiet)) {
    message(
      "Computing correlations of `", outcome_variable, "` against ",
      length(explanatory_variables), " predictors. ",
      "For a full pairwise correlation matrix that also includes ",
      "predictor-predictor correlations, see `corrr::correlate()`. ",
      "Set `quiet = TRUE` to suppress this message."
    )
  }

  cols <- c(outcome_variable, explanatory_variables, grouping_variables)
  cor_wide <- data %>%
    select(all_of(cols)) %>%
    summarize(across(
      all_of(explanatory_variables),
      ~ cor_pair(.x, !!sym(outcome_variable))
    )) %>%
    as_tibble()

  if (isTRUE(wide)) {
    return(cor_wide)
  }

  cor_wide %>%
    pivot_longer(
      cols      = all_of(explanatory_variables),
      names_to  = "predictor",
      values_to = "cor"
    ) %>%
    select(all_of(c(grouping_variables, "predictor", "cor")))
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

  if (length(outcome_variable) != 1L) {
    stop(paste(
      "The left hand side of the `formula` must contain exactly one",
      "outcome variable."
    ))
  }

  if (!(outcome_variable %in% names(data))) {
    stop(paste0(
      "The response variable `", outcome_variable,
      "` cannot be found in this data frame."
    ))
  }

  missing_rhs <- setdiff(explanatory_variable, names(data))
  if (length(missing_rhs) > 0) {
    stop(paste0(
      "The following explanatory variable(s) cannot be found in this ",
      "data frame: ", paste(missing_rhs, collapse = ", "), "."
    ))
  }
}
