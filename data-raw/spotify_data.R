library(tidyverse)

spotify <- read_csv("data-raw/spotify_dataset.csv") |> 
  select(-`...1`)

spotify_by_genre <- spotify |> 
  filter(track_genre %in% c("metal", "deep-house", "rock", "dubstep",
                            "hip-hop", "country"))

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
# usethis::use_data(spotify_random, overwrite = TRUE)
