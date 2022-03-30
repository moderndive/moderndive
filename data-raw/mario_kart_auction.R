## code to prepare `mario_kart_auction` dataset goes here
library(tidyverse)
mario_kart_auction <- "data-raw/mariokart.csv" %>%
  read_csv()
usethis::use_data(mario_kart_auction, overwrite = TRUE)
