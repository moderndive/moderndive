library(tidyverse)

spotify <- read_csv("data-raw/spotify_dataset.csv") |> 
  select(-`...1`)

spotify_by_genre <- spotify |> 
  filter(track_genre %in% c("metal", "deep-house", "rock", "dubstep",
                            "hip-hop", "country")) |> 
  mutate(popular_or_not = ifelse(popularity > 50, "popular", "not popular"))

spotify_metal_deephouse <- spotify_by_genre |> 
  filter(track_genre %in% c("metal", "deep-house")) |> 
  select(track_id, track_genre, artists, track_name, popularity, popular_or_not) 

set.seed(2024)

# Calculate the number of "popular" songs to sample for each genre
metal_popular_n <- round(26 * 0.563)
deephouse_popular_n <- round(26 * 0.529)

# Sample "popular" and "not popular" from metal genre
metal_sample_popular <- spotify_metal_deephouse |>
  filter(track_genre == "metal", popular_or_not == "popular") |>
  slice_sample(n = metal_popular_n)

metal_sample_not_popular <- spotify_metal_deephouse |>
  filter(track_genre == "metal", popular_or_not == "not popular") |>
  slice_sample(n = 26 - metal_popular_n)

# Sample "popular" and "not popular" from deep house genre
deephouse_sample_popular <- spotify_metal_deephouse |>
  filter(track_genre == "deep-house", popular_or_not == "popular") |>
  slice_sample(n = deephouse_popular_n)

deephouse_sample_not_popular <- spotify_metal_deephouse |>
  filter(track_genre == "deep-house", popular_or_not == "not popular") |>
  slice_sample(n = 26 - deephouse_popular_n)

# Combine the samples
combined_sample <- bind_rows(metal_sample_popular, metal_sample_not_popular,
                             deephouse_sample_popular, 
                             deephouse_sample_not_popular) |> 
  slice_sample(n = 52)

spotify_52_shuffled <- combined_sample |> 
  mutate(track_genre = sample(track_genre))

# set.seed(2024)
# 
# spotify_sample <- spotify |> 
#   filter(popularity > 70) |> 
#   distinct(track_id, .keep_all = TRUE) |> 
#   slice_sample(n = 1000)
# 
# spotify_random <- spotify |> 
#   distinct(track_id, .keep_all = TRUE) |> 
#   slice_sample(n = 1000)
# 
# write_rds(spotify_sample, "data-raw/spotify_sample.rds")
# write_rds(spotify_random, "data-raw/spotify_random.rds")
# 

usethis::use_data(spotify_by_genre, overwrite = TRUE)
usethis::use_data(spotify_52_shuffled, overwrite = TRUE)
# usethis::use_data(spotify_random, overwrite = TRUE)
