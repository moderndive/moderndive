# Electric vehicle charging sessions for a workplace charging program

This dataset consists of information on 3,395 electric vehicle charging
sessions across locations for a workplace charging program. The data
contains information on multiple charging sessions from 85 electric
vehicle drivers across 25 workplace locations, which are located at
facilities of various types.

## Usage

``` r
ev_charging
```

## Format

A data frame of 3,395 rows on 24 variables, where each row is an
electric vehicle charging session.

- session_id:

  Unique identifier specifying the electric vehicle charging session

- kwh_total:

  Total energy used at the charging session, in kilowatt hours (kWh)

- dollars:

  Quantity of money paid for the charging session in U.S. dollars

- created:

  Date and time recorded at the beginning of the charging session

- ended:

  Date and time recorded at the end of the charging session

- start_time:

  Hour of the day when the charging session began (1 through 24)

- end_time:

  Hour of the day when the charging session ended (1 through 24)

- charge_time_hrs:

  Length of the charging session in hours

- weekday:

  First three characters of the name of the weekday when the charging
  session occurred

- platform:

  Digital platform the driver used to record the session (android, ios,
  web)

- distance:

  Distance from the charging location to the driver's home, expressed in
  miles NA if the driver did not report their address

- user_id:

  Unique identifier for each driver

- station_id:

  Unique identifier for each charging station

- location_id:

  Unique identifier for each location owned by the company where
  charging stations were located

- manager_vehicle:

  Binary variable that is 1 when the vehicle is a type commonly used by
  managers of the firm and 0 otherwise

- facility_type:

  Categorical variable that represents the facility type:

  - 1 = manufacturing

  - 2 = office

  - 3 = research and development

  - 4 = other

- mon, tues, wed, thurs, fri, sat, sun:

  Binary variables; 1 if the charging session took place on that day, 0
  otherwise

- reported_zip:

  Binary variable; 1 if the driver did report their zip code, 0 if they
  did not

## Source

Harvard Dataverse
[doi:10.7910/DVN/NFPQLW](https://doi.org/10.7910/DVN/NFPQLW) . Note data
is released under a CC0: Public Domain license.
