devtools::install_github("moderndive/moderndive")
library(moderndive)
library(tidyverse)

# evals
glimpse(evals)
?evals

# house_prices
glimpse(house_prices)
?house_prices
ggplot(house_prices, aes(x = log10(price))) +
  geom_histogram()
