#' A population of 800 pennies sampled in 2011
#'
#' A dataset of 800 pennies to be treated as a sampling population. Data on 
#' these pennies were recorded in 2011.
#'
#' @format A data frame of 800 rows representing different pennies and 2 variables
#' \describe{
#'   \item{year}{Year of minting}
#'   \item{age_in_2011}{Age in 2011}
#' }
#' @source StatCrunch \url{https://www.statcrunch.com/app/index.php?dataid=301596}
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' 
#' # Take 25 different samples of size n = 50 pennies from population
#' many_samples <- pennies %>%
#'   rep_sample_n(size = 50, reps = 25)
#' many_samples
#' 
#' # Compute mean year of minting for each sample
#' sample_means <- many_samples %>% 
#'   group_by(replicate) %>% 
#'   summarize(mean_year = mean(year))
#'
#' # Plot sampling distribution
#' ggplot(sample_means, aes(x = mean_year)) +
#'   geom_histogram(binwidth = 1, color = "white") +
#'   labs(x = expression(bar(x)), y = "Number of samples", 
#'   title = "Sampling distribution of x_bar based 25 samples of size n = 50")
"pennies"