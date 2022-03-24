## code to prepare `mario-kart-auction` dataset goes here
library(tidyverse)
`mario-kart-auction` <- read_csv("https://www.openintro.org/data/csv/mariokart.csv")
usethis::use_data(mario-kart-auction, overwrite = TRUE)
