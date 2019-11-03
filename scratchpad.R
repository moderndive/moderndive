# Let's go!! Defining geom_parallel_slopes()
y <- "log10_price"
numerical_x <- "log10_size"
categorical_x <- "condition"





# https://cran.r-project.org/web/packages/ggplot2/vignettes/extending-ggplot2.html

suppressPackageStartupMessages(library(tidyverse))
set.seed(76)
library(moderndive)
data("house_prices")
house_prices <- house_prices %>%
  mutate(
    log10_price = log10(price),
    log10_size = log10(sqft_living)
  ) %>% 
  sample_n(100) 

model_price_3_points <-
  house_prices %>%
  lm(log10_price ~ log10_size + condition, data = .) %>%
  get_regression_points()


StatParallelSlopes <- ggproto("StatParallelSlopes", Stat,
                              
                              compute_group = function(data, scales) {
                                output <- data %>%
                                  lm(y ~ x + group, data = .) %>%
                                  get_regression_points() %>% 
                                  select(-y) %>% 
                                  rename(y = y_hat)
                                # print(output)
                                output
                              },
                              required_aes = c("x", "y")
)
GeomParallelLines <- ggproto("GeomParallelLines", GeomLine,
                             default_aes = aes(colour = "black", fill = NA, size = 0.5, linetype = 1,
                                               alpha = NA)
)
geom_parallel_slopes <- function(mapping = NULL, data = NULL, 
                                 position = "identity", na.rm = FALSE, show.legend = NA, 
                                 inherit.aes = TRUE, ...) {
  layer(
    stat = StatParallelSlopes, geom = GeomParallelLines, data = data, mapping = mapping,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

ggplot(house_prices, aes(x = log10_size, y = log10_price, col = condition)) +
  geom_point(alpha = 0.3) +
  labs(y = "log10 price", x = "log10 square footage", title = "Seattle House Prices") +
  # geom_line(data = model_price_3_points, aes(y = log10_price_hat), size = 1.5, show.legend = FALSE) +
  geom_parallel_slopes(size = 1)

























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




