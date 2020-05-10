#' Parallel slopes model
#'
#' \code{geom_parallel_slopes()} fits parallel slopes model and adds its line
#' output(s) to a \code{ggplot} object. Basically, it fits a unified model with
#' intercepts varying between groups (which should be supplied as standard
#' {ggplot2} grouping aesthetics: \code{group}, \code{color}, \code{fill},
#' etc.). This function has the same nature as \code{geom_smooth()} from
#' {ggplot2} package, but provides functionality that \code{geom_smooth()}
#' currently doesn't have.
#'
#' @param se Display confidence interval around model lines? \code{TRUE} by
#'   default.
#' @param formula Formula to use per group in parallel slopes model. Basic
#'   linear \code{y ~ x} by default.
#' @param n Number of points per group at which to evaluate model.
#' @inheritParams ggplot2::layer
#' @inheritParams ggplot2::geom_smooth
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
#'   geom_point() +
#'   geom_parallel_slopes(se = FALSE)
#'
#' # Basic usage
#' ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
#'   geom_point() +
#'   geom_parallel_slopes()
#' ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
#'   geom_point() +
#'   geom_parallel_slopes(se = FALSE)
#'
#' # Supply custom aesthetics
#' ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
#'   geom_point() +
#'   geom_parallel_slopes(se = FALSE, size = 4)
#'
#' # Fit non-linear model
#' example_df <- house_prices %>%
#'   slice(1:1000) %>%
#'   mutate(
#'     log10_price = log10(price),
#'     log10_size = log10(sqft_living)
#'   )
#' ggplot(example_df, aes(x = log10_size, y = log10_price, color = condition)) +
#'   geom_point(alpha = 0.1) +
#'   geom_parallel_slopes(formula = y ~ poly(x, 2))
#'
#' # Different grouping
#' ggplot(example_df, aes(x = log10_size, y = log10_price)) +
#'   geom_point(alpha = 0.1) +
#'   geom_parallel_slopes(aes(fill = condition))
#' @export
geom_parallel_slopes <- function(mapping = NULL, data = NULL,
                                 position = "identity", ...,
                                 se = TRUE, formula = y ~ x, n = 100,
                                 na.rm = FALSE, show.legend = NA,
                                 inherit.aes = TRUE) {
  # Possibly warn about not needing to pass `method` argument
  dots <- list(...)
  if ("method" %in% names(dots)) {
    warning(
      "`geom_parallel_slopes()` doesn't need a `method` argument ",
      '("lm" is used).',
      call. = FALSE
    )

    dots <- dots[setdiff(names(dots), "method")]
  }

  # Construct layer params
  params <- c(list(na.rm = na.rm, se = se, formula = formula, n = n), dots)

  ggplot2::layer(
    geom = ggplot2::GeomSmooth, stat = StatParallelSlopes, data = data,
    mapping = mapping, position = position, params = params,
    inherit.aes = inherit.aes, show.legend = show.legend
  )
}

StatParallelSlopes <- ggplot2::ggproto(
  "StatParallelSlopes", ggplot2::Stat,
  required_aes = c("x", "y"),

  compute_panel = function(data, scales, se = TRUE, formula = y ~ x, n = 100) {
    if (nrow(data) == 0) {
      return(data[integer(0), ])
    }

    # Compute model data
    model_info <- compute_model_info(data, formula)
    formula <- model_info$formula
    data <- model_info$data

    # Fit model
    model <- stats::lm(formula = formula, data = data)

    # Compute prediction from model based on sequence of x-values defined for
    # every group separately
    stats <- lapply(
      X = split(data, data$group), FUN = predict_per_group,
      model = model, se = se, n = n
    )

    # Combine predictions into one data frame
    dplyr::bind_rows(stats)
  }
)

compute_model_info <- function(data, formula) {
  if (has_unique_value(data$group)) {
    # Apparently, in {ggplot2} 'group' column is always present at the stage of
    # computing panel data. It is filled with `-1` if it wasn't
    # supplied as aesthetic and with `1` if it has only one unique value.
    warning(
      "`geom_parallel_slopes()` didn't recieve a grouping variable with more ",
      "than one unique value. Make sure you supply one. Basic model is fitted.",
      call. = FALSE
    )
  } else {
    data$group <- as.factor(data$group)
    # Actually make model to have parallel slopes
    formula <- as.formula(paste0(deparse(formula), " + group"))
  }

  list(formula = formula, data = data)
}

predict_per_group <- function(group_df, model, se, n) {
  # This code is a modified version of `ggplot2:::predictdf.default`

  # Create a data on which to perform prediction
  x_seq <- seq(min(group_df$x), max(group_df$x), length.out = n)
  group_seq <- rep(group_df$group[1], n)
  new_data <- data.frame(x = x_seq, group = group_seq)

  # Perform prediction
  pred <- stats::predict(
    model,
    newdata = new_data, se.fit = se,
    interval = if (se) "confidence" else "none"
  )

  # Convert prediction to "ggplot2 format"
  if (isTRUE(se)) {
    fit <- as.data.frame(pred$fit)
    names(fit) <- c("y", "ymin", "ymax")

    res <- data.frame(x = x_seq, fit, se = pred$se.fit)
  } else {
    res <- data.frame(x = x_seq, y = as.vector(pred))
  }

  # Restore columns that describe group with unique value (like color, etc.)
  # so that they can be used in output plot
  restore_unique_cols(res, group_df)
}

# Combination of source code from `ggplot2::StatSmooth$compute_panel` and
# `ggplot2:::uniquecols`
restore_unique_cols <- function(new, old) {
  is_unique <- sapply(old, has_unique_value)
  unique_df <- old[1, is_unique, drop = FALSE]
  rownames(unique_df) <- seq_len(nrow(unique_df))

  missing <- !(names(unique_df) %in% names(new))

  cbind(new, unique_df[rep(1, nrow(new)), missing, drop = FALSE])
}

has_unique_value <- function(x) {
  length(unique(x)) <= 1
}
