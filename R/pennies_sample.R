#' A sample of 40 pennies sampled in 2011 from the \code{pennies} data frame
#'
#' A dataset of 40 pennies to be treated as a sample with \code{pennies} acting
#' as the population. Data on 
#' these pennies were recorded in 2011.
#'
#' @format A data frame of 40 rows representing different pennies and 2 variables
#' \describe{
#'   \item{year}{Year of minting}
#'   \item{age_in_2011}{Age in 2011}
#' }
#' @source StatCrunch \url{https://www.statcrunch.com/app/index.php?dataid=301596}
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' 
#' # Take 50 different resamples/bootstraps from the original sample
#' many_bootstraps <- pennies_sample %>%
#'   rep_sample_n(size = 40, replace = TRUE, reps = 50)
#' many_bootstraps
#' 
#' # Compute mean year of minting for each bootstrap sample
#' bootstrap_means <- many_bootstraps %>% 
#'   group_by(replicate) %>% 
#'   summarize(mean_year = mean(year))
#'
#' # Plot sampling distribution
#' ggplot(bootstrap_means, aes(x = mean_year)) +
#'   geom_histogram(binwidth = 1, color = "white") +
#'   labs(x = expression(bar(x)), y = "Number of samples", 
#'   title = "Bootstrap distribution of x_bar based 50 resamples of size n = 40")
"pennies_sample"
