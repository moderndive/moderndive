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







suppressPackageStartupMessages(library(tidyverse))
library(moderndive)
house_prices <- house_prices %>%
  mutate(
    log10_price = log10(price),
    log10_sqft_living = log10(sqft_living)
  )

# New data
new_houses <- data_frame(
  log10_sqft_living = c(2.9, 3.6),
  condition = factor(c(3, 4))
)

# Train/test split
train <- house_prices %>%
  slice(1:10000)
test <- house_prices %>%
  slice(10001:21613)

# Fit models to training
model_price_3 <- lm(log10_price ~ log10_sqft_living + condition,
                    data = train)

# Three different outputs. Make second look like first since it has outcome
# variable, but third doesn't
get_regression_points(model_price_3)
get_regression_points(model_price_3, newdata = test)
get_regression_points(model_price_3, newdata = new_houses)


library(stats)
library(formula.tools)
library(broom)
library(janitor)
library(stringr)
library(knitr)
model <- model_price_3
digits <- 3
print <- FALSE
newdata <- new_houses
newdata <- test




