#' Sampling from a tub of balls
#'
#' Counting the number of red balls in 10 samples of size n = 50 balls from
#' \url{https://github.com/moderndive/moderndive/blob/master/data-raw/sampling_bowl.jpeg}
#'
#' @format A data frame 10 rows representing different groups of students' 
#' samples of size n = 50 and 5 variables
#' \describe{
#'   \item{group}{Group name}
#'   \item{red}{Number of red balls sampled}
#'   \item{white}{Number of white balls sampled}
#'   \item{green}{Number of green balls sampled}
#'   \item{n}{Total number of balls samples}
#' }
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' 
#' # Compute proportion red
#' bowl_samples <- bowl_samples %>%
#'   mutate(prop_red = red / n)
#'   
#' # Plot sampling distributions
#' ggplot(bowl_samples, aes(x = prop_red)) +
#'   geom_histogram(binwidth = 0.05) +
#'   labs(x = expression(hat(p)), y = "Number of samples", 
#'   title = "Sampling distribution of p_hat based 10 samples of size n = 50")
"bowl_samples"
