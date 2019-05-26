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



#' Massachusetts Public High Schools Data
#'
#' Data on Massachusetts public high schools in 2017
#'
#' @format A data frame of 332 rows representing Massachusetts high schools and 4 variables
#' \describe{
#'   \item{school_name}{High school name.}
#'   \item{average_sat_math}{Average SAT math score. Note 58 of the original 390 values of this variable were missing; these rows were dropped from consideration.}
#'   \item{perc_disadvan}{Percent of the student body that are considered economically disadvantaged.}
#'   \item{size}{Size of school enrollment; small 13-341 students, medium 342-541 students, large 542-4264 students.}
#' }
#' @source The original source of the data are Massachusetts Department of 
#' Education reports \url{http://profiles.doe.mass.edu/state_report/}, however 
#' the data wad downloaded from Kaggle at \url{https://www.kaggle.com/ndalziel/massachusetts-public-schools-data}
#' @examples
#' library(ggplot2)
#' ggplot(MA_schools, aes(x = perc_disadvan, y = average_sat_math, color = size)) +
#'   geom_point() +
#'   geom_smooth(method = "lm", se = FALSE) +
#'   labs(y = "Math SAT score", x = "Percentage economically disadvantaged", color = "School size")
"MA_schools"



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



#' House Sales in King County, USA
#'
#' This dataset contains house sale prices for King County, which includes 
#' Seattle. It includes homes sold between May 2014 and May 2015. This dataset
#' was obtained from Kaggle.com \url{https://www.kaggle.com/harlfoxem/housesalesprediction/data}
#' 
#' @format A data frame with 21613 observations on the following 21 variables.
#' \describe{
#'   \item{id}{a notation for a house}
#'   \item{date}{Date house was sold}
#'   \item{price}{Price is prediction target}
#'   \item{bedrooms}{Number of Bedrooms/House}
#'   \item{bathrooms}{Number of bathrooms/bedrooms}
#'   \item{sqft_living}{square footage of the home}
#'   \item{sqft_lot}{square footage of the lot}
#'   \item{floors}{Total floors (levels) in house}
#'   \item{waterfront}{House which has a view to a waterfront}
#'   \item{view}{Has been viewed}
#'   \item{condition}{How good the condition is (Overall)}
#'   \item{grade}{overall grade given to the housing unit, based on King County grading system}
#'   \item{sqft_above}{square footage of house apart from basement}
#'   \item{sqft_basement}{square footage of the basement}
#'   \item{yr_built}{Built Year}
#'   \item{yr_renovated}{Year when house was renovated}
#'   \item{zipcode}{zip code}
#'   \item{lat}{Latitude coordinate}
#'   \item{long}{Longitude coordinate}
#'   \item{sqft_living15}{Living room area in 2015 (implies-- some renovations) This might or might not have affected the lotsize area}
#'   \item{sqft_lot15}{lotSize area in 2015 (implies-- some renovations)}
#' }
#' @source Kaggle \url{https://www.kaggle.com/harlfoxem/housesalesprediction}. 
#' Note data is released under a CC0: Public Domain license.
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' 
#' # Create variable log of house price
#' house_prices <- house_prices %>% 
#'   mutate(log_price = log(price))
#'   
#' # Plot histogram of log of house price
#' ggplot(house_prices, aes(x = log_price)) +
#'   geom_histogram()
#' 
"house_prices"



#' Teaching evaluations at the UT Austin
#'
#' The data are gathered from end of semester student evaluations for a large 
#' sample of professors from the University of Texas at Austin. In addition, six 
#' students rate the professors' physical appearance. The result is a data frame 
#' where each row contains a different course and each column has information on 
#' either the course or the professor \url{https://www.openintro.org/stat/data/?data=evals}
#' 
#' @format A data frame with 463 observations on the following 13 variables.
#' \describe{
#'   \item{ID}{Identification variable used to distinguish rows.}
#'   \item{score}{Average professor evaluation score: (1) very unsatisfactory - (5) excellent.}
#'   \item{age}{Age of professor.}
#'   \item{bty_avg}{Average beauty rating of professor.}
#'   \item{gender}{Gender of professor: female, male.}
#'   \item{ethnicity}{Ethnicity of professor: not minority, minority.}
#'   \item{language}{Language of school where professor received education: English or non-English.}
#'   \item{rank}{Rank of professor: teaching, tenure track, tenured.}
#'   \item{pic_outfit}{Outfit of professor in picture: not formal, formal.}
#'   \item{pic_color}{Color of professor’s picture: color, black & white.}
#'   \item{cls_did_eval}{Number of students in class who completed evaluation.}
#'   \item{cls_students}{Total number of students in class.}
#'   \item{cls_level}{Class level: lower, upper.}
#' }
#' @source Çetinkaya-Rundel M, Morgan KL, Stangl D. 2013. Looking Good on Course Evaluations. CHANCE 26(2). \url{https://chance.amstat.org/2013/04/looking-good/}
#' @examples
#' library(dplyr)
#' glimpse(evals)
"evals"



#' Data from Mythbusters' study on contagiousness of yawning
#'
#' From a study on whether yawning is contagious
#' \url{https://www.imdb.com/title/tt0768479/}.
#' The data here was derived from the final proportions of yawns given
#' in the show.
#'
#' @format A data frame of 50 rows representing each of the 50 participants
#' in the study.
#' \describe{
#'   \item{subj}{integer value corresponding to identifier variable of 
#'   subject ID}
#'   \item{group}{string of either \code{"seed"}, participant was shown a 
#'   yawner, or \code{"control"}, participant was not shown a yawner}
#'   \item{yawn}{string of either \code{"yes"}, the participant yawned, or
#'   \code{"no"}, the participant did not yawn}
#' }
#' @examples
#' library(ggplot2)
#' 
#' # Plot both variables as a stacked proportional bar chart
#' ggplot(mythbusters_yawn, aes(x = group, fill = yawn)) +
#'   geom_bar(position = "fill") +
#'   labs(x = "", y = "Proportion", 
#'   title = "Proportion of yawn and not yawn for each group")
"mythbusters_yawn"




