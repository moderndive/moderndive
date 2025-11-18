# Spotify by Genre Dataset

This dataset contains information on 6,000 tracks from Spotify,
categorized by one of six genres. It includes various audio features,
metadata about the tracks, and an indicator of popularity. The dataset
is useful for analysis of music trends, popularity prediction, and
genre-specific characteristics.

## Usage

``` r
spotify_by_genre
```

## Format

A data frame with 6,000 rows and 21 columns:

- track_id:

  `character`. Spotify ID for the track. See:
  <https://developer.spotify.com/documentation/web-api/>

- artists:

  `character`. Names of the artists associated with the track.

- album_name:

  `character`. Name of the album on which the track appears.

- track_name:

  `character`. Name of the track.

- popularity:

  `numeric`. Popularity score of the track (0-100). See:
  <https://developer.spotify.com/documentation/web-api/reference/#/operations/get-track>

- duration_ms:

  `numeric`. Duration of the track in milliseconds.

- explicit:

  `logical`. Whether the track has explicit content.

- danceability:

  `numeric`. Danceability score of the track (0-1). See:
  <https://developer.spotify.com/documentation/web-api/reference/#/operations/get-audio-features>

- energy:

  `numeric`. Energy score of the track (0-1).

- key:

  `numeric`. The key the track is in (0-11 where 0 = C, 1 = C#/Db,
  etc.).

- loudness:

  `numeric`. The loudness of the track in decibels (dB).

- mode:

  `numeric`. Modality of the track (0 = minor, 1 = major).

- speechiness:

  `numeric`. Speechiness score of the track (0-1).

- acousticness:

  `numeric`. Acousticness score of the track (0-1).

- instrumentalness:

  `numeric`. Instrumentalness score of the track (0-1).

- liveness:

  `numeric`. Liveness score of the track (0-1).

- valence:

  `numeric`. Valence score of the track (0-1), indicating the musical
  positiveness.

- tempo:

  `numeric`. Tempo of the track in beats per minute (BPM).

- time_signature:

  `numeric`. Time signature of the track (typically 3, 4, or 5).

- track_genre:

  `character`. Genre of the track (country, deep-house, dubstep,
  hip-hop, metal, and rock).

- popular_or_not:

  `character`. Indicates whether the track is considered popular
  ("popular") or not ("not popular"). Popularity is defined as a score
  of 50 or higher which corresponds to the 75th percentile of the
  `popularity` column.

## Source

<https://developer.spotify.com/documentation/web-api/>

## Examples

``` r
data(spotify_by_genre)
head(spotify_by_genre)
#> # A tibble: 6 × 21
#>   track_id         artists album_name track_name popularity duration_ms explicit
#>   <chr>            <chr>   <chr>      <chr>           <dbl>       <dbl> <lgl>   
#> 1 2wrJq5XKLnmhRXH… Dan + … 10,000 Ho… 10,000 Ho…         78      167693 FALSE   
#> 2 6AHJTA1BN7ePfCh… Luke B… Country U… Country On          0      236455 FALSE   
#> 3 5eUtyONoPyfZYGr… Thomas… Mientras … Die A Hap…          1      228320 FALSE   
#> 4 1e3QZ42GsP8cTy5… Zach B… New Count… Something…          3      228013 FALSE   
#> 5 5Vnx0s7H73V3l6q… Zach B… Easy Coun… Something…          4      228013 FALSE   
#> 6 0aEPP6wdKf2uBYE… Zach B… Relaxing … Something…          4      228013 FALSE   
#> # ℹ 14 more variables: danceability <dbl>, energy <dbl>, key <dbl>,
#> #   loudness <dbl>, mode <dbl>, speechiness <dbl>, acousticness <dbl>,
#> #   instrumentalness <dbl>, liveness <dbl>, valence <dbl>, tempo <dbl>,
#> #   time_signature <dbl>, track_genre <chr>, popular_or_not <chr>
```
