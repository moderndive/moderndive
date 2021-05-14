## ---- include = FALSE-----------------------------------------------
# knitr settings
knitr::opts_chunk$set(
  # Code output:
  warning = FALSE,
  message = FALSE,
  echo = TRUE,
  # Figure:
  out.width = "100%",
  fig.path = "Figures/",
  fig.width = 16 / 2.5,
  fig.height = 9 / 2.5,
  fig.align = "center",
  fig.show = "hold",
  # Etc:
  collapse = TRUE,
  comment = "##"
  # tidy = FALSE
)

# Needed packages in vignette
library(moderndive)
library(ggplot2)
library(dplyr)
library(readr)
library(knitr)
library(broom)
library(viridis)

# Needed packages internally
library(patchwork)

# Random number generator seed value
set.seed(76)

# Set ggplot defaults for rticles output:
if (!knitr::is_html_output()) {
  # Grey theme:
  theme_set(theme_light())

  scale_colour_discrete <- scale_colour_viridis_d
}


# Set output width for rticles:
options(width = 70)

## -------------------------------------------------------------------
library(moderndive)
library(ggplot2)
library(dplyr)
library(readr)
library(knitr)
library(broom)

## ---- echo=FALSE----------------------------------------------------
evals_sample <- evals %>%
  select(ID, prof_ID, score, age, bty_avg, gender, ethnicity, language, rank) %>%
  sample_n(5)

## ----random-sample-courses, echo=FALSE------------------------------
evals_sample %>%
  kable()

## -------------------------------------------------------------------
score_model <- lm(score ~ age, data = evals)

## -------------------------------------------------------------------
summary(score_model)

## -------------------------------------------------------------------
get_regression_table(score_model)

## -------------------------------------------------------------------
get_regression_points(score_model)

## -------------------------------------------------------------------
get_regression_summaries(score_model)

## ----interaction-model, fig.cap="Visualization of interaction model."----
# Code to visualize interaction model:
ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Age", y = "Teaching score", color = "Ethnicity")

## ----parallel-slopes-model, fig.cap="Visualization of parallel slopes model."----
# Code to visualize parallel slopes model:
ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
  geom_point() +
  geom_parallel_slopes(se = FALSE) +
  labs(x = "Age", y = "Teaching score", color = "Ethnicity")

## -------------------------------------------------------------------
get_regression_table(score_model)

## -------------------------------------------------------------------
get_regression_table(score_model, conf.level = 0.99)

## -------------------------------------------------------------------
sqrt(diag(vcov(score_model)))

## -------------------------------------------------------------------
get_regression_table(score_model) %>%
  pull(std_error)

## -------------------------------------------------------------------
get_regression_table(score_model)$std_error

## -------------------------------------------------------------------
get_regression_table(score_model) %>%
  kable()

## ---- eval=FALSE----------------------------------------------------
#  fitted(score_model)

## ---- echo=FALSE----------------------------------------------------
fitted(score_model)[1:10]

## ---- eval=FALSE----------------------------------------------------
#  residuals(score_model)

## ---- echo=FALSE----------------------------------------------------
residuals(score_model)[1:10]

## ---- eval=FALSE----------------------------------------------------
#  score_model_points <- get_regression_points(score_model)
#  score_model_points

## ---- echo=FALSE----------------------------------------------------
score_model_points <- get_regression_points(score_model)
score_model_points %>%
  slice(1:10)

## ----residuals-1, fig.cap="Histogram visualizing distribution of residuals."----
# Code to visualize distribution of residuals:
ggplot(score_model_points, aes(x = residual)) +
  geom_histogram(bins = 20) +
  labs(x = "Residual", y = "Count")

## ----residuals-2, fig.cap="Partial residual residual plot over age."----
# Code to visualize partial residual plot over age:
ggplot(score_model_points, aes(x = age, y = residual)) +
  geom_point() +
  labs(x = "Age", y = "Residual")

## -------------------------------------------------------------------
new_prof <- tibble(age = c(39, 42))
get_regression_points(score_model, newdata = new_prof)

## ---- eval=FALSE----------------------------------------------------
#  library(readr)
#  library(dplyr)
#  library(moderndive)
#  
#  # Load in training and test set
#  train <- read_csv("https://moderndive.com/data/train.csv")
#  test <- read_csv("https://moderndive.com/data/test.csv")
#  
#  # Fit model:
#  house_model <- lm(SalePrice ~ YrSold, data = train)
#  
#  # Make predictions and save in appropriate data frame format:
#  submission <- house_model %>%
#    get_regression_points(newdata = test, ID = "Id") %>%
#    select(Id, SalePrice = SalePrice_hat)
#  
#  # Write predictions to csv:
#  write_csv(submission, "submission.csv")

## ----kaggle-2, echo=FALSE, fig.cap="Resulting Kaggle RMSLE score."----
knitr::include_graphics("leaderboard_orig.png")

## ---- echo=FALSE----------------------------------------------------
summary(score_model)

## -------------------------------------------------------------------
get_regression_summaries(score_model)

## ----interaction-and-parallel-slopes-model-1, echo=FALSE, fig.height = 9/3, fig.cap = "Interaction (left) and parallel slopes (right) models."----
p1 <- ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
  geom_point() +
  labs(x = "Age", y = "Teaching score", color = "Ethnicity") +
  geom_smooth(method = "lm", se = FALSE) +
  theme(legend.position = "none")
p2 <- ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
  geom_point() +
  labs(x = "Age", y = "Teaching score", color = "Ethnicity") +
  geom_parallel_slopes(se = FALSE) +
  theme(axis.title.y = element_blank())
p1 + p2

## ---- eval=TRUE-----------------------------------------------------
# Regression table for interaction model:
interaction_evals <- lm(score ~ age * ethnicity, data = evals)
get_regression_table(interaction_evals)

# Regression table for parallel slopes model:
parallel_slopes_evals <- lm(score ~ age + ethnicity, data = evals)
get_regression_table(parallel_slopes_evals)

## ---- eval=FALSE----------------------------------------------------
#  # Code to plot interaction and parallel slopes models for MA_schools
#  ggplot(
#    MA_schools,
#    aes(x = perc_disadvan, y = average_sat_math, color = size)
#  ) +
#    geom_point(alpha = 0.25) +
#    labs(
#      x = "% economically disadvantaged",
#      y = "Math SAT Score",
#      color = "School size"
#    ) +
#    geom_smooth(method = "lm", se = FALSE)
#  
#  ggplot(
#    MA_schools,
#    aes(x = perc_disadvan, y = average_sat_math, color = size)
#  ) +
#    geom_point(alpha = 0.25) +
#    labs(
#      x = "% economically disadvantaged",
#      y = "Math SAT Score",
#      color = "School size"
#    ) +
#    geom_parallel_slopes(se = FALSE)

## ----interaction-and-parallel-slopes-model-2, echo=FALSE, fig.height = 9/3, fig.cap = "Interaction (left) and parallel slopes (right) models."----
p1 <- ggplot(MA_schools, aes(x = perc_disadvan, y = average_sat_math, color = size)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    x = "% economically disadvantaged",
    y = "Math SAT Score",
    color = "School size"
  ) +
  theme(legend.position = "none")
p2 <- ggplot(MA_schools, aes(x = perc_disadvan, y = average_sat_math, color = size)) +
  geom_point(alpha = 0.25) +
  geom_parallel_slopes(se = FALSE) +
  labs(
    x = "% economically disadvantaged",
    y = "Math SAT Score",
    color = "School size"
  ) +
  theme(axis.title.y = element_blank())
p1 + p2

## -------------------------------------------------------------------
# Regression table for interaction model:
interaction_MA <-
  lm(average_sat_math ~ perc_disadvan * size, data = MA_schools)
get_regression_table(interaction_MA)

# Regression table for parallel slopes model:
parallel_slopes_MA <-
  lm(average_sat_math ~ perc_disadvan + size, data = MA_schools)
get_regression_table(parallel_slopes_MA)

## -------------------------------------------------------------------
get_regression_points(score_model)
broom::augment(score_model)

