#' A sample of 50 pennies
#'
#' A sample of 50 pennies contained in a 50 cent roll from Florence Bank on
#' Friday February 1, 2019 in downtown Northampton, Massachusetts, USA \url{https://goo.gl/maps/cko18WXRfVs}.
#'
#' @format A data frame of 40 rows representing 40 randomly sampled pennies from \code{\link{pennies}} and 2 variables
#' \describe{
#'   \item{ID}{Variable used to uniquely identify each penny.}
#'   \item{year}{Year of minting.}
#' }
#' @seealso \code{\link{pennies}}, \code{\link{pennies_sample}}
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' 
#' ggplot(pennies_sample_2, aes(x = year)) +
#'  geom_histogram(binwidth = 5, boundary = 2000)
"pennies_sample_2"
