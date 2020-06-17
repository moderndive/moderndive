#' A sampling bowl of red and white balls
#'
#' A sampling bowl used as the population in a simulated sampling exercise. Also
#' known as the urn sampling framework \url{https://en.wikipedia.org/wiki/Urn_problem}.
#'
#' @format A data frame 2400 rows representing different balls in the bowl, of which
#' 900 are red and 1500 are white.
#' \describe{
#'   \item{ball_ID}{ID variable used to denote all balls. Note this value is not
#'   marked on the balls themselves}
#'   \item{color}{color of ball: red or white}
#' }
#' @examples
#' library(dplyr)
#' library(ggplot2)
#'
#' # Take 10 different samples of size n = 50 balls from bowl
#' bowl_samples_simulated <- bowl %>%
#'   rep_sample_n(50, reps = 10)
#'
#' # Compute 10 different p_hats (prop red) based on 10 different samples of
#' # size n = 50
#' p_hats <- bowl_samples_simulated %>%
#'   group_by(replicate, color) %>%
#'   summarize(count = n()) %>%
#'   mutate(proportion = count / 50) %>%
#'   filter(color == "red")
#'
#' # Plot sampling distribution
#' ggplot(p_hats, aes(x = proportion)) +
#'   geom_histogram(binwidth = 0.05) +
#'   labs(
#'     x = expression(hat(p)), y = "Number of samples",
#'     title = "Sampling distribution of p_hat based 10 samples of size n = 50"
#'   )
"bowl"



#' Sampling from a bowl of balls
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
#' @seealso \code{\link{bowl}}
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
#'   labs(
#'     x = expression(hat(p)), y = "Number of samples",
#'     title = "Sampling distribution of p_hat based 10 samples of size n = 50"
#'   )
"bowl_samples"



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
#' @seealso \code{\link{bowl}}
#' @examples
#' library(ggplot2)
#'
#' # Plot sampling distributions
#' ggplot(tactile_prop_red, aes(x = prop_red)) +
#'   geom_histogram(binwidth = 0.025) +
#'   labs(
#'     x = expression(hat(p)), y = "Number of samples",
#'     title = "Sampling distribution of p_hat based 33 samples of size n = 50"
#'   )
"tactile_prop_red"



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
#' ggplot(bowl_sample_1, aes(x = color)) +
#'   geom_bar() +
#'   labs(title = "50 sampled bals from bowl")
"bowl_sample_1"
