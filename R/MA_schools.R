#' Massachusetts Public High Schools Data
#'
#' Data on Massachusetts public high schools in 2017
#'
#' @format A data frame of 332 rows representing Massachusetts high schools and 4 variables
#' \describe{
#'   \item{school_name}{High school name.}
#'   \item{average_sat_math}{Average SAT math score. Note 58 of the original 390 values of this variable were missing; these rows were dropped from consideration.}
#'   \item{percent_economically_disadvantaged}{Percent of the student body that are considered economically disadvantaged.}
#'   \item{school_size}{Size of school enrollment; small 13-341 students, medium 342-541 students, large 542-4264 students.}
#' }
#' @source The original source of the data are Massachusetts Department of 
#' Education reports \url{http://profiles.doe.mass.edu/state_report/}, however 
#' the data wad downloaded from Kaggle at \url{https://www.kaggle.com/ndalziel/massachusetts-public-schools-data}
#' @examples
#' library(ggplot2)
#' ggplot(MA_schools, aes(x = percent_economically_disadvantaged, 
#'                        y = average_sat_math, color = school_size)) +
#'   geom_point() +
#'   geom_smooth(method = "lm", se = FALSE) +
#'   labs(y = "Math SAT Score", x = "Percentage of Economically Disadvantaged Students")
"MA_schools"