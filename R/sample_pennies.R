#' A sample of 50 US pennies
#'
#' A sample of 50 pennies contained in a 50 cent roll from Florence Bank on
#' Friday February 1, 2019 in downtown Northampton, Massachusetts, USA \url{https://goo.gl/maps/AF88fpvVfm12}.
#'
#' @format A data frame of 40 rows representing 40 randomly sampled pennies from \code{\link{pennies}} and 2 variables
#' \describe{
#'   \item{ID}{Variable used to uniquely identify each penny.}
#'   \item{year}{Year of minting.}
#' }
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' 
#' ggplot(sample_pennies, aes(x = year)) +
#'  geom_histogram(binwidth = 5, boundary = 2000)
"sample_pennies"
