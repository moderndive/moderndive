#' Alaska Airlines flights
#'
#' Only Alaska Airlines flights from nycflights13::flights.
#'
#' @source \code{\link[nycflights13]{flights}}
#' @format A data frame of 714 rows representing flights and 19 variables
#' \describe{
#' \item{year,month,day}{Date of departure}
#' \item{dep_time,arr_time}{Actual departure and arrival times (format HHMM or HMM), local tz.}
#' \item{sched_dep_time,sched_arr_time}{Scheduled departure and arrival times (format HHMM or HMM), local tz.}
#' \item{dep_delay,arr_delay}{Departure and arrival delays, in minutes.
#'   Negative times represent early departures/arrivals.}
#' \item{hour,minute}{Time of scheduled departure broken into hour and minutes.}
#' \item{carrier}{Two letter carrier abbreviation. See [airlines()]
#'   to get name}
#' \item{tailnum}{Plane tail number}
#' \item{flight}{Flight number}
#' \item{origin,dest}{Origin and destination. See [airports()] for
#'   additional metadata.}
#' \item{air_time}{Amount of time spent in the air, in minutes}
#' \item{distance}{Distance between airports, in miles}
#' \item{time_hour}{Scheduled date and hour of the flight as a `POSIXct` date.
#'   Along with `origin`, can be used to join flights data to weather data.}
#' }
#' @examples
#' # Scatterplot of arrival delay vs departure delay
#' library(ggplot2)
#' ggplot(data = alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) + 
#'   geom_point()
"alaska_flights"