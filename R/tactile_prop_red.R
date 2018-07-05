#' Tactile sampling from a tub of balls
#'
#' Counting the number of red balls in 33 tactile samples of size n = 50 balls from
#' \url{https://github.com/moderndive/moderndive/blob/master/data-raw/sampling_bowl.jpeg}
#'
#' @format A data frame of 33 rows representing different groups of students' 
#' samples of size n = 50 and 4 variables
#' \describe{
#'   \item{group}{Group members}
#'   \item{replicate}{Replicate number}
#'   \item{red_balls}{Number of red balls sampled out of 50}
#'   \item{prop_red}{Proportion red balls out of 50}
#' }
#' @examples
#' library(ggplot2)
#' 
#' # Plot sampling distributions
#' ggplot(tactile_prop_red, aes(x = prop_red)) +
#'   geom_histogram(binwidth = 0.025) +
#'   labs(x = expression(hat(p)), y = "Number of samples", 
#'   title = "Sampling distribution of p_hat based 33 samples of size n = 50")
"tactile_prop_red"
