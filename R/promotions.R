#' Bank manager recommendations based on (binary) gender
#'
#' Data from a 1970's study on whether gender influences hiring recommendations.
#' 
#' @format A data frame with 463 observations on the following 13 variables.
#' \describe{
#'   \item{id}{Identification variable used to distinguish rows.}
#'   \item{gender}{(binary) gender: a factor with two levels `male` and `female`}
#'   \item{decision}{a factor with two levels: `promoted` and `not`}
#' }
#' @source Rosen B and Jerdee T. 1974. Influence of sex role stereotypes on personnel 
#' decisions. Journal of Applied Psychology 59(1):9-14.
#' @seealso The data in `gender_promotions` is a tidyverse-frienly transformation of \code{\link[openintro]{gender.discrimination}}.
#' @examples
#' library(dplyr)
#' glimpse(promotions)
"promotions"




