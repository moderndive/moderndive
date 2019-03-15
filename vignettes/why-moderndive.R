## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
knitr::opts_chunk$set(
  echo=TRUE, message=FALSE, warning=FALSE,
  fig.width=16/2, fig.height=9/2
  )

# Needed packages
library(dplyr)
library(ggplot2)
library(moderndive)
library(knitr)
library(broom)

# https://www.youtube.com/watch?v=xjJ7FheCkCU
set.seed(76)

## ---- echo=FALSE---------------------------------------------------------
library(moderndive)
library(knitr)
evals %>% 
  select(ID, score, age, bty_avg, gender, ethnicity, language, rank) %>% 
  sample_n(5) %>% 
  kable()

## ------------------------------------------------------------------------
library(moderndive)
score_model <- lm(score ~ age, data = evals)

## ------------------------------------------------------------------------
summary(score_model)

## ------------------------------------------------------------------------
get_regression_table(score_model)

## ------------------------------------------------------------------------
get_regression_points(score_model)

## ------------------------------------------------------------------------
get_regression_summaries(score_model)

## ------------------------------------------------------------------------
get_regression_table(score_model)

## ------------------------------------------------------------------------
get_regression_table(score_model) %>% 
  knitr::kable()

## ------------------------------------------------------------------------
sqrt(diag(vcov(score_model)))

## ------------------------------------------------------------------------
get_regression_table(score_model) %>% 
  pull(std_error)

## ------------------------------------------------------------------------
get_regression_table(score_model)$std_error

## ---- eval=FALSE---------------------------------------------------------
#  fitted(score_model)

## ---- echo=FALSE---------------------------------------------------------
fitted(score_model)[1:10]

## ---- eval=FALSE---------------------------------------------------------
#  residuals(score_model)

## ---- echo=FALSE---------------------------------------------------------
residuals(score_model)[1:10]

## ---- eval=FALSE---------------------------------------------------------
#  get_regression_points(score_model)

## ---- echo=FALSE---------------------------------------------------------
get_regression_points(score_model) %>% 
  slice(1:10)

## ---- eval=FALSE---------------------------------------------------------
#  score_model_points <- get_regression_points(score_model)
#  
#  # Histogram of residuals:
#  ggplot(score_model_points, aes(x = residual)) +
#    geom_histogram(bins = 20) +
#    labs(title = "Histogram of residuals")
#  
#  # Investigating patterns:
#  ggplot(score_model_points, aes(x = age, y = residual)) +
#    geom_point() +
#    labs(title = "Residuals over age")

## ---- echo=FALSE, eval=TRUE, fig.width=16/2.2, fig.height=9/2.2----------
score_model_points <- get_regression_points(score_model)

# Histogram of residuals:
ggplot(score_model_points, aes(x = residual)) +
  geom_histogram(bins = 20) +
  labs(title = "Histogram of residuals")

# Investigating patterns:
ggplot(score_model_points, aes(x = age, y = residual)) +
  geom_point() +
  labs(title = "Residuals over age")

## ------------------------------------------------------------------------
new_evals <- evals %>% 
  sample_n(4) %>% 
  select(-score)
new_evals

get_regression_points(score_model, newdata = new_evals)

## ---- out.width = "500px", echo=FALSE, fig.align='center'----------------
knitr::include_graphics("kaggle.png")

## ---- eval=FALSE---------------------------------------------------------
#  library(tidyverse)
#  library(moderndive)
#  
#  # Load in training and test set
#  train <- read_csv("https://github.com/moderndive/moderndive/raw/master/vignettes/train.csv")
#  test <- read_csv("https://github.com/moderndive/moderndive/raw/master/vignettes/test.csv")
#  
#  # Fit model
#  house_model <- lm(SalePrice ~ YrSold, data = train)
#  
#  # Make and submit predictions
#  submission <- get_regression_points(house_model, newdata = test, ID = "Id") %>%
#    select(Id, SalePrice = SalePrice_hat)
#  write_csv(submission, "submission.csv")

## ---- out.width = "100%", echo=FALSE-------------------------------------
knitr::include_graphics("leaderboard_orig.png")

## ------------------------------------------------------------------------
get_regression_summaries(score_model)

## ------------------------------------------------------------------------
get_regression_points(score_model)
broom::augment(score_model)

