## code to prepare `babies` dataset goes here

babies <- readr::read_csv("https://wjhopper.github.io/SDS-201/data/babies.csv")

usethis::use_data(babies, overwrite = TRUE)
library(tidyverse)

# Creating new date variable

babies$birthday <- babies$date

# Creating new dates

create <- tibble(
  days = format(seq(as.Date("1961-09-12"), as.Date("1962-09-11"), by="days"), format="%m-%d-%Y"),
  date_days = c(1350:1714)
) %>% 
  mutate(merged = paste(days, date_days))

# Updating birthday in babies dataset

val = 0
index = 1
for (i in babies$birthday) {
  val = which(substr(create$merged, start = 12, stop = 15) == i)
  babies$birthday[index] = substr(create$merged[val], start = 1, stop = 10)
  index = index + 1
}