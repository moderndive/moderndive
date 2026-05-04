#' Interactive 3D scatterplot with a fitted regression plane
#'
#' Build an interactive 3D scatterplot of an outcome against two numeric
#' predictors, overlaid with the fitted plane from `lm(formula, data)`.
#' Returns a [`plotly`][plotly::plotly] htmlwidget that you can render in
#' an R Markdown / Quarto document or in the RStudio Viewer.
#'
#' Requires the suggested package `plotly`. Install it with
#' `install.packages("plotly")` if you see an error about it being missing.
#'
#' @param data a data frame containing the three variables in `formula`.
#' @param formula a formula of the form `z ~ x + y`: a single outcome on
#'   the left-hand side and exactly two predictor variables on the
#'   right-hand side. In-formula transformations (e.g. `log(z) ~ x + y`)
#'   are not supported in this version — apply transformations to `data`
#'   beforehand.
#' @param n grid resolution per axis used to draw the regression plane.
#'   Default `25`.
#'
#' @return A [`plotly`][plotly::plotly] htmlwidget object.
#' @importFrom magrittr "%>%"
#' @importFrom formula.tools lhs
#' @importFrom formula.tools rhs
#' @importFrom stats lm predict
#' @export
#' @seealso [get_regression_table()], [get_regression_points()]
#'
#' @examples
#' \dontrun{
#'   library(moderndive)
#'   plot_3d_regression(mtcars, mpg ~ hp + wt)
#' }
plot_3d_regression <- function(data, formula, n = 25) {
  if (!is_plotly_available()) {
    stop(
      "`plot_3d_regression()` requires the `plotly` package. ",
      "Install it with `install.packages(\"plotly\")` and try again.",
      call. = FALSE
    )
  }

  if (!is.data.frame(data)) {
    stop("The `data` argument must be a data frame.", call. = FALSE)
  }
  if (!rlang::is_formula(formula)) {
    stop("The `formula` argument is not recognized as a formula.", call. = FALSE)
  }
  check_numeric(n)

  lhs_expr <- formula.tools::lhs(formula)
  rhs_expr <- formula.tools::rhs(formula)
  outcome_var    <- all.vars(lhs_expr)
  predictor_vars <- all.vars(rhs_expr)

  if (length(outcome_var) != 1L) {
    stop(
      "The left-hand side of `formula` must contain exactly one outcome ",
      "variable.",
      call. = FALSE
    )
  }
  if (length(predictor_vars) != 2L) {
    stop(
      "The right-hand side of `formula` must contain exactly two predictor ",
      "variables (got ", length(predictor_vars), ").",
      call. = FALSE
    )
  }

  # Reject in-formula transformations — the regression plane and the raw
  # scatter would be on different scales, which would mislead viewers.
  lhs_str <- paste(deparse(lhs_expr), collapse = "")
  rhs_str <- paste(deparse(rhs_expr), collapse = "")
  expected_rhs <- paste(predictor_vars, collapse = " + ")
  if (lhs_str != outcome_var || rhs_str != expected_rhs) {
    stop(
      "In-formula transformations (e.g. `log(z) ~ x + y`) are not supported ",
      "by `plot_3d_regression()`. Transform the columns of `data` first, ",
      "then pass plain variable names.",
      call. = FALSE
    )
  }

  missing_vars <- setdiff(c(outcome_var, predictor_vars), names(data))
  if (length(missing_vars) > 0) {
    stop(
      "The following variable(s) cannot be found in `data`: ",
      paste(missing_vars, collapse = ", "), ".",
      call. = FALSE
    )
  }

  for (v in c(outcome_var, predictor_vars)) {
    if (!is.numeric(data[[v]])) {
      stop(
        "Variable `", v, "` must be numeric. ",
        "`plot_3d_regression()` plots a regression plane and so requires ",
        "all three variables to be continuous.",
        call. = FALSE
      )
    }
  }

  model <- lm(formula, data = data)

  x_seq <- seq(
    min(data[[predictor_vars[1]]], na.rm = TRUE),
    max(data[[predictor_vars[1]]], na.rm = TRUE),
    length.out = n
  )
  y_seq <- seq(
    min(data[[predictor_vars[2]]], na.rm = TRUE),
    max(data[[predictor_vars[2]]], na.rm = TRUE),
    length.out = n
  )
  grid <- expand.grid(stats::setNames(list(x_seq, y_seq), predictor_vars))
  z_pred <- matrix(
    stats::predict(model, newdata = grid),
    nrow = length(x_seq),
    ncol = length(y_seq)
  )

  build_3d_plot(
    data           = data,
    outcome_var    = outcome_var,
    predictor_vars = predictor_vars,
    x_seq          = x_seq,
    y_seq          = y_seq,
    z_pred         = z_pred
  )
}

# Internal indirection so tests can mock this and exercise the
# missing-package branch without actually uninstalling plotly.
is_plotly_available <- function() {
  requireNamespace("plotly", quietly = TRUE)
}

# Internal wrapper for the actual plotly call. Isolated so tests can
# assert structure without rendering the widget; also marked nocov
# because rendering an htmlwidget in a test session is not portable.
build_3d_plot <- function(data, outcome_var, predictor_vars,
                          x_seq, y_seq, z_pred) {
  # nocov start
  plotly::plot_ly(
    x    = data[[predictor_vars[1]]],
    y    = data[[predictor_vars[2]]],
    z    = data[[outcome_var]],
    type = "scatter3d",
    mode = "markers",
    marker = list(size = 4),
    name = "data",
    showlegend = FALSE
  ) %>%
    plotly::add_surface(
      x         = x_seq,
      y         = y_seq,
      z         = t(z_pred),
      opacity   = 0.6,
      showscale = FALSE,
      name      = "regression plane"
    ) %>%
    plotly::layout(scene = list(
      xaxis = list(title = predictor_vars[1]),
      yaxis = list(title = predictor_vars[2]),
      zaxis = list(title = outcome_var)
    ))
  # nocov end
}
