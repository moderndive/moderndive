#' Tactile sample of size 50 from a bowl of balls
#'
#' A single tactile sample of size n = 50 balls from
#' \url{https://github.com/moderndive/moderndive/blob/master/data-raw/sampling_bowl.jpeg}
#'
#' @format A data frame of 50 rows representing different balls and 1 variable.
#' \describe{
#'   \item{color}{Color of ball sampled}
#' }
#' @seealso \code{\link{bowl}}
#' @examples
#' library(ggplot2)
#' 
#' # Barplot of distribution of balls in sample
#' ggplot(tactile_shovel_1, aes(x = color)) +
#'   geom_bar() +
#'   labs(title = "50 sampled bals from bowl")
"tactile_shovel_1"
