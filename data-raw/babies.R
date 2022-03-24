## code to prepare `babies` dataset goes here

babies <- readr::read_csv("https://wjhopper.github.io/SDS-201/data/babies.csv")

usethis::use_data(babies, overwrite = TRUE)
