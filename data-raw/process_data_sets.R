library(tidyverse)
library(stringr)
library(lubridate)
library(devtools)
library(usethis)
library(janitor)
library(openintro)



#----
# evals data from:
# https://cran.r-project.org/web/packages/openintro/openintro.pdf#page=66
set.seed(76)
promotions <- gender.discrimination %>%
  as_tibble() %>% 
  mutate(decision = factor(decision, levels = c("promoted", "not")),
         gender = factor(gender, levels = c("male", "female"))) %>% 
  arrange(desc(decision), gender) %>% 
  mutate(id = 1:n()) %>% 
  select(id, decision, gender) 
usethis::use_data(promotions, overwrite = TRUE)



#----
# Massachusetts Public Schools Data: Student body, funding levels, and outcomes 
# (SAT, MCAS, APs, college attendance) from Kaggle:
# https://www.kaggle.com/ndalziel/massachusetts-public-schools-data
MA_schools <- 
  read_csv("data-raw/MA_Public_Schools_2017.csv") %>% 
  clean_names() %>% 
  # This converts the numerical variable total_enrollment into a categorical one
  # school_size by cutting it into three chunks:
  mutate(school_size = cut_number(total_enrollment, n = 3)) %>% 
  # For aesthetic purposes we changed the levels of the school_size variable to be
  # small, medium, and large
  mutate(size = recode_factor(school_size, 
                                     "[0,341]" = "small", 
                                     "(341,541]" = "medium", 
                                     "(541,4.26e+03]" = "large")) %>% 
  # Next we filtered to only include schools that had 11th and 12th grade
  # students. We do this because students in the 11th and 12th grade take the math
  # SAT.
  filter(x11_enrollment > 0 & x12_enrollment > 0) %>% 
  # 58 schools has NA's for average_sat_math, we remove them:
  filter(!is.na(average_sat_math)) %>% 
  select(school_name, average_sat_math, perc_disadvan = percent_economically_disadvantaged, size)
usethis::use_data(MA_schools, overwrite = TRUE)


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
usethis::use_data(evals, overwrite = TRUE)



#----
# Population of 800 pennies from
# https://www.statcrunch.com/app/index.php?dataid=301596
pennies <- read_csv("data-raw/population_of_pennies.csv")
usethis::use_data(pennies, overwrite = TRUE)


# A pseudorandom sample of the `pennies` tibble used
# in explaining bootstrapping
set.seed(2018)
pennies_sample <- pennies %>% sample_n(40)
usethis::use_data(pennies_sample, overwrite = TRUE)

# Sample of 50 pennies from Florence Bank at the corner of Main Street and
# Pleasant/King Street in Northampton MA on Friday 2019/2/1
pennies_sample_2 <- 
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vRtLeHU6j9PRTAJ0bRcUF2uVc1TzYeXd9cC0lwCRfBREy8POx6MgfVeK2CJU6emRKFn_51H-Z8H5YlS/pub?gid=0&single=true&output=csv" %>% 
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
usethis::use_data(bowl, overwrite = TRUE)


# 10 samples of size n=50 from
# https://github.com/moderndive/moderndive_book/blob/master/images/sampling_bowl.jpeg
bowl_samples <- read_csv("data-raw/sampling_responses.csv") %>% 
  mutate(n = red + white + green)
usethis::use_data(bowl_samples, overwrite = TRUE)


# 33 tactile samples of size n=50 from
# https://github.com/moderndive/moderndive_book/blob/master/images/sampling_bowl.jpeg
tactile_prop_red <- read_csv("data-raw/sampling_red_balls.csv")
usethis::use_data(tactile_prop_red, overwrite = TRUE)


# Ilyas and Yohan's shovel sample in Chapter 9 case study:
set.seed(76)
tactile_shovel_1 <- c(rep("red", 21), rep("white", 50 - 21)) %>% 
  sample() %>% 
  tibble::tibble(color = .)
usethis::use_data(tactile_shovel_1, overwrite = TRUE)



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
usethis::use_data(mythbusters_yawn, overwrite = TRUE)



#----
# Alaska Airlines flights only
library(nycflights13)
alaska_flights <- flights %>% 
  filter(carrier == "AS")
usethis::use_data(alaska_flights, overwrite = TRUE)
