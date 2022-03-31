#' Early January hourly weather data
#'
#' Hourly meterological data for LGA, JFK and EWR for the month of January 2013. 
#' This is a subset of the `weather` data frame from `nycflights13`.
#'
#' @format A data frame of 358 rows representing hourly measurements and 15 variables
#' \describe{
#' \item{origin}{Weather station. Named `origin` to facilitate merging with
#'   [`nycflights13::flights`] data.}
#' \item{year, month, day, hour}{Time of recording.}
#' \item{temp, dewp}{Temperature and dewpoint in F.}
#' \item{humid}{Relative humidity.}
#' \item{wind_dir, wind_speed, wind_gust}{Wind direction (in degrees), speed
#'   and gust speed (in mph).}
#' \item{precip}{Precipitation, in inches.}
#' \item{pressure}{Sea level pressure in millibars.}
#' \item{visib}{Visibility in miles.}
#' \item{time_hour}{Date and hour of the recording as a `POSIXct` date.}
#' }
#' @seealso [`nycflights13::weather`].
#' @source ASOS download from Iowa Environmental Mesonet,
#'   <https://mesonet.agron.iastate.edu/request/download.phtml>.
"early_january_weather"



#' Alaska flights data
#'
#' On-time data for all Alaska Airlines flights that departed NYC (i.e. JFK, LGA or EWR) 
#' in 2013. This is a subset of the `flights` data frame from `nycflights13`.
#'
#' @format A data frame of 714 rows representing Alaska Airlines flights and 19 variables
#' \describe{
#' \item{year, month, day}{Date of departure.}
#' \item{dep_time, arr_time}{Actual departure and arrival times (format HHMM or HMM), local tz.}
#' \item{sched_dep_time, sched_arr_time}{Scheduled departure and arrival times (format HHMM or HMM), local tz.}
#' \item{dep_delay, arr_delay}{Departure and arrival delays, in minutes.
#'   Negative times represent early departures/arrivals.}
#' \item{carrier}{Two letter carrier abbreviation. See [`nycflights13::airlines`]
#'   to get name.}
#' \item{flight}{Flight number.}
#' \item{tailnum}{Plane tail number. See [`nycflights13::planes`] for additional metadata.}
#' \item{origin, dest}{Origin and destination. See [`nycflights13::airports`] for
#'   additional metadata.}
#' \item{air_time}{Amount of time spent in the air, in minutes.}
#' \item{distance}{Distance between airports, in miles.}
#' \item{hour, minute}{Time of scheduled departure broken into hour and minutes.}
#' \item{time_hour}{Scheduled date and hour of the flight as a `POSIXct` date.
#'   Along with `origin`, can be used to join flights data to [`nycflights13::weather`] data.}
#' }
#' @seealso [`nycflights13::flights`].
#' @source RITA, Bureau of transportation statistics
"alaska_flights"



#' A sample of 50 pennies
#'
#' A sample of 50 pennies contained in a 50 cent roll from Florence Bank on
#' Friday February 1, 2019 in downtown Northampton, Massachusetts, USA
#' <https://goo.gl/maps/AF88fpvVfm12>.
#'
#' @format A data frame of 50 rows representing 50 sampled pennies and 2 variables
#' \describe{
#'   \item{ID}{Variable used to uniquely identify each penny.}
#'   \item{year}{Year of minting.}
#' }
#' @note The original `pennies_sample` has been renamed [orig_pennies_sample()]
#' as of `moderndive` v0.3.0.
"pennies_sample"



#' Bootstrap resamples of a sample of 50 pennies
#'
#' 35 bootstrap resamples with replacement of sample of 50 pennies contained in
#' a 50 cent roll from Florence Bank on Friday February 1, 2019 in downtown Northampton,
#' Massachusetts, USA <https://goo.gl/maps/AF88fpvVfm12>. The original sample
#' of 50 pennies is available in [pennies_sample()] .
#'
#' @format A data frame of 1750 rows representing 35 students' bootstrap
#' resamples of size 50 and 3 variables
#' \describe{
#'   \item{replicate}{ID variable of replicate/resample number.}
#'   \item{name}{Name of student}
#'   \item{year}{Year on resampled penny}
#' }
#' @seealso [pennies_sample()]
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
#' @source StatCrunch <https://www.statcrunch.com:443/app/index.html?dataid=301596>
"pennies"



#' A random sample of 40 pennies sampled from the `pennies` data frame
#'
#' A dataset of 40 pennies to be treated as a random sample with [pennies()] acting
#' as the population. Data on these pennies were recorded in 2011.
#'
#' @format A data frame of 40 rows representing 40 randomly sampled pennies from [pennies()] and 2 variables
#' \describe{
#'   \item{year}{Year of minting}
#'   \item{age_in_2011}{Age in 2011}
#' }
#' @source StatCrunch <https://www.statcrunch.com:443/app/index.html?dataid=301596>
#' @seealso [pennies()]
"orig_pennies_sample"






#' A sampling bowl of red and white balls
#'
#' A sampling bowl used as the population in a simulated sampling exercise. Also
#' known as the urn sampling framework <https://en.wikipedia.org/wiki/Urn_problem>.
#'
#' @format A data frame 2400 rows representing different balls in the bowl, of which
#' 900 are red and 1500 are white.
#' \describe{
#'   \item{ball_ID}{ID variable used to denote all balls. Note this value is not
#'   marked on the balls themselves}
#'   \item{color}{color of ball: red or white}
#' }
"bowl"



#' Sampling from a bowl of balls
#'
#' Counting the number of red balls in 10 samples of size n = 50 balls from
#' <https://github.com/moderndive/moderndive/blob/master/data-raw/sampling_bowl.jpeg>
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
#' @seealso [bowl()]
"bowl_samples"



#' Tactile sampling from a tub of balls
#'
#' Counting the number of red balls in 33 tactile samples of size n = 50 balls from
#' <https://github.com/moderndive/moderndive/blob/master/data-raw/sampling_bowl.jpeg>
#'
#' @format A data frame of 33 rows representing different groups of students'
#' samples of size n = 50 and 4 variables
#' \describe{
#'   \item{group}{Group members}
#'   \item{replicate}{Replicate number}
#'   \item{red_balls}{Number of red balls sampled out of 50}
#'   \item{prop_red}{Proportion red balls out of 50}
#' }
#' @seealso [bowl()]
"tactile_prop_red"



#' Tactile sample of size 50 from a bowl of balls
#'
#' A single tactile sample of size n = 50 balls from
#' <https://github.com/moderndive/moderndive/blob/master/data-raw/sampling_bowl.jpeg>
#'
#' @format A data frame of 50 rows representing different balls and 1 variable.
#' \describe{
#'   \item{color}{Color of ball sampled}
#' }
#' @seealso [bowl()]
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
#' @seealso The data in `promotions` is a slight modification of [openintro::gender_discrimination()].
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
#' @seealso [promotions()].
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
#' Education reports <https://profiles.doe.mass.edu/state_report/>, however
#' the data was downloaded from Kaggle at <https://www.kaggle.com/ndalziel/massachusetts-public-schools-data>
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
#' @source US Census Bureau. Code used to scrape data available at <https://github.com/DelaneyMoran/FinalProject>
"DD_vs_SB"



#' House Sales in King County, USA
#'
#' This dataset contains house sale prices for King County, which includes
#' Seattle. It includes homes sold between May 2014 and May 2015. This dataset
#' was obtained from Kaggle.com <https://www.kaggle.com/harlfoxem/housesalesprediction/data>
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
#' @source Kaggle <https://www.kaggle.com/harlfoxem/housesalesprediction>.
#' Note data is released under a CC0: Public Domain license.
"house_prices"



#' Teaching evaluations at the UT Austin
#'
#' The data are gathered from end of semester student evaluations for a sample of 463 courses taught by
#' 94 professors from the University of Texas at Austin. In addition, six
#' students rate the professors' physical appearance. The result is a data frame
#' where each row contains a different course and each column has information on
#' either the course or the professor <https://www.openintro.org/data/index.php?data=evals>
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
#' @seealso The data in `evals` is a slight modification of [openintro::evals()].
"evals"



#' Data from Mythbusters' study on contagiousness of yawning
#'
#' From a study on whether yawning is contagious
#' <https://www.imdb.com/title/tt0768479/>.
#' The data here was derived from the final proportions of yawns given
#' in the show.
#'
#' @format A data frame of 50 rows representing each of the 50 participants
#' in the study.
#' \describe{
#'   \item{subj}{integer value corresponding to identifier variable of
#'   subject ID}
#'   \item{group}{string of either `"seed"`, participant was shown a
#'   yawner, or `"control"`, participant was not shown a yawner}
#'   \item{yawn}{string of either `"yes"`, the participant yawned, or
#'   `"no"`, the participant did not yawn}
#' }
"mythbusters_yawn"



#' Random sample of 68 action and romance movies
#'
#' A random sample of 32 action movies and 36 romance movies from
#' <https://www.imdb.com/> and their ratings.
#'
#' @format A data frame of 68 rows movies.
#' \describe{
#'   \item{title}{Movie title}
#'   \item{year}{Year released}
#'   \item{rating}{IMDb rating out of 10 stars}
#'   \item{genre}{Action or Romance}
#' }
#' @seealso This data was sampled from the `movies` data frame in the `ggplot2movies` package.
"movies_sample"



#' Sample of Amazon books 
#' 
#' A random sample of 325 books from Amazon.com. 
#'
#' @format A data frame of 325 rows representing books listed on Amazon and 13 variables.
#' \describe{
#'   \item{title}{Book title}
#'   \item{author}{Author who wrote book}
#'   \item{list price}{recommended retail price of book}
#'   \item{Amazon price}{lowest price of book shown on Amazon}
#'   \item{Hard/Paper}{book is either hardcover or paperback}
#'   \item{NumPages}{number of pages in book}
#'   \item{Publisher}{Company that issues the book for sale}
#'   \item{Pub Year}{Year the book was published}
#'   \item{ISBN-10}{10-character ISBN number}
#'   \item{Height, width, thick, weight}{height, width, weight and thickness of the book}
#' }
#' @source The Data and Story Library (DASL) <https://dasl.datadescription.com/datafile/amazon-books>
"amazon_books"
