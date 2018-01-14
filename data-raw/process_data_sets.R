library(tidyverse)

# 10 samples of size n=50 from
# https://raw.githubusercontent.com/ismayc/moderndiver-book/master/images/sampling1.jpg
ball_samples <- read_csv("data-raw/sampling_responses.csv") %>% 
  mutate(n = red + white + green)
devtools::use_data(ball_samples, overwrite = TRUE)

# Population of 800 pennies from
# https://www.statcrunch.com/app/index.php?dataid=301596
pennies <- read_csv("data-raw/population_of_pennies.csv")
devtools::use_data(pennies, overwrite = TRUE)
