context("get_correlation")

vec <- 1:10
vec2 <- seq(from = 5, to = 50, by = 5)
df <- tibble::tibble(vec, vec2)

test_that("arguments are appropriate", {

  expect_error(
    get_correlation(vec,
                    formula = vec ~ NULL)
  )
  
  expect_error(
    df %>% 
      get_correlation(formula = vec ~ NULL)
  )
  
  expect_error(
    df %>% 
      get_correlation(formula = NULL ~ vec2)    
  )
  
  expect_error(
    df %>% 
      get_correlation(formula = vec2)    
  )
  
})

test_that("variables are in data frame", {
  expect_error(
    mtcars %>% 
      get_correlation(formula = mpg2 ~ disp)
  )
  
  expect_error(
    mtcars %>% 
      get_correlation(formula = mpg2 ~ disp2)    
  )
  
  expect_error(
    mtcars %>% 
      get_correlation(formula = mpg ~ disp2)    
  )
  
  expect_silent(
    mtcars %>% 
      get_correlation(formula = mpg ~ disp)
  )
  
  expect_error(
    mtcars %>% 
      get_correlation(formula = mpg ~ disp + hp)
  )
  
})
