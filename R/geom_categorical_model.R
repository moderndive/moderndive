#' Parallel slopes model
#' 
#' \code{geom_catergorical_model()} fits parallel slopes model and adds its line
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
#' @inheritParams ggplot2::stat_smooth
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' 
#' @export
geom_categorical_model <- function(mapping = NULL, data = NULL,
                                   position = "identity", ...,
                                   se = TRUE, formula = y ~ x, n = 100,
                                   level = 0.95, na.rm = FALSE,
                                   show.legend = NA, inherit.aes = TRUE
                                   ) {
  # Possibly warn about not needing to pass `method` argument
  dots <- list(...)
  if ("method" %in% names(dots)) {
    warning(
      "`geom_categorical_model()` doesn't need a `method` argument ",
      '("lm" is used).',
      call. = FALSE
    )
    
    dots <- dots[setdiff(names(dots), "method")]
  }
  
  # Construct layer params
  stat_params <- c(na.rm = na.rm, se = se, formula = formula,
                   level = level, n = n)
  
  params <- c(stat_params, dots)
  
  ggplot2::layer(geom = ggplot2::GeomSmooth, stat = StatCategoricalModel,
                 data = data, mapping = mapping, position = position,
                 params = params, inherit.aes = inherit.aes,
                 show.legend = show.legend
                 )
}

StatCategoricalModel <- ggplot2::ggproto("StatCategoricalModel", ggplot2::Stat,
  
  required_aes = c("x", "y"),
  
  compute_panel = function(data, scales, se = TRUE, formula = y ~ x, n = 100, level=.95) {
    if (nrow(data) == 0) {
      return(data[integer(0), ])
    }
    
    if (!scales$x$is_discrete()) {
      warning("`geom_categorical_model()` only works with a discrete x axis variable",
              call. = FALSE
      )
      return(data[integer(0), ])
    }
    
    data$x <- factor(data$x)
    
    # Fit model
    model <- stats::lm(formula = formula, data = data)
    
    # Compute prediction from model based on sequence of x-values defined for
    # every group
    groups <- split(data, data$group)
    
    groups_new_data <- lapply(X = groups, FUN = compute_group_new_categorical_data,
                              scales = scales, n = n
                              )
    stats <- lapply(X = groups, FUN = predict_categorical_df,
                    model = model, se = se, level = level
                    )
    stats <- mapply(dplyr::left_join, groups_new_data, stats,
                    MoreArgs = list(by=c("x_orig"="x")),
                    SIMPLIFY = FALSE
                    )
    
    # Restore columns that describe group with unique value (like color, etc.)
    # so that they can be used in output plot
    stats <- mapply(restore_unique_cols, stats, groups, SIMPLIFY = FALSE)
    
    # Combine predictions into one data frame
    stats <- dplyr::bind_rows(stats)
    stats <- stats[setdiff(names(stats), "x_orig")]
    return(stats)
    
  }
)


compute_group_new_categorical_data <- function(group_df, scales, n) {

  support <- as.numeric(as.character(group_df$x[1])) + c(-.5, .5)
  
  x_seq <- seq(support[1], support[2], length.out = n)
  group_seq <- rep(group_df$group[1], n)
  
  new_data <- data.frame(x = x_seq, group = group_df$group[1],
                         x_orig = group_df$x[1]
                         )
  
  if (!("linetype" %in% colnames(group_df))) {
    if (as.numeric(group_df$x[1]) == 1) {
      new_data$linetype = 1 
    } else {
      new_data$linetype = 2
    }
  }

  return(new_data)
}

predict_categorical_df <- function(model, data, se, level) {
  # This code is a modified version of `ggplot2:::predictdf.default`
  
  # Perform prediction
  pred <- stats::predict(
    model, newdata = data[1, "x", drop=FALSE], se.fit = se, level = level,
    interval = if (se) "confidence" else "none"
  )
  
  # Convert prediction to "ggplot2 format"
  if (isTRUE(se)) {
    fit <- as.data.frame(pred$fit)
    names(fit) <- c("y", "ymin", "ymax")
    
    data.frame(x = data$x[1], fit, se = pred$se.fit)
  } else {
    data.frame(x = data$x[1], y = as.vector(pred))
  }
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
