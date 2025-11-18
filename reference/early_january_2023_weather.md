# Early January hourly weather data for 2023

Hourly meteorological data for LGA, JFK and EWR for the month of January
2023. This is a subset of the `weather` data frame from `nycflights23`.

## Usage

``` r
early_january_2023_weather
```

## Format

A data frame of 360 rows representing hourly measurements and 15
variables

- origin:

  Weather station. Named `origin` to facilitate merging with
  [`nycflights23::flights`](https://moderndive.github.io/nycflights23/reference/flights.html)
  data.

- year, month, day, hour:

  Time of recording.

- temp, dewp:

  Temperature and dewpoint in F.

- humid:

  Relative humidity.

- wind_dir, wind_speed, wind_gust:

  Wind direction (in degrees), speed and gust speed (in mph).

- precip:

  Precipitation, in inches.

- pressure:

  Sea level pressure in millibars.

- visib:

  Visibility in miles.

- time_hour:

  Date and hour of the recording as a `POSIXct` date.

## Source

ASOS download from Iowa Environmental Mesonet,
<https://mesonet.agron.iastate.edu/request/download.phtml>.

## See also

[`nycflights23::weather`](https://moderndive.github.io/nycflights23/reference/weather.html).
