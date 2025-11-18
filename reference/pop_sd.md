# Calculate Population Standard Deviation

This function calculates the population standard deviation for a numeric
vector.

## Usage

``` r
pop_sd(x)
```

## Arguments

- x:

  A numeric vector for which the population standard deviation should be
  calculated.

## Value

A numeric value representing the population standard deviation of the
vector.

## Examples

``` r
# Example usage:
library(dplyr)
df <- data.frame(weight = c(2, 4, 6, 8, 10))
df |> 
  summarize(population_mean = mean(weight), 
            population_sd = pop_sd(weight))
#>   population_mean population_sd
#> 1               6      2.828427
```
