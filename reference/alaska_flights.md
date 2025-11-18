# Alaska flights data

On-time data for all Alaska Airlines flights that departed NYC (i.e.
JFK, LGA or EWR) in 2013. This is a subset of the `flights` data frame
from `nycflights13`.

## Usage

``` r
alaska_flights
```

## Format

A data frame of 714 rows representing Alaska Airlines flights and 19
variables

- year, month, day:

  Date of departure.

- dep_time, arr_time:

  Actual departure and arrival times (format HHMM or HMM), local tz.

- sched_dep_time, sched_arr_time:

  Scheduled departure and arrival times (format HHMM or HMM), local tz.

- dep_delay, arr_delay:

  Departure and arrival delays, in minutes. Negative times represent
  early departures/arrivals.

- carrier:

  Two letter carrier abbreviation. See
  [`nycflights13::airlines`](https://rdrr.io/pkg/nycflights13/man/airlines.html)
  to get name.

- flight:

  Flight number.

- tailnum:

  Plane tail number. See
  [`nycflights13::planes`](https://rdrr.io/pkg/nycflights13/man/planes.html)
  for additional metadata.

- origin, dest:

  Origin and destination. See
  [`nycflights13::airports`](https://rdrr.io/pkg/nycflights13/man/airports.html)
  for additional metadata.

- air_time:

  Amount of time spent in the air, in minutes.

- distance:

  Distance between airports, in miles.

- hour, minute:

  Time of scheduled departure broken into hour and minutes.

- time_hour:

  Scheduled date and hour of the flight as a `POSIXct` date. Along with
  `origin`, can be used to join flights data to
  [`nycflights13::weather`](https://rdrr.io/pkg/nycflights13/man/weather.html)
  data.

## Source

RITA, Bureau of transportation statistics

## See also

[`nycflights13::flights`](https://rdrr.io/pkg/nycflights13/man/flights.html).
