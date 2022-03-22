## code to prepare `coffee_quality_data` dataset goes here
coffee_quality_data <- readr::read_csv("https://wjhopper.github.io/SDS-201/data/coffee_ratings.csv")
usethis::use_data(coffee_quality_data, overwrite = TRUE)
