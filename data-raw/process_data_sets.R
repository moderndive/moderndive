library(tidyverse)
library(stringr)
library(lubridate)
library(devtools)
library(usethis)
library(janitor)
library(openintro)
library(ggplot2movies)
library(nycflights13)
library(nycflights23)


#-------------------------------------------------------------------------------
# Datasets: Documented in R/datasets.R
#-------------------------------------------------------------------------------
early_january_weather <- nycflights13::weather %>%
  filter(origin == "EWR" & month == 1 & day <= 15)
usethis::use_data(early_january_weather, overwrite = TRUE)

# Alaska airlines flights only, 
# previously used in moderndive.com Chapter 2 Data Viz
alaska_flights <- nycflights13::flights %>%
  filter(carrier == "AS")
usethis::use_data(alaska_flights, overwrite = TRUE)


early_january_2023_weather <- nycflights23::weather %>%
  filter(origin == "EWR" & month == 1 & day <= 15)
usethis::use_data(early_january_2023_weather, overwrite = TRUE)

# Envoy Air flights only, used in moderndive.com Chapter 2 Data Viz
envoy_flights <- nycflights23::flights %>%
  filter(carrier == "MQ")
usethis::use_data(envoy_flights, overwrite = TRUE)

# Set random number generator seed value for reproducible/replicable random
# sampling:
set.seed(2017)
movies_sample <- ggplot2movies::movies %>%
  select(title, year, rating, Action, Romance) %>%
  # Note that Action & Romance variables are binary. To remove any movies
  # that are both Action & Romance, we will remove them:
  filter(!(Action == 1 & Romance == 1)) %>%
  # Create a new variable genre that specifies whether a movie is
  # "Action", "Romance", or "Neither":
  mutate(genre = case_when(
    Action == 1 ~ "Action",
    Romance == 1 ~ "Romance",
    TRUE ~ "Neither"
  )) %>%
  # We aren't really interested "Neither", so remove these rows:
  filter(genre != "Neither") %>%
  # Action & Romance columns variables are not needed anymore since info is in
  # genre column, so remove these columns
  select(-Action, -Romance) %>%
  # Sample 68 rows
  sample_n(68)
usethis::use_data(movies_sample, overwrite = TRUE)


# evals data from:
# https://cran.r-project.org/web/packages/openintro/openintro.pdf#page=66
set.seed(76)
promotions <- gender_discrimination %>%
  as_tibble() %>%
  mutate(
    decision = factor(decision, levels = c("not", "promoted")),
    gender = factor(gender, levels = c("male", "female"))
  ) %>%
  arrange(desc(decision), gender) %>%
  mutate(id = 1:n()) %>%
  select(id, decision, gender)
usethis::use_data(promotions, overwrite = TRUE)

# one shuffle of promotions
set.seed(2019)
promotions_shuffled <- promotions %>%
  mutate(gender = sample(gender))
usethis::use_data(promotions_shuffled, overwrite = TRUE)



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
    "(541,4.26e+03]" = "large"
  )) %>%
  # Next we filtered to only include schools that had 11th and 12th grade
  # students. We do this because students in the 11th and 12th grade take the math
  # SAT.
  filter(x11_enrollment > 0 & x12_enrollment > 0) %>%
  # 58 schools has NA's for average_sat_math, we remove them:
  filter(!is.na(average_sat_math)) %>%
  select(school_name, average_sat_math, perc_disadvan = percent_economically_disadvantaged, size)
usethis::use_data(MA_schools, overwrite = TRUE)


# Dunkin Donuts and Starbucks counts in 2016 for 1024 Eastern Massachusetts census tracts
DD_vs_SB <-
  # Read in eastern MA census tract population counts. Source:
  # https://github.com/DelaneyMoran/FinalProject/blob/master/data/MAincomedata.csv
  read_csv("data-raw/MAincomedata.csv") %>%
  select(Geo_FIPS, county = Geo_NAME, population = SE_T001_001) %>%
  mutate(Geo_FIPS = as.double(Geo_FIPS)) %>%
  separate(county, into = c("fluff", "county", "state"), sep = ",") %>%
  mutate(county = str_sub(county, 2, )) %>%
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


# evals data from: https://www.openintro.org/stat/data/?data=evals
load("data-raw/evals.RData")
evals <- evals %>%
  as_tibble() %>%
  select(-starts_with("bty_m")) %>%
  select(-starts_with("bty_f")) %>%
  select(-c(cls_perc_eval, cls_credits, cls_profs)) %>%
  mutate(ID = 1:n())

# ID 94 unique profs in this data. 94 value confirmed here:
# https://chance.amstat.org/2013/04/looking-good/
unique_profs <- evals %>%
  select(rank, ethnicity, gender, language, age, bty_avg) %>%
  distinct() %>%
  mutate(prof_ID = 1:n())

# join
evals <- evals %>%
  left_join(unique_profs, by = c("rank", "ethnicity", "gender", "language", "age", "bty_avg")) %>%
  select(ID, prof_ID, score, age, bty_avg, gender, ethnicity, language, rank, starts_with("pic_"), everything())
usethis::use_data(evals, overwrite = TRUE)


# Data derived from the results of a study conducted
# on the Mythbusters television show on Discovery Network
# investigating whether yawning is contagious
# https://www.discovery.com/tv-shows/mythbusters/videos/is-yawning-contagious
group <- c(
  rep("control", 12), rep("seed", 24),
  rep("control", 4), rep("seed", 10)
)
yawn <- c(rep("no", 36), rep("yes", 14))
mythbusters_yawn <- tibble::tibble(group, yawn) %>%
  sample_n(50) %>%
  mutate(subj = seq(1, 50)) %>%
  select(subj, group, yawn)
usethis::use_data(mythbusters_yawn, overwrite = TRUE)

# Amazon books data from: https://dasl.datadescription.com/datafile/amazon-books
amazon_books <- 
  "data-raw/amazon_books.csv" %>%
  read_csv(col_types = list(`Hard/ Paper` = col_factor())) %>%
  clean_names()
usethis::use_data(amazon_books, overwrite = TRUE)


#-------------------------------------------------------------------------------
# Sampling bowl: Documented in R/bowl.R
#-------------------------------------------------------------------------------
# Sampling bowl used at Amherst College http://www.qualitytng.com/sampling-bowls/
set.seed(76)
N <- 2400
bowl <-
  tibble::tibble(
    color = c(rep("red", 900), rep("white", N - 900))
  ) %>%
  sample_frac(1) %>%
  mutate(
    ball_ID = 1:N
  ) %>%
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
bowl_sample_1 <- c(rep("red", 21), rep("white", 50 - 21)) %>%
  sample() %>%
  tibble::tibble(color = .)
usethis::use_data(bowl_sample_1, overwrite = TRUE)


# Tactile samples from bowl
# Original Google Sheet here:
# https://docs.google.com/spreadsheets/d/1KgJYLiKZ7yhXUAvL4Xacchz3H_aNfCPmrFdFsmeb1VE/
bowl_samples <-
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vSEzMpfzZ-VC2sEUpc97d3IdzqEyMANrgG0jbzzRwpiNPJu1sNgO_oWopl5yctUzmn0N-8yHPcmjfIh/pub?gid=36230158&single=true&output=csv" %>%
  read_csv() %>%
  mutate(replicate = 1:n()) %>%
  select(replicate,
    name = Name,
    num_red = `How many of the balls in your shovel were red?`, everything()
  ) %>%
  # Transform
  gather(ID, color, -c(replicate, name, num_red)) %>%
  select(-c(num_red, ID)) %>%
  arrange(name) %>%
  mutate(color = tolower(color))
usethis::use_data(bowl_samples, overwrite = TRUE)




#-------------------------------------------------------------------------------
# Pennies: Documented in R/pennie.R
#-------------------------------------------------------------------------------
# Population of 800 pennies from
# https://www.statcrunch.com:443/app/index.html?dataid=301596
pennies <- read_csv("data-raw/population_of_pennies.csv")
usethis::use_data(pennies, overwrite = TRUE)

# A pseudorandom sample of the `pennies` tibble used
# in explaining bootstrapping
set.seed(2018)
orig_pennies_sample <- pennies %>%
  sample_n(40)
usethis::use_data(orig_pennies_sample, overwrite = TRUE)

# Sample of 50 pennies from Florence Bank at the corner of Main Street and
# Pleasant/King Street in Northampton MA on Friday 2019/2/1
# Original Google Sheet here:
# https://docs.google.com/spreadsheets/d/1kG_s7LhGVusL-oFqWPHygX6cebOTzSERxbJXT3I2xoo/
pennies_sample <-
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vRtLeHU6j9PRTAJ0bRcUF2uVc1TzYeXd9cC0lwCRfBREy8POx6MgfVeK2CJU6emRKFn_51H-Z8H5YlS/pub?gid=0&single=true&output=csv" %>%
  read_csv() %>%
  mutate(ID = 1:n()) %>%
  select(ID, year)
usethis::use_data(pennies_sample, overwrite = TRUE)


# Resamples of pennies_sample
# Original Google Sheet here:
# https://docs.google.com/spreadsheets/d/1y3kOsU_wDrDd5eiJbEtLeHT9L5SvpZb_TrzwFBsouk0/edit#gid=1559206855
pennies_resamples <-
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vS-8hCHL4Gt6KvtjlSlA42CC4eNPhN4tg7yM4NVQ1MRa1mIA0EUf3t0NThNrw5ctlBWjKUbQPYuevS6/pub?gid=1559206855&single=true&output=csv" %>%
  read_csv() %>%
  select(-`Resampled penny #`) %>%
  gather(name, year) %>%
  group_by(name) %>%
  nest() %>%
  mutate(replicate = 1:n()) %>%
  select(replicate, everything()) %>%
  unnest(cols = c(data))
usethis::use_data(pennies_resamples, overwrite = TRUE)


# Massachusetts traffic data 2020
# Original Google Sheet here:
# https://docs.google.com/spreadsheets/d/1rRQIDBBs8DoPAk012BdgDuf4V7iFNZzj3PL4vWfK_IQ/edit#gid=2001681887
mass_traffic_2020 <- read_csv("data-raw/masstraffic2020.csv") %>% 
  clean_names() %>% 
  mutate(county = as_factor(county),
         rural_urban = as_factor(rural_urban),
         dir = as_factor(dir),
         functional_class = as_factor(functional_class))
usethis::use_data(mass_traffic_2020, overwrite = TRUE)



#-------------------------------------------------------------------------------
# Coffee quality data
# Google Sheet here: https://docs.google.com/spreadsheets/d/1fscb1AbsSXWqqws-hhWAZfT580ms_FvOkBBQsJwozSY/edit
# Original Github source: https://github.com/jldbc/coffee-quality-database
#-------------------------------------------------------------------------------

coffee_ratings <- 
  "https://wjhopper.github.io/SDS-201/data/coffee_ratings.csv" %>%
  read_csv() %>%
  mutate(
    species = as.factor(species),
    grading_date = mdy(grading_date),
    color = as.factor(color),
    expiration = mdy(expiration),
    unit_of_measurement = as.factor(unit_of_measurement)
  )

usethis::use_data(coffee_ratings, overwrite = TRUE)

## Adding international powerlifting data
ipf_lifts <- 
  "data-raw/IPF Lifts - ipf_lifts.csv" %>%
  read_csv() %>%
  clean_names() %>% 
  mutate(
    sex = as.factor(sex),
    event = as.factor(event),
    equipment = as.factor(equipment),
    age_class = as.factor(age_class),
    division = as.factor(division),
    place = as.character(place),
    federation = as.factor(federation)
  )
usethis::use_data(ipf_lifts, overwrite = TRUE)


#-------------------------------------------------------------------------------
# Babies: Documented in R/babies.R
#-------------------------------------------------------------------------------
# Population of 1236 babies from
# https://wjhopper.github.io/SDS-201/data/babies.csv
babies <- read_csv("data-raw/babies.csv") %>%
  clean_names() %>%
  mutate(birthday = as.Date(date, origin = "1958-01-01"))

usethis::use_data(babies, overwrite = TRUE)

# Electric vehicle charging sessions
# information from 3,395 high resolution electric vehicle charging sessions
# Original data from: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/NFPQLW
ev_charging <-
  read_csv("data-raw/station_data_dataverse.csv") %>%
  mutate(
    facility_type = factor(
      facilityType,
      labels = c(
        "manufacturing",
        "office",
        "research and development",
        "other"
      )
    )
  ) %>%
  select(-facilityType) %>%
  clean_names()
usethis::use_data(ev_charging, overwrite = TRUE)

# Massachussets 2020 vs. 2019 Traffic Data
ma_traffic_2020_vs_2019 <- 
  "data-raw/Massachusetts_2020_vs_2019_Traffic_Data.csv" %>% 
  read_csv() %>% 
  clean_names() %>% 
  mutate(functional_class = as_factor(functional_class))
usethis::use_data(ma_traffic_2020_vs_2019, overwrite = TRUE)

#-------------------------------------------------------------------------------
# Mario kart auctions: Documented in R/datasets.R
#-------------------------------------------------------------------------------
## Population of 143 Ebay auctions selling Mario Kart for Nintendo Wii
## Original Google Sheet here:
## https://docs.google.com/spreadsheets/d/1jhiTFaaJ4ZCUA9yMNFGQ2xnKItXewaNmzu6y0Syw_dk/edit
mario_kart_auction <- 
  "data-raw/mariokart.csv" %>%
  read_csv() %>%
  mutate(
    cond = as.factor(cond),
    ship_sp = as.factor(ship_sp),
    stock_photo = as.factor(stock_photo)
  )
usethis::use_data(mario_kart_auction, overwrite = TRUE)

# Avocado Prices By Region
# Original Google Sheet here:
# https://docs.google.com/spreadsheets/d/1cNuj9V-9Xe8fqV3DQRhvsXJhER3zTkO1dSsQ1Q0j96g/edit#gid=1419070688
avocados <-
  "data-raw/avocados.csv" %>%
  read_csv() %>%
  janitor::clean_names() %>%
  mutate(type = as.factor(type)) %>%
  rename(xlarge_hass_sold = xlarage_hass_sold)
usethis::use_data(avocados, overwrite = TRUE)


# saratoga housing prices
# original google sheet here: https://docs.google.com/spreadsheets/d/1AY5eECqNIggKpYF3kYzJQBIuuOdkiclFhbjAmY3Yc8E
saratoga_houses <- 
  "data-raw/saratoga_houses.csv" %>%
  read_csv() %>%
  janitor::clean_names()
usethis::use_data(saratoga_houses, overwrite = TRUE)

# almonds data
almonds_bowl <- "data-raw/almonds_bowl.rds" |> 
  read_rds()
usethis::use_data(almonds_bowl, overwrite = TRUE)

almonds_sample_100 <- "data-raw/almonds_sample_100.rds" |> 
  read_rds() |> 
  ungroup() |> 
  select(ID, weight)
usethis::use_data(almonds_sample_100, overwrite = TRUE)
