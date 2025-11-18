# Bank manager recommendations based on (binary) gender

Data from a 1970's study on whether gender influences hiring
recommendations. Originally used in OpenIntro.org.

## Usage

``` r
promotions
```

## Format

A data frame with 48 observations on the following 3 variables.

- id:

  Identification variable used to distinguish rows.

- gender:

  gender (collected as a binary variable at the time of the study): a
  factor with two levels `male` and `female`

- decision:

  a factor with two levels: `promoted` and `not`

## Source

Rosen B and Jerdee T. 1974. Influence of sex role stereotypes on
personnel decisions. Journal of Applied Psychology 59(1):9-14.

## See also

The data in `promotions` is a slight modification of
[`openintro::gender_discrimination()`](https://openintrostat.github.io/openintro/reference/gender_discrimination.html).
