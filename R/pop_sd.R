#' Calculate Population Standard Deviation
#'
#' This function calculates the population standard deviation for a numeric vector.
#'
#' @param x A numeric vector for which the population standard deviation should be calculated.
#'
#' @return A numeric value representing the population standard deviation of the vector.
#' @examples
#' # Example usage:
#' library(dplyr)
#' df <- data.frame(weight = c(2, 4, 6, 8, 10))
#' df |> 
#'   summarize(population_mean = mean(weight), 
#'             population_sd = pop_sd(weight))
#' 
#' @export
pop_sd <- function(x) {
  if (!is.numeric(x)) {
    stop("Input must be a numeric vector.")
  }
  
  sqrt(mean(x^2) - mean(x)^2)
}
