library(tidyverse)


# House price data from https://www.kaggle.com/harlfoxem/housesalesprediction
house_prices <- read_csv("data-raw/kc_house_data.csv") %>% 
  mutate(
    condition = factor(condition),
    grade = factor(grade), 
    zipcode = factor(zipcode),
    waterfront = ifelse(waterfront == 0, FALSE, TRUE)
    )
devtools::use_data(house_prices, overwrite = TRUE)



# evals data from: https://www.openintro.org/stat/data/?data=evals
load(url("http://www.openintro.org/stat/data/evals.RData"))
evals <- evals %>% 
  as_tibble() %>% 
  select(-starts_with("bty_m")) %>% 
  select(-starts_with("bty_f")) %>% 
  select(-c(cls_perc_eval, cls_credits, cls_profs)) %>% 
  mutate(ID = 1:n()) %>% 
  select(ID, score, age, bty_avg, gender, ethnicity, language, rank, starts_with("pic_"), everything())
devtools::use_data(evals, overwrite = TRUE)



# 10 samples of size n=50 from
# https://github.com/moderndive/moderndive_book/blob/master/images/sampling_bowl.jpeg
bowl_samples <- read_csv("data-raw/sampling_responses.csv") %>% 
  mutate(n = red + white + green)
devtools::use_data(bowl_samples, overwrite = TRUE)



# 33 tactile samples of size n=50 from
# https://github.com/moderndive/moderndive_book/blob/master/images/sampling_bowl.jpeg
tactile_prop_red <- read_csv("data-raw/sampling_red_balls.csv")
devtools::use_data(tactile_prop_red, overwrite = TRUE)



# Population of 800 pennies from
# https://www.statcrunch.com/app/index.php?dataid=301596
pennies <- read_csv("data-raw/population_of_pennies.csv")
devtools::use_data(pennies, overwrite = TRUE)



# Sampling bowl used in class http://www.qualitytng.com/sampling-bowls/
set.seed(76)
N <- 2400
bowl <- 
  data_frame(
    color = c(rep("red", 900), rep("white", N-900))
  ) %>% 
  sample_frac(1) %>% 
  mutate(
    ball_ID = 1:N) %>% 
  select(ball_ID, everything())
devtools::use_data(bowl, overwrite = TRUE)

# A pseudorandom sample of the `pennies` tibble used
# in explaining bootstrapping
set.seed(2018)
pennies_sample <- pennies %>% sample_n(40)
devtools::use_data(pennies_sample, overwrite = TRUE)

# Data derived from the results of a study conducted
# on the Mythbusters television show on Discovery Network
# investigating whether yawning is contagious
# https://www.discovery.com/tv-shows/mythbusters/videos/is-yawning-contagious
group <- c(rep("control", 12), rep("seed", 24), 
           rep("control", 4), rep("seed", 10))
yawn <- c(rep("no", 36), rep("yes", 14))
mythbusters_yawn <- tibble::tibble(group, yawn) %>% 
  sample_n(50) %>% 
  mutate(subj = seq(1, 50)) %>% 
  select(subj, group, yawn)
devtools::use_data(mythbusters_yawn, overwrite = TRUE)
