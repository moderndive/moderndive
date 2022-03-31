saratoga_houses <- read.csv("https://wjhopper.github.io/SDS-201/data/saratoga_ny_home_prices.csv")
# link piped
usethis::use_data(saratoga_houses, overwrite = TRUE) # data file name fixed; format fixed
