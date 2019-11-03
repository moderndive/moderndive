context("gg_parallel_slopes")

library(ggplot2)
library(dplyr)
library(moderndive)

# log10() transformations
house_prices <- house_prices %>%
  mutate(
    log10_price = log10(price),
    log10_size = log10(sqft_living)
  )

test_that("plot generates", {
  expect_silent(
    # Output parallel slopes model plot:
    gg_parallel_slopes(y = "log10_price", num_x = "log10_size", cat_x = "condition",
                       data = house_prices, alpha = 0.1) +
      labs(x = "log10 square feet living space", y = "log10 price in USD",
           title = "House prices in Seattle: Parallel slopes model")
  )
})