#' Early January hourly weather data
#'
#' Hourly meteorological data for LGA, JFK and EWR for the month of January 2013. 
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

#' Early January hourly weather data for 2023
#'
#' Hourly meteorological data for LGA, JFK and EWR for the month of January 2023. 
#' This is a subset of the `weather` data frame from `nycflights23`.
#'
#' @format A data frame of 360 rows representing hourly measurements and 15 variables
#' \describe{
#' \item{origin}{Weather station. Named `origin` to facilitate merging with
#'   [`nycflights23::flights`] data.}
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
#' @seealso [`nycflights23::weather`].
#' @source ASOS download from Iowa Environmental Mesonet,
#'   <https://mesonet.agron.iastate.edu/request/download.phtml>.
"early_january_2023_weather"


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

#' Envoy Air flights data for 2023
#'
#' On-time data for all Envoy Air flights that departed NYC (i.e. JFK, LGA or EWR) 
#' in 2023. This is a subset of the `flights` data frame from `nycflights23`.
#'
#' @format A data frame of 357 rows representing Alaska Airlines flights and 19 variables
#' \describe{
#' \item{year, month, day}{Date of departure.}
#' \item{dep_time, arr_time}{Actual departure and arrival times (format HHMM or HMM), local tz.}
#' \item{sched_dep_time, sched_arr_time}{Scheduled departure and arrival times (format HHMM or HMM), local tz.}
#' \item{dep_delay, arr_delay}{Departure and arrival delays, in minutes.
#'   Negative times represent early departures/arrivals.}
#' \item{carrier}{Two letter carrier abbreviation. See [`nycflights23::airlines`]
#'   to get name.}
#' \item{flight}{Flight number.}
#' \item{tailnum}{Plane tail number. See [`nycflights23::planes`] for additional metadata.}
#' \item{origin, dest}{Origin and destination. See [`nycflights23::airports`] for
#'   additional metadata.}
#' \item{air_time}{Amount of time spent in the air, in minutes.}
#' \item{distance}{Distance between airports, in miles.}
#' \item{hour, minute}{Time of scheduled departure broken into hour and minutes.}
#' \item{time_hour}{Scheduled date and hour of the flight as a `POSIXct` date.
#'   Along with `origin`, can be used to join flights data to [`nycflights23::weather`] data.}
#' }
#' @seealso [`nycflights23::flights`].
#' @source RITA, Bureau of transportation statistics
"envoy_flights"


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

#' Data from the Coffee Quality Institute's review pages in January 2018
#'
#' 1,340 digitized reviews on coffee samples from
#' <https://database.coffeeinstitute.org/>.
#'
#' @format A data frame of 1,340 rows representing each sample of coffee.
#' \describe{
#'   \item{total_cup_points}{Number of points in final rating (scale of 0-100)}
#'   \item{species}{Species of coffee bean plant (Arabica or Robusta)}
#'   \item{owner}{Owner of coffee plant farm}
#'   \item{country_of_origin}{Coffee bean's country of origin}
#'   \item{farm_name}{Name of coffee plant farm}
#'   \item{lot_number}{Lot number for tested coffee beans}
#'   \item{mill}{Name of coffee bean's processing facility}
#'   \item{ico_number}{International Coffee Organization number}
#'   \item{company}{Name of coffee bean's company}
#'   \item{altitude}{Altitude at which coffee plants were grown}
#'   \item{region}{Region where coffee plants were grown}
#'   \item{producer}{Name of coffee bean roaster}
#'   \item{number_of_bags}{Number of tested bags}
#'   \item{bag_weight}{Tested bag weight}
#'   \item{in_country_partner}{Partner for the country}
#'   \item{harvest_year}{Year the coffee beans were harvested}
#'   \item{grading_date}{Day the coffee beans were graded}
#'   \item{owner_1}{Owner of the coffee beans}
#'   \item{variety}{Variety of the coffee beans}
#'   \item{processing_method}{Method used for processing the coffee beans}
#'   \item{aroma}{Coffee aroma rating}
#'   \item{flavor}{Coffee flavor rating}
#'   \item{aftertaste}{Coffee aftertaste rating}
#'   \item{acidity}{Coffee acidity rating}
#'   \item{body}{Coffee body rating}
#'   \item{balance}{Coffee balance rating}
#'   \item{uniformity}{Coffee uniformity rating}
#'   \item{clean_cup}{Cup cleanliness rating}
#'   \item{sweetness}{Coffee sweetness rating}
#'   \item{cupper_points}{Cupper Points, an overall rating for the coffee}
#'   \item{moisture}{Coffee moisture content}
#'   \item{category_one_defects}{Number of category one defects for the coffee beans}
#'   \item{quakers}{Number of coffee beans that don't dark brown when roasted}
#'   \item{color}{Color of the coffee beans}
#'   \item{category_two_defects}{Number of category two defects for the coffee beans}
#'   \item{expiration}{Expiration date of the coffee beans}
#'   \item{certification_body}{Entity/Institute that certified the coffee beans}
#'   \item{certification_address}{Body address of certification for coffee beans}
#'   \item{certification_contact}{Certification contact for coffee beans}
#'   \item{unit_of_measurement}{Unit of measurement for altitude}
#'   \item{altitude_low_meters}{Lower altitude level coffee beans grow at}
#'   \item{altitude_high_meters}{Higher altitude level coffee beans grow at}
#'   \item{altitude_mean_meters}{Average altitude level coffee beans grow at}
#' }
#' @source Coffee Quality Institute. Access cleaned data available at <https://github.com/jldbc/coffee-quality-database>
"coffee_ratings"


#' 2020 road traffic volume and crash level date for 13 Massachusetts counties
#' 
#' @format A data frame of 874 rows representing traffic data at the 874 sites 
#' \describe{
#'   \item{site_id}{Site id}
#'   \item{county}{County in which the site is located}
#'   \item{community}{Community in which the site is located}
#'   \item{rural_urban}{Rural (R) or Urban (U)}
#'   \item{dir}{Direction for traffic movement. Either 1-WAY, 2-WAY, EB (eastbound), RAMP or WB (westbound)}
#'   \item{functional_class}{Classification of road. Either Arterial, Collector, Freeway & Expressway, Interstate or Local Road}
#'   \item{avg_speed}{Average traffic speed}
#'   \item{total_volume}{Number of vehicles recorded at each site in 2020}
#'   \item{crashes}{Number of vehicle crashes at each site}
#'   \item{nonfatal_injuries}{Number of non-fatal injuries for all recorded vehicle crashes}
#'   \item{fatal_injuries}{Number of fatal injuries for all recorded vehicle crashes}
#' }
"mass_traffic_2020"

#' Sample of Amazon books 
#' 
#' A random sample of 325 books from Amazon.com. 
#'
#' @format A data frame of 325 rows representing books listed on Amazon and 13 variables.
#' \describe{
#'   \item{title}{Book title}
#'   \item{author}{Author who wrote book}
#'   \item{list_price}{recommended retail price of book}
#'   \item{amazon_price}{lowest price of book shown on Amazon}
#'   \item{hard_paper}{book is either hardcover or paperback}
#'   \item{num_pages}{number of pages in book}
#'   \item{publisher}{Company that issues the book for sale}
#'   \item{pub_year}{Year the book was published}
#'   \item{isbn_10}{10-character ISBN number}
#'   \item{height, width, thick, weight_oz}{height, width, weight and thickness of the book}
#' }
#' @source The Data and Story Library (DASL) <https://dasl.datadescription.com/datafile/amazon-books>
"amazon_books"

#' International Power Lifting Results
#' A subset of international powerlifting results.
#' 
#' @format A data frame with 41,152 entries, one entry for individual lifter
#' \describe{
#'   \item{name}{Individual lifter name}
#'   \item{sex}{Binary sex (M/F)}
#'   \item{event}{The type of competition that the lifter entered}
#'   \item{equipment}{The equipment category under which the lifts were performed}
#'   \item{age}{The age of the lifter on the start date of the meet}
#'   \item{age_class}{The age class in which the filter falls}
#'   \item{division}{division of competition}
#'   \item{bodyweight_kg}{The recorded bodyweight of the lifter at the time of competition, to two decimal places}
#'   \item{weight_class_kg}{The weight class in which the lifter competed, to two decimal places}
#'   \item{best3squat_kg}{Maximum of the first three successful attempts for the lift}
#'   \item{best3bench_kg}{Maximum of the first three successful attempts for the lift}
#'   \item{best3deadlift_kg}{Maximum of the first three successful attempts for the lift}
#'   \item{place}{The recorded place of the lifter in the given division at the end of the meet}
#'   \item{date}{Date of the event}
#'   \item{federation}{The federation that hosted the meet}
#'   \item{meet_name}{The name of the meet}
#' }
#' @source This data is a subset of the open dataset [Open Powerlifting](https://www.openpowerlifting.org/)
"ipf_lifts"



#' Data on maternal smoking and infant health
#' 
#' @format A data frame of 1236 rows of individual mothers.
#' \describe{
#' \item{id}{Identification number}
#' \item{pluralty}{Marked 5 for single fetus, otherwise number of fetuses}
#' \item{outcome}{Marked 1 for live birth that survived at least 28 days}
#' \item{date}{Birth date where 1096 is January 1st, 1961}
#' \item{birthday}{Birth date in mm-dd-yyyy format}
#' \item{gestation}{Length of gestation in days, marked 999 if unknown}
#' \item{sex}{Infant's sex, where 1 is male, 2 is female, and 9 is unknown}
#' \item{wt}{Birth weight in ounces, marked 999 if unknown}
#' \item{parity}{Total number of previous pregnancies including fetal deaths and stillbirths, marked 99 if unknown}
#' \item{race}{Mother's race where 0-5 is white, 6 is Mexican, 7 is Black, 8 is Asian, 9 is mixed, and 99 is unknown}
#' \item{age}{Mother's age in years at termination of pregnancy, 99=unknown}
#' \item{ed}{Mother's education 0= less than 8th grade, 1 = 8th -12th grade - did not graduate, 2= HS graduate--no other schooling , 3= HS+trade, 4=HS+some college 5= College graduate, 6&7 Trade school HS unclear, 9=unknown}
#' \item{ht}{Mother's height in inches to the last completed inch, 99=unknown}
#' \item{wt_1}{Mother prepregnancy wt in pounds, 999=unknown}
#' \item{drace}{Father's race, coding same as mother's race}
#' \item{dage}{Father's age, coding same as mother's age}
#' \item{ded}{Father's education, coding same as mother's education}
#' \item{dht}{Father's height, coding same as for mother's height}
#' \item{dwt}{Father's weight coding same as for mother's weight}
#' \item{marital}{0= legally separated, 1=married, 2= divorced, 3=widowed, 5=never married}
#' \item{inc}{Family yearly income in $2500 increments 0 = under 2500, 1=2500-4999, ..., 8= 12,500-14,999, 9=15000+, 98=unknown, 99=not asked}
#' \item{smoke}{Does mother smoke? 0=never, 1= smokes now, 2=until current pregnancy, 3=once did, not now, 9=unknown}
#' \item{time}{If mother quit, how long ago? 0=never smoked, 1=still smokes, 2=during current preg, 3=within 1 yr, 4= 1 to 2 years ago, 5= 2 to 3 yr ago, 6= 3 to 4 yrs ago, 7=5 to 9yrs ago, 8=10+yrs ago, 9=quit and don't know, 98=unknown, 99=not asked}
#' \item{number}{Number of cigs smoked per day for past and current smokers  0=never, 1=1-4, 2=5-9, 3=10-14, 4=15-19, 5=20-29, 6=30-39, 7=40-60, 8=60+, 9=smoke but don't know, 98=unknown, 99=not asked}
#' }
#' @source Data on maternal smoking and infant health from <https://www.stat.berkeley.edu/~statlabs/labs.html>
"babies"

#' Electric vehicle charging sessions for a workplace charging program
#' 
#' This dataset consists of information on 3,395 electric vehicle charging sessions across
#' locations for a workplace charging program. The data contains information on multiple
#' charging sessions from 85 electric vehicle drivers across 25 workplace locations, which 
#' are located at facilities of various types.
#' 
#' @format A data frame of 3,395 rows on 24 variables, where each row is an electric vehicle
#' charging session.
#' \describe{
#'    \item{session_id}{Unique identifier specifying the electric vehicle charging session}
#'    \item{kwh_total}{Total energy used at the charging session, in kilowatt hours (kWh)}
#'    \item{dollars}{Quantity of money paid for the charging session in U.S. dollars}
#'    \item{created}{Date and time recorded at the beginning of the charging session}
#'    \item{ended}{Date and time recorded at the end of the charging session}
#'    \item{start_time}{Hour of the day when the charging session began (1 through 24)}
#'    \item{end_time}{Hour of the day when the charging session ended (1 through 24)}
#'    \item{charge_time_hrs}{Length of the charging session in hours}
#'    \item{weekday}{First three characters of the name of the weekday when the charging session occurred}
#'    \item{platform}{Digital platform the driver used to record the session (android, ios, web)} 
#'    \item{distance}{Distance from the charging location to the driver's home, expressed in miles
#'    NA if the driver did not report their address}
#'    \item{user_id}{Unique identifier for each driver}
#'    \item{station_id}{Unique identifier for each charging station}
#'    \item{location_id}{Unique identifier for each location owned by the company where charging stations
#'    were located}
#'    \item{manager_vehicle}{Binary variable that is 1 when the vehicle is a type commonly used
#'    by managers of the firm and 0 otherwise}
#'    \item{facility_type}{Categorical variable that represents the facility type:
#'    \itemize{
#'    \item 1 = manufacturing
#'    \item 2 = office
#'    \item 3 = research and development
#'    \item 4 = other} }
#'    \item{mon, tues, wed, thurs, fri, sat, sun}{Binary variables; 1 if the charging session took place on that day,
#'    0 otherwise}
#'    \item{reported_zip}{Binary variable; 1 if the driver did report their zip code, 0 if they did not}
#' }
#' @source Harvard Dataverse \doi{10.7910/DVN/NFPQLW}.
#' Note data is released under a CC0: Public Domain license.
"ev_charging"

#' Massachusetts 2020 vs. 2019 Traffic Data Comparison
#'
#' This dataset contains information about changes in speed, volume, and accidents of traffic 
#' between 2020 and 2019 by community and class of road in Massachusetts.
#' 
#' @format A data frame of 264 rows each representing a different community in Massachusetts.
#' \describe{
#'   \item{community}{City or Town}
#'   \item{functional_class}{Class or group the road belongs to}
#'   \item{change_in_speed}{Average estimated Speed (mph)}
#'   \item{change_in_volume}{Average traffic}
#'   \item{change_in_accidents}{Average number of accidents}
#' }
#' @source 
#' \url{https://massdot-impact-crashes-vhb.opendata.arcgis.com/datasets/MassDOT::2020-vehicle-level-crash-details/explore}
#' \url{https://mhd.public.ms2soft.com/tcds/tsearch.asp?loc=Mhd&mod=}
"ma_traffic_2020_vs_2019"

#' Data from Mario Kart Ebay auctions 
#' 
#' Ebay auction data for the Nintendo Wii game Mario Kart.
#' 
#' @format A data frame of 143 auctions.
#' \describe{
#'   \item{id}{Auction ID assigned by Ebay}
#'   \item{duration}{Auction length in days}
#'   \item{n_bids}{Number of bids}
#'   \item{cond}{Game condition, either `new` or `used`}
#'   \item{start_pr}{Price at the start of the auction}
#'   \item{ship_pr}{Shipping price}
#'   \item{total_pr}{Total price, equal to auction price plus shipping price}
#'   \item{ship_sp}{Shipping speed or method}
#'   \item{seller_rate}{Seller's rating on Ebay, equal to the number of positive ratings minus the number of negative ratings}
#'   \item{stock_photo}{Whether the auction photo was a stock photo or not, pictures used in many options were considered stock photos}
#'   \item{wheels}{Number of Wii wheels included in the auction}
#'   \item{title}{The title of the auctions}
#' }
#' @source This data is from <https://www.openintro.org/data/index.php?data=mariokart>
"mario_kart_auction"

#' Avocado Prices by US Region
#' 
#' Gathered from <https://docs.google.com/spreadsheets/d/1cNuj9V-9Xe8fqV3DQRhvsXJhER3zTkO1dSsQ1Q0j96g/edit#gid=1419070688>
#' 
#' @format A data frame of 54 regions over 3 years of weekly results
#' \describe{
#' \item{date}{Week of Data Recording}
#' \item{average_price}{Average Price of Avocado}
#' \item{total_volume}{Total Amount of Avocados}
#' \item{small_hass_sold}{Amount of Small Haas Avocados Sold}
#' \item{large_hass_sold}{Amount of Large Haas Avocados Sold}
#' \item{xlarge_hass_sold}{Amount of Extra Large Haas Avocados Sold}
#' \item{total_bags}{Total Amount of Bags of Avocados}
#' \item{small_bags}{Total Amount of Bags of Small Haas Avocados}
#' \item{large_bags}{Total Amount of Bags of Large Haas Avocados}
#' \item{x_large_bags}{Total Amount of Bags of Extra Large Haas Avocados}
#' \item{type}{Type of Sale}
#' \item{year}{Year of Sale}
#' \item{region}{Region Where Sale Took Place}
#' }
"avocados"


#' House Prices and Properties in Saratoga, New York
#' 
#' Random sample of 1057 houses taken from full Saratoga Housing Data (De Veaux)
#' @format A data frame with 1057 observations on the following 8 variables
#' \describe{
#' \item{price}{price (US dollars)} 
#' \item{living_area}{Living Area (square feet)}
#' \item{bathrooms}{Number of Bathroom (half bathrooms have no shower or tub)}
#' \item{bedrooms}{Number of Bedrooms}
#' \item{fireplaces}{Number of Fireplaces}
#' \item{lot_size}{Size of Lot (acres)}
#' \item{age}{Age of House (years)}
#' \item{fireplace}{Whether the house has a Fireplace}
#' }
#' @source Gathered from <https://docs.google.com/spreadsheets/d/1AY5eECqNIggKpYF3kYzJQBIuuOdkiclFhbjAmY3Yc8E/edit#gid=622599674>
"saratoga_houses" 

#' Chocolate-covered almonds data
#' 
#' 5000 chocolate-covered almonds selected from a large batch, weighed in grams.
#' @format A data frame with 5000 observations on the following 2 variables
#' \describe{
#' \item{ID}{Identification value for a given chocolate-covered almond} 
#' \item{weight}{Weight of the chocolate-covered almond in grams (to the nearest tenth)}
#' }
"almonds_bowl" 

#' Chocolate-covered almonds data sample
#' 
#' A sample of 100 chocolate-covered almonds, weighed in grams.
#' @format A data frame with 100 observations on the following 2 variables
#' \describe{
#' \item{ID}{Identification value for a given chocolate-covered almond} 
#' \item{weight}{Weight of the chocolate-covered almond in grams (to the nearest tenth)}
#' }
"almonds_sample_100" 

#' UN Member States 2024 Dataset
#'
#' This dataset contains information on 193 United Nations member states as of 2024. It includes various attributes such as country names, ISO codes, official state names, geographic and demographic data, economic indicators, and participation in the Olympic Games. The data is designed for use in statistical analysis, data visualization, and educational purposes.
#'
#' @format A data frame with 193 rows and 39 columns:
#' \describe{
#'   \item{country}{\code{character}. Name of the country.}
#'   \item{iso}{\code{character}. ISO 3166-1 alpha-3 country code. See: \url{https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3}}
#'   \item{official_state_name}{\code{character}. Official name of the country. See: \url{https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_and_their_capitals_in_native_languages}}
#'   \item{continent}{\code{factor}. Continent where the country is located. See: \url{https://en.wikipedia.org/wiki/Continent}}
#'   \item{region}{\code{character}. Specific region within the continent.}
#'   \item{capital_city}{\code{character}. Name of the capital city. See: \url{https://en.wikipedia.org/wiki/List_of_national_capitals_by_population}}
#'   \item{capital_population}{\code{numeric}. Population of the capital city.}
#'   \item{capital_perc_of_country}{\code{numeric}. Percentage of the country’s population living in the capital.}
#'   \item{capital_data_year}{\code{integer}. Year the capital population data was collected.}
#'   \item{gdp_per_capita}{\code{numeric}. GDP per capita in USD. See: \url{https://data.worldbank.org/indicator/NY.GDP.PCAP.CD}}
#'   \item{gdp_per_capita_year}{\code{numeric}. Year the GDP per capita data was collected.}
#'   \item{summers_competed_in}{\code{numeric}. Number of times the country has competed in the Summer Olympics. See: \url{https://olympics.com/ioc/summer-olympics}}
#'   \item{summer_golds}{\code{integer}. Number of gold medals won in the Summer Olympics.}
#'   \item{summer_silvers}{\code{integer}. Number of silver medals won in the Summer Olympics.}
#'   \item{summer_bronzes}{\code{integer}. Number of bronze medals won in the Summer Olympics.}
#'   \item{summer_total}{\code{integer}. Total number of medals won in the Summer Olympics.}
#'   \item{winters_competed_in}{\code{integer}. Number of times the country has competed in the Winter Olympics. See: \url{https://olympics.com/ioc/winter-olympics}}
#'   \item{winter_golds}{\code{integer}. Number of gold medals won in the Winter Olympics.}
#'   \item{winter_silvers}{\code{integer}. Number of silver medals won in the Winter Olympics.}
#'   \item{winter_bronzes}{\code{integer}. Number of bronze medals won in the Winter Olympics.}
#'   \item{winter_total}{\code{integer}. Total number of medals won in the Winter Olympics.}
#'   \item{combined_competed_ins}{\code{integer}. Total number of times the country has competed in both Summer and Winter Olympics. See: \url{https://en.wikipedia.org/wiki/All-time_Olympic_Games_medal_table}}
#'   \item{combined_golds}{\code{integer}. Total number of gold medals won in both Summer and Winter Olympics.}
#'   \item{combined_silvers}{\code{integer}. Total number of silver medals won in both Summer and Winter Olympics.}
#'   \item{combined_bronzes}{\code{integer}. Total number of bronze medals won in both Summer and Winter Olympics.}
#'   \item{combined_total}{\code{integer}. Total number of medals won in both Summer and Winter Olympics.}
#'   \item{driving_side}{\code{character}. Indicates whether the country drives on the left or right side of the road. See: \url{https://en.wikipedia.org/wiki/Left-_and_right-hand_traffic}}
#'   \item{obesity_rate_2024}{\code{numeric}. Percentage of the population classified as obese in 2024. See: \url{https://en.wikipedia.org/wiki/List_of_countries_by_obesity_rate}}
#'   \item{obesity_rate_2016}{\code{numeric}. Percentage of the population classified as obese in 2016.}
#'   \item{has_nuclear_weapons_2024}{\code{logical}. Indicates whether the country has nuclear weapons as of 2024. See: \url{https://en.wikipedia.org/wiki/List_of_states_with_nuclear_weapons}}
#'   \item{population_2024}{\code{numeric}. Population of the country in 2024. See: \url{https://data.worldbank.org/indicator/SP.POP.TOTL}}
#'   \item{area_in_square_km}{\code{numeric}. Area of the country in square kilometers. See: \url{https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_area}}
#'   \item{area_in_square_miles}{\code{numeric}. Area of the country in square miles.}
#'   \item{population_density_in_square_km}{\code{numeric}. Population density in square kilometers.}
#'   \item{population_density_in_square_miles}{\code{numeric}. Population density in square miles.}
#'   \item{income_group_2024}{\code{factor}. World Bank income group classification in 2024. See: \url{https://data.worldbank.org/indicator/NY.GNP.PCAP.CD}}
#'   \item{life_expectancy_2022}{\code{numeric}. Life expectancy at birth in 2022. See: \url{https://en.wikipedia.org/wiki/List_of_countries_by_life_expectancy}}
#'   \item{fertility_rate_2022}{\code{numeric}. Fertility rate in 2022 (average number of children per woman). See: \url{https://en.wikipedia.org/wiki/List_of_countries_by_total_fertility_rate}}
#'   \item{hdi_2022}{\code{numeric}. Human Development Index in 2022. See: \url{https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index}}
#' }
#' @examples
#' data(un_member_states_2024)
#' head(un_member_states_2024)
"un_member_states_2024" 

#' Spotify by Genre Dataset
#'
#' This dataset contains information on 6,000 tracks from Spotify, categorized by one of six genres. It includes various audio features, metadata about the tracks, and an indicator of popularity. The dataset is useful for analysis of music trends, popularity prediction, and genre-specific characteristics.
#'
#' @format A data frame with 6,000 rows and 21 columns:
#' \describe{
#'   \item{track_id}{\code{character}. Spotify ID for the track. See: \url{https://developer.spotify.com/documentation/web-api/}}
#'   \item{artists}{\code{character}. Names of the artists associated with the track.}
#'   \item{album_name}{\code{character}. Name of the album on which the track appears.}
#'   \item{track_name}{\code{character}. Name of the track.}
#'   \item{popularity}{\code{numeric}. Popularity score of the track (0-100). See: \url{https://developer.spotify.com/documentation/web-api/reference/#/operations/get-track}}
#'   \item{duration_ms}{\code{numeric}. Duration of the track in milliseconds.}
#'   \item{explicit}{\code{logical}. Whether the track has explicit content.}
#'   \item{danceability}{\code{numeric}. Danceability score of the track (0-1). See: \url{https://developer.spotify.com/documentation/web-api/reference/#/operations/get-audio-features}}
#'   \item{energy}{\code{numeric}. Energy score of the track (0-1).}
#'   \item{key}{\code{numeric}. The key the track is in (0-11 where 0 = C, 1 = C#/Db, etc.).}
#'   \item{loudness}{\code{numeric}. The loudness of the track in decibels (dB).}
#'   \item{mode}{\code{numeric}. Modality of the track (0 = minor, 1 = major).}
#'   \item{speechiness}{\code{numeric}. Speechiness score of the track (0-1).}
#'   \item{acousticness}{\code{numeric}. Acousticness score of the track (0-1).}
#'   \item{instrumentalness}{\code{numeric}. Instrumentalness score of the track (0-1).}
#'   \item{liveness}{\code{numeric}. Liveness score of the track (0-1).}
#'   \item{valence}{\code{numeric}. Valence score of the track (0-1), indicating the musical positiveness.}
#'   \item{tempo}{\code{numeric}. Tempo of the track in beats per minute (BPM).}
#'   \item{time_signature}{\code{numeric}. Time signature of the track (typically 3, 4, or 5).}
#'   \item{track_genre}{\code{character}. Genre of the track (country, deep-house, dubstep, hip-hop, metal, and rock).}
#'   \item{popular_or_not}{\code{character}. Indicates whether the track is considered popular ("popular") or not ("not popular"). Popularity is defined as a score of 50 or higher which corresponds to the 75th percentile of the \code{popularity} column.}
#' }
#' @source \url{https://developer.spotify.com/documentation/web-api/}
#' @examples
#' data(spotify_by_genre)
#' head(spotify_by_genre)
"spotify_by_genre"

#' Spotify 52-Track Sample Dataset
#'
#' This dataset contains a sample of 52 tracks from Spotify, focusing on two genres: deep-house and metal. It includes metadata about the tracks, the artists, and an indicator of whether each track is considered popular. This dataset is useful for comparative analysis between genres and for studying the characteristics of popular versus non-popular tracks within these genres.
#'
#' @format A data frame with 52 rows and 6 columns:
#' \describe{
#'   \item{track_id}{\code{character}. Spotify ID for the track. See: \url{https://developer.spotify.com/documentation/web-api/}}
#'   \item{track_genre}{\code{character}. Genre of the track, either "deep-house" or "metal".}
#'   \item{artists}{\code{character}. Names of the artists associated with the track.}
#'   \item{track_name}{\code{character}. Name of the track.}
#'   \item{popularity}{\code{numeric}. Popularity score of the track (0-100). See: \url{https://developer.spotify.com/documentation/web-api/reference/#/operations/get-track}}
#'   \item{popular_or_not}{\code{character}. Indicates whether the track is considered popular ("popular") or not ("not popular"). Popularity is defined as a score of 50 or higher which corresponds to the 75th percentile of the \code{popularity} column.}
#' }
#' @source \url{https://developer.spotify.com/documentation/web-api/}
#' @examples
#' data(spotify_52_original)
#' head(spotify_52_original)
"spotify_52_original"

#' Spotify 52-Track Sample Dataset with 'popular or not' shuffled
#'
#' This dataset contains a sample of 52 tracks from Spotify, focusing on two genres: deep-house and metal. It includes metadata about the tracks, the artists, and a shuffled indicator of whether each track is considered popular.
#'
#' @format A data frame with 52 rows and 6 columns:
#' \describe{
#'   \item{track_id}{\code{character}. Spotify ID for the track. See: \url{https://developer.spotify.com/documentation/web-api/}}
#'   \item{track_genre}{\code{character}. Genre of the track, either "deep-house" or "metal".}
#'   \item{artists}{\code{character}. Names of the artists associated with the track.}
#'   \item{track_name}{\code{character}. Name of the track.}
#'   \item{popularity}{\code{numeric}. Popularity score of the track (0-100). See: \url{https://developer.spotify.com/documentation/web-api/reference/#/operations/get-track}}
#'   \item{popular_or_not}{\code{character}. A shuffled version of the column of the same name in the \code{spotify_52_original} data frame.}
#' }
#' @source \url{https://developer.spotify.com/documentation/web-api/}
#' @examples
#' data(spotify_52_shuffled)
#' head(spotify_52_shuffled)
"spotify_52_shuffled"
