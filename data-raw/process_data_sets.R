library(tidyverse)

ball_samples <- read_csv("data-raw/sampling_responses.csv") %>% 
  mutate(n = red + white + green)
devtools::use_data(ball_samples, overwrite = TRUE)