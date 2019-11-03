#' A sample of 50 pennies
#'
#' A sample of 50 pennies contained in a 50 cent roll from Florence Bank on
#' Friday February 1, 2019 in downtown Northampton, Massachusetts, USA 
#' \url{https://goo.gl/maps/AF88fpvVfm12}.
#'
#' @format A data frame of 50 rows representing 50 sampled pennies and 2 variables
#' \describe{
#'   \item{ID}{Variable used to uniquely identify each penny.}
#'   \item{year}{Year of minting.}
#' }
#' @note The original \code{pennies_sample} has been renamed \code{\link{orig_pennies_sample}} 
#' as of \code{moderndive} v0.3.0.
#' @examples
#' library(ggplot2)
#' 
#' ggplot(pennies_sample, aes(x = year)) +
#'  geom_histogram(binwidth = 5, boundary = 2000)
"pennies_sample"



#' Bootstrap resamples of a sample of 50 pennies
#'
#' 35 bootstrap resamples with replacement of sample of 50 pennies contained in 
#' a 50 cent roll from Florence Bank on Friday February 1, 2019 in downtown Northampton, 
#' Massachusetts, USA \url{https://goo.gl/maps/AF88fpvVfm12}. The original sample
#' of 50 pennies is available in \code{\link{pennies_sample}} .
#'
#' @format A data frame of 1750 rows representing 35 students' bootstrap 
#' resamples of size 50 and 3 variables
#' \describe{
#'   \item{replicate}{ID variable of replicate/resample number.}
#'   \item{name}{Name of student}
#'   \item{year}{Year on resampled penny}
#' }
#' @seealso \code{\link{pennies_sample}} 
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' bootstrap_sample_means <- pennies_resamples %>% 
#'   group_by(name) %>% 
#'   summarize(sample_mean = mean(year))
#' 
#' ggplot(bootstrap_sample_means, aes(x = sample_mean)) +
#'  geom_histogram(binwidth = 2.5) +
#'   labs(x = "sample mean year", title = "Bootstrap distribution of sample mean year")
"pennies_resamples"



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



#' A random sample of 40 pennies sampled from the \code{pennies} data frame
#'
#' A dataset of 40 pennies to be treated as a random sample with \code{\link{pennies}} acting
#' as the population. Data on these pennies were recorded in 2011.
#'
#' @format A data frame of 40 rows representing 40 randomly sampled pennies from \code{\link{pennies}} and 2 variables
#' \describe{
#'   \item{year}{Year of minting}
#'   \item{age_in_2011}{Age in 2011}
#' }
#' @source StatCrunch \url{https://www.statcrunch.com/app/index.php?dataid=301596}
#' @seealso \code{\link{pennies}}
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' 
#' # Take 50 different resamples/bootstraps from the original sample
#' many_bootstraps <- orig_pennies_sample %>%
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
"orig_pennies_sample"
