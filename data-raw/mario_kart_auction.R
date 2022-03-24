## code to prepare `mario_kart_auction` dataset goes here
library(tidyverse)
mario_kart_auction <- read_csv("https://www.openintro.org/data/csv/mariokart.csv")
usethis::use_data(mario_kart_auction, overwrite = TRUE)
