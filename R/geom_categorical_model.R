#' Categorical bivariate regression model
#' 
#' \code{geom_catergorical_model()} fits a regression model using the categorical
#' x axis as the explanatory variable, and visualizes the model's fitted values 
#' as piecewise horizontal line segments. Confidence interval bands can be
#' included in the visualization of the model. Like \code{geom_parallel_slopes},
#' this function has the same nature as \code{geom_smooth()} from
#' the {ggplot2} package, but provides functionality that \code{geom_smooth()}
#' currently doesn't have.
#'
#' @param se Display confidence interval around model lines? \code{TRUE} by
#'   default.
#'
#' @param level Level of confidence interval to use (0.95 by default).
#'
#' @inheritParams ggplot2::layer
#' @inheritParams ggplot2::geom_smooth
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' 
#' p <- ggplot(mpg, aes(x=drv, y=hwy)) +
#'   geom_point() +
#'   geom_categorical_model()
#' p
#' 
#' # You can use different colors for each categorical level
#' p %+% aes(color=drv)
#' 
#' # But mapping the color aesthetic doesn't change the model that is fit
#' p %+% aes(color=class)
#'   
#' @export
#' @seealso \code{\link{geom_parallel_slopes()}}
geom_categorical_model <- function(mapping = NULL, data = NULL,
                                   position = "identity", ...,
                                   se = TRUE, level = 0.95,
                                   na.rm = FALSE, show.legend = NA,
                                   inherit.aes = TRUE
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
  stat_params <- list(na.rm = na.rm, se = se, level = level)
  
  params <- c(stat_params, dots)
  
  ggplot2::layer(geom = ggplot2::GeomSmooth, stat = StatCategoricalModel,
                 data = data, mapping = mapping, position = position,
                 params = params, inherit.aes = inherit.aes,
                 show.legend = show.legend
                 )
}

StatCategoricalModel <- ggplot2::ggproto("StatCategoricalModel", ggplot2::Stat,
  
  required_aes = c("x", "y"),
  
  compute_panel = function(data, scales, se = TRUE, level = .95) {
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
    model <- stats::lm(formula = y ~ x, data = data)
    
    # Compute prediction from model based on sequence of x-values defined for
    # every group
    groups <- split(data, data$group)
    
    groups_new_data <- lapply(X = groups, FUN = compute_group_new_categorical_data)
    
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
    
    # Remove color if it doesn't map to levels of the explanatory variable
    if ("colour" %in% names(stats)) {
      
      n_levels <- nrow(dplyr::distinct(stats, x_orig))
      n_color_groups <- nrow(dplyr::distinct(stats, x_orig, colour))
      
      if (n_levels != n_color_groups) {
        stats <- stats[setdiff(names(stats), "colour")]
      }
      
    }

    # x_orig has served it's purpose, goodbye
    stats <- stats[setdiff(names(stats), "x_orig")]
    
    return(stats)
    
  }
)


compute_group_new_categorical_data <- function(group_df) {

  n <- 100
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
