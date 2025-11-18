# Spotify 52-Track Sample Dataset with 'popular or not' shuffled

This dataset contains a sample of 52 tracks from Spotify, focusing on
two genres: deep-house and metal. It includes metadata about the tracks,
the artists, and a shuffled indicator of whether each track is
considered popular.

## Usage

``` r
spotify_52_shuffled
```

## Format

A data frame with 52 rows and 6 columns:

- track_id:

  `character`. Spotify ID for the track. See:
  <https://developer.spotify.com/documentation/web-api/>

- track_genre:

  `character`. Genre of the track, either "deep-house" or "metal".

- artists:

  `character`. Names of the artists associated with the track.

- track_name:

  `character`. Name of the track.

- popularity:

  `numeric`. Popularity score of the track (0-100). See:
  <https://developer.spotify.com/documentation/web-api/reference/#/operations/get-track>

- popular_or_not:

  `character`. A shuffled version of the column of the same name in the
  `spotify_52_original` data frame.

## Source

<https://developer.spotify.com/documentation/web-api/>

## Examples

``` r
data(spotify_52_shuffled)
head(spotify_52_shuffled)
#> # A tibble: 6 × 6
#>   track_id              track_genre artists track_name popularity popular_or_not
#>   <chr>                 <chr>       <chr>   <chr>           <dbl> <chr>         
#> 1 3fvsxmytTns1ApIWBqfA… deep-house  Jess B… Temptatio…         63 popular       
#> 2 6Nd6ntkzr4t8o1FKPGOS… metal       Whites… Here I Go…         69 not popular   
#> 3 7MIKwg3dDCWhxMVjMvqF… metal       Blind … No Rain             1 popular       
#> 4 1fQaoh3imrMunWVZh5kf… metal       Avenge… Shepherd …         70 not popular   
#> 5 2O0vM6F7VMXf66Y5qUuW… deep-house  Nora V… I Wanna D…         56 popular       
#> 6 7HjNOz8Y7H7uSySXuHNg… metal       Breaki… Ashes of …         61 not popular   
```
