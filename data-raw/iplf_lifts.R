## Code to prepare dataset

library(tidyverse)
ipf_lifts <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-08/ipf_lifts.csv") %>% 
  janitor::clean_names()

usethis::use_data(ipf_lifts, overwrite = TRUE)

