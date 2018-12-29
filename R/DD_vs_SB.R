#' Dunkin Donuts vs Starbucks 
#'
#' Number of Dunkin Donuts & Starbucks, median income, and population in 1024 
#' census tracts in eastern Massachusetts in 2016. 
#'
#' @format A data frame of 1024 rows representing census tracts and 6 variables
#' \describe{
#'   \item{county}{County where census tract is located. Either Bristol, Essex, Middlesex, Norfolk, Plymouth, or Suffolk county}
#'   \item{FIPS}{Federal Information Processing Standards code identifying census tract}
#'   \item{median_income}{Median income of census tract}
#'   \item{population}{Population of census tract}
#'   \item{shop_type}{Coffee shop type: Dunkin Donuts or Starbucks}
#'   \item{shops}{Number of shops}
#' }
#' @source US Census Bureau. Code used to scrape data available at \url{https://github.com/DelaneyMoran/FinalProject}
#' @examples
#' # Compute correlation between a census tract's median income and number of cafes of
#' # each type after removing two cases where median_income is missing
#' library(dplyr)
#' DD_vs_SB %>% 
#'   mutate(shops_per_1000 = 1000 * shops/population) %>% 
#'   filter(!is.na(median_income)) %>% 
#'   group_by(shop_type) %>% 
#'   summarize(cor = cor(median_income, shops_per_1000))
"DD_vs_SB"