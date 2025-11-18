# Envoy Air flights data for 2023

On-time data for all Envoy Air flights that departed NYC (i.e. JFK, LGA
or EWR) in 2023. This is a subset of the `flights` data frame from
`nycflights23`.

## Usage

``` r
envoy_flights
```

## Format

A data frame of 357 rows representing Alaska Airlines flights and 19
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
  [`nycflights23::airlines`](https://moderndive.github.io/nycflights23/reference/airlines.html)
  to get name.

- flight:

  Flight number.

- tailnum:

  Plane tail number. See
  [`nycflights23::planes`](https://moderndive.github.io/nycflights23/reference/planes.html)
  for additional metadata.

- origin, dest:

  Origin and destination. See
  [`nycflights23::airports`](https://moderndive.github.io/nycflights23/reference/airports.html)
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
  [`nycflights23::weather`](https://moderndive.github.io/nycflights23/reference/weather.html)
  data.

## Source

RITA, Bureau of transportation statistics

## See also

[`nycflights23::flights`](https://moderndive.github.io/nycflights23/reference/flights.html).
