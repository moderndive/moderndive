library(tidyverse)
library(stringr)
library(lubridate)
library(devtools)
library(usethis)


#----
# Dunkin Donuts and Starbucks counts in 2016 for 1024 Eastern Massachusetts census tracts
DD_vs_SB <- 
  # Read in eastern MA census tract population counts. Source:
  # https://github.com/DelaneyMoran/FinalProject/blob/master/data/MAincomedata.csv
  read_csv("data-raw/MAincomedata.csv") %>% 
  select(Geo_FIPS, county = Geo_NAME, population = SE_T001_001) %>% 
  mutate(Geo_FIPS = as.double(Geo_FIPS)) %>% 
  separate(county, into = c("fluff", "county", "state"), sep = ",") %>% 
  mutate(county = str_sub(county, 2,)) %>% 
  separate(county, into = c("county", "fluff"), sep = " County") %>% 
  select(-c(fluff, state)) %>% 
  # Join with Dunkin Donuts and Starbucks counts
  right_join(read_csv("data-raw/DD_vs_SB.csv"), by = "Geo_FIPS") %>% 
  mutate(
    FIPS_county = as.character(Geo_FIPS),
    FIPS_county = str_sub(FIPS_county, 1, 5)
    ) %>% 
  select(county, FIPS = Geo_FIPS, median_income = med_inc, population, dunkin_donuts = numDD, starbucks = numSB) %>% 
  gather(shop_type, shops, c(dunkin_donuts, starbucks)) %>% 
  arrange(county, FIPS)
usethis::use_data(DD_vs_SB, overwrite = TRUE)



#----
# House price data from https://www.kaggle.com/harlfoxem/housesalesprediction
house_prices <- read_csv("data-raw/kc_house_data.csv") %>% 
  mutate(
    date = ymd(date),
    condition = factor(condition),
    grade = factor(grade), 
    zipcode = factor(zipcode),
    waterfront = ifelse(waterfront == 0, FALSE, TRUE)
    )
usethis::use_data(house_prices, overwrite = TRUE)



#----
# evals data from: https://www.openintro.org/stat/data/?data=evals
load(url("http://www.openintro.org/stat/data/evals.RData"))
evals <- evals %>% 
  as_tibble() %>% 
  select(-starts_with("bty_m")) %>% 
  select(-starts_with("bty_f")) %>% 
  select(-c(cls_perc_eval, cls_credits, cls_profs)) %>% 
  mutate(ID = 1:n()) %>% 
  select(ID, score, age, bty_avg, gender, ethnicity, language, rank, starts_with("pic_"), everything())
use_this::use_data(evals, overwrite = TRUE)



#----
# Population of 800 pennies from
# https://www.statcrunch.com/app/index.php?dataid=301596
pennies <- read_csv("data-raw/population_of_pennies.csv")
use_this::use_data(pennies, overwrite = TRUE)


# A pseudorandom sample of the `pennies` tibble used
# in explaining bootstrapping
set.seed(2018)
pennies_sample <- pennies %>% sample_n(40)
use_this::use_data(pennies_sample, overwrite = TRUE)

# Sample of 50 pennies from Florence Bank at the corner of Main Street and
# Pleasant/King Street in Northampton MA on Friday 2019/2/1
pennies_sample_2 <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vRtLeHU6j9PRTAJ0bRcUF2uVc1TzYeXd9cC0lwCRfBREy8POx6MgfVeK2CJU6emRKFn_51H-Z8H5YlS/pub?gid=0&single=true&output=csv" %>% 
  read_csv() %>% 
  mutate(ID = 1:n()) %>% 
  select(ID, year)
usethis::use_data(pennies_sample_2, overwrite = TRUE)
  




#----
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
use_this::use_data(bowl, overwrite = TRUE)


# 10 samples of size n=50 from
# https://github.com/moderndive/moderndive_book/blob/master/images/sampling_bowl.jpeg
bowl_samples <- read_csv("data-raw/sampling_responses.csv") %>% 
  mutate(n = red + white + green)
use_this::use_data(bowl_samples, overwrite = TRUE)


# 33 tactile samples of size n=50 from
# https://github.com/moderndive/moderndive_book/blob/master/images/sampling_bowl.jpeg
tactile_prop_red <- read_csv("data-raw/sampling_red_balls.csv")
use_this::use_data(tactile_prop_red, overwrite = TRUE)



#----
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
use_this::use_data(mythbusters_yawn, overwrite = TRUE)



#----
# Alaska Airlines flights only
library(nycflights13)
alaska_flights <- flights %>% 
  filter(carrier == "AS")
usethis::use_data(alaska_flights, overwrite = TRUE)
