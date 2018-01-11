#' Sampling from a tub of balls
#'
#' Counting the number of red balls in 10 samples of size n = 50 balls from
#' \url{https://github.com/ismayc/moderndiver-book/raw/master/images/sampling1.jpg}
#'
#' @format A data frame 10 rows representing different groups of students' 
#' samples of size n = 50 and 5 variables
#' \describe{
#'   \item{Group}{Group name}
#'   \item{red}{Number of red balls sampled}
#'   \item{white}{Number of white balls sampled}
#'   \item{green}{Number of green balls sampled}
#'   \item{n}{Total number of balls samples}
#' }
#' @examples
#' # To convert data frame to tidy data (long) format, run:
#' library(dplyr)
#' library(ggplot2)
#' red_ball_samples <- red_ball_samples %>%
#'   mutate(prop_red = red / n)
#' ggplot(red_ball_samples, aes(x = prop_red)) +
#'   geom_histogram(binwidth = 0.05) +
#'   labs(x = expression(hat(p)), y = "Number of samples", title = "Sampling distribution of p_hat based on n = 50")
"ball_samples"