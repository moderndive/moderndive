## code to prepare `amazon-books` dataset goes here
library(tidyverse)

amazon_books <- readr::read_csv("data-raw/amazon_books.csv")
amazon_books <- amazon_books %>%
  janitor::clean_names()

usethis::use_data(amazon_books, overwrite = TRUE)