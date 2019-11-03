globalVariables(c(
  "."
))

#' Plot parallel slopes model
#' 
#' Output a visualization of linear regression when you have one numerical 
#' and one categorical explanatory/predictor variable: a separate colored 
#' regression line for each level of the categorical variable
#' 
#' @inheritParams stats::lm
#' @param y Character string of outcome variable in \code{data}
#' @param num_x Character string of numerical explanatory/predictor variable in
#'   \code{data}
#' @param cat_x Character string of categorical explanatory/predictor variable
#'   in \code{data}
#' @param alpha Transparency of points
#' @return A \code{\link[ggplot2]{ggplot}} object.
#' @importFrom glue glue
#' @importFrom stats as.formula
#' @import ggplot2
#' @export
#'
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(moderndive)
#' 
#' # log10() transformations
#' house_prices <- house_prices %>%
#'   mutate(
#'     log10_price = log10(price),
#'     log10_size = log10(sqft_living)
#'   )
#'   
#' # Output parallel slopes model plot:
#' gg_parallel_slopes(y = "log10_price", num_x = "log10_size", cat_x = "condition",
#'                    data = house_prices, alpha = 0.1) +
#'   labs(x = "log10 square feet living space", y = "log10 price in USD",
#'        title = "House prices in Seattle: Parallel slopes model")
#'
#' # Compare with interaction model plot:
#' ggplot(house_prices, aes(x = log10_size, y = log10_price, col = condition)) +
#'   geom_point(alpha = 0.1) +
#'   geom_smooth(method = "lm", se = FALSE, size = 1) +
#'   labs(x = "log10 square feet living space", y = "log10 price in USD", 
#'        title = "House prices in Seattle: Interaction model")
gg_parallel_slopes <- function(y, num_x, cat_x, data, alpha = 1){
  # Define model formula and fitted/predicted value
  formula <- glue::glue(y, " ~ ", num_x, " + ", cat_x) %>% 
    as.formula()
  y_hat <- paste(y, "_hat", sep = "")
  
  # Get fitted values for parallel slopes model
  model_points <- data %>%
    lm(formula, data = .) %>%
    get_regression_points()
  
  plot <- 
    # Plot scatterplot of points
    ggplot(data, aes_string(x = num_x, y = y, col = cat_x)) +
    geom_point(alpha = alpha) +
    # Add parallel slopes lines. Note the data and aes(y = ) override:
    geom_line(data = model_points, aes_string(y = y_hat), size = 1, show.legend = FALSE) +
    guides(colour = guide_legend(override.aes = list(alpha = 1)))
  
  return(plot)
}