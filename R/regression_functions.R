library(tidyverse)
library(broom)
library(formula.tools)
library(stringr)
library(janitor)

formula <- mpg ~ cyl + disp
data <- mtcars
digits <- 3

outcome_variable <- all.vars(lhs(formula))
explanatory_variable <- all.vars(rhs(formula))

# get_regression_table
regression_table <- lm(formula = formula, data = data) %>%
  broom::tidy(conf.int = TRUE) %>%
  mutate_if(is.numeric, round, digits=digits) %>%
  as_tibble() %>%
  clean_names()
regression_table

# get_regression_points
regression_points <- lm(formula = formula, data = data) %>%
  broom::augment() %>%
  mutate_if(is.numeric, round, digits=digits) %>%
  # Show rows at random?
  # rownames_to_column(var = "id") %>%
  # select_(.dots = c("id", outcome_variable, explanatory_variable, ".fitted", ".resid")) %>%
  # sample_frac(1) %>%
  select_(.dots = c(outcome_variable, explanatory_variable, ".fitted", ".resid")) %>%
  rename_at(vars(".fitted"), ~str_c(outcome_variable, "_hat")) %>%
  rename(residual = .resid) %>%
  as_tibble() %>%
  clean_names()
regression_points

# get_regression_summaries
regression_summaries <- lm(formula = formula, data = data) %>%
  broom::glance() %>%
  mutate_if(is.numeric, round, digits=digits) %>%
  select(-c(AIC, BIC, deviance, df.residual, logLik)) %>%
  as_tibble() %>%
  clean_names()
regression_summaries
