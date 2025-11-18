# Data from Mythbusters' study on contagiousness of yawning

From a study on whether yawning is contagious
<https://www.imdb.com/title/tt0768479/>. The data here was derived from
the final proportions of yawns given in the show.

## Usage

``` r
mythbusters_yawn
```

## Format

A data frame of 50 rows representing each of the 50 participants in the
study.

- subj:

  integer value corresponding to identifier variable of subject ID

- group:

  string of either `"seed"`, participant was shown a yawner, or
  `"control"`, participant was not shown a yawner

- yawn:

  string of either `"yes"`, the participant yawned, or `"no"`, the
  participant did not yawn
