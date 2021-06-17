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
#'   geom_histogram(binwidth = 5, boundary = 2000)
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
#'   geom_histogram(binwidth = 2.5) +
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
#'   labs(
#'     x = expression(bar(x)), y = "Number of samples",
#'     title = "Sampling distribution of x_bar based 25 samples of size n = 50"
#'   )
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
#'   labs(
#'     x = expression(bar(x)), y = "Number of samples",
#'     title = "Bootstrap distribution of x_bar based 50 resamples of size n = 40"
#'   )
"orig_pennies_sample"






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




#' Bank manager recommendations based on (binary) gender
#'
#' Data from a 1970's study on whether gender influences hiring recommendations.
#' Originally used in OpenIntro.org.
#'
#' @format A data frame with 48 observations on the following 3 variables.
#' \describe{
#'   \item{id}{Identification variable used to distinguish rows.}
#'   \item{gender}{gender (collected as a binary variable at the time of the study): a factor with two levels `male` and `female`}
#'   \item{decision}{a factor with two levels: `promoted` and `not`}
#' }
#' @source Rosen B and Jerdee T. 1974. Influence of sex role stereotypes on personnel
#' decisions. Journal of Applied Psychology 59(1):9-14.
#' @seealso The data in `promotions` is a slight modification of \code{\link[openintro]{gender_discrimination}}.
#' @examples
#' library(dplyr)
#' glimpse(promotions)
"promotions"


#' One permutation/shuffle of promotions
#'
#' Shuffled/permuted data from a 1970's study on whether gender influences hiring recommendations.
#'
#' @format A data frame with 48 observations on the following 3 variables.
#' \describe{
#'   \item{id}{Identification variable used to distinguish rows.}
#'   \item{gender}{shuffled/permuted (binary) gender: a factor with two levels `male` and `female`}
#'   \item{decision}{a factor with two levels: `promoted` and `not`}
#' }
#' @seealso \code{\link{promotions}}.
#' @examples
#' library(dplyr)
#' glimpse(promotions)
#' glimpse(promotions_shuffled)
"promotions_shuffled"


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
#' the data was downloaded from Kaggle at \url{https://www.kaggle.com/ndalziel/massachusetts-public-schools-data}
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
#'   mutate(shops_per_1000 = 1000 * shops / population) %>%
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
"house_prices"



#' Teaching evaluations at the UT Austin
#'
#' The data are gathered from end of semester student evaluations for a sample of 463 courses taught by
#' 94 professors from the University of Texas at Austin. In addition, six
#' students rate the professors' physical appearance. The result is a data frame
#' where each row contains a different course and each column has information on
#' either the course or the professor \url{https://www.openintro.org/data/index.php?data=evals}
#'
#' @format A data frame with 463 observations corresponding to courses on the following 13 variables.
#' \describe{
#'   \item{ID}{Identification variable for course.}
#'   \item{prof_ID}{Identification variable for professor. Many professors are included more than once in this dataset.}
#'   \item{score}{Average professor evaluation score: (1) very unsatisfactory - (5) excellent.}
#'   \item{age}{Age of professor.}
#'   \item{bty_avg}{Average beauty rating of professor.}
#'   \item{gender}{Gender of professor (collected as a binary variable at the time of the study): female, male.}
#'   \item{ethnicity}{Ethnicity of professor: not minority, minority.}
#'   \item{language}{Language of school where professor received education: English or non-English.}
#'   \item{rank}{Rank of professor: teaching, tenure track, tenured.}
#'   \item{pic_outfit}{Outfit of professor in picture: not formal, formal.}
#'   \item{pic_color}{Color of professor’s picture: color, black & white.}
#'   \item{cls_did_eval}{Number of students in class who completed evaluation.}
#'   \item{cls_students}{Total number of students in class.}
#'   \item{cls_level}{Class level: lower, upper.}
#' }
#' @source Çetinkaya-Rundel M, Morgan KL, Stangl D. 2013. Looking Good on Course Evaluations. CHANCE 26(2). 
#' @seealso The data in `evals` is a slight modification of \code{\link[openintro]{evals}}.
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
#'   labs(
#'     x = "", y = "Proportion",
#'     title = "Proportion of yawn and not yawn for each group"
#'   )
"mythbusters_yawn"



#' Random sample of 68 action and romance movies
#'
#' A random sample of 32 action movies and 36 romance movies from
#' \url{https://www.imdb.com/} and their ratings.
#'
#' @format A data frame of 68 rows movies.
#' \describe{
#'   \item{title}{Movie title}
#'   \item{year}{Year released}
#'   \item{rating}{IMDb rating out of 10 stars}
#'   \item{genre}{Action or Romance}
#' }
#' @seealso This data was sampled from the `movies` data frame in the \code{ggplot2movies} package.
#' @examples
#' library(ggplot2)
#'
#' # Visualize relationship between rating and genre
#' ggplot(data = movies_sample, aes(x = genre, y = rating)) +
#'   geom_boxplot() +
#'   labs(x = "Genre: Action or Romance", y = "IMDb rating")
"movies_sample"
