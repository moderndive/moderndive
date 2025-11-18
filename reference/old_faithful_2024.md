# Old Faithful Eruptions Dataset (2024)

This dataset contains records of eruptions from the Old Faithful geyser
in Yellowstone National Park, recorded in 2024. It includes details such
as the eruption ID, date and time of eruption, waiting time between
eruptions, webcam availability, and the duration of each eruption.

## Usage

``` r
old_faithful_2024
```

## Format

A data frame with 114 rows and 6 variables:

- eruption_id:

  `numeric`. A unique identifier for each eruption.

- date:

  `date`. The date of the eruption.

- time:

  `numeric`. The time of the eruption in HHMM format (e.g., 538
  corresponds to 5:38 AM, 1541 corresponds to 3:41 PM).

- waiting:

  `numeric`. The waiting time in minutes until the next eruption.

- webcam:

  `character`. Indicates whether the eruption was captured on webcam
  ("Yes" or "No").

- duration:

  `numeric`. The duration of the eruption in seconds.

## Source

Volunteer information from https://geysertimes.org/retrieve.php
