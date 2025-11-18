# This function calculates the five-number summary (minimum, first quartile, median, third quartile, maximum) for specified numeric columns in a data frame and returns the results in a long format. It also handles categorical, factor, and logical columns by counting the occurrences of each level or value, and includes the results in the summary. The `type` column indicates whether the data is numeric, character, factor, or logical.

This function calculates the five-number summary (minimum, first
quartile, median, third quartile, maximum) for specified numeric columns
in a data frame and returns the results in a long format. It also
handles categorical, factor, and logical columns by counting the
occurrences of each level or value, and includes the results in the
summary. The `type` column indicates whether the data is numeric,
character, factor, or logical.

## Usage

``` r
tidy_summary(df, columns = names(df), ...)
```

## Arguments

- df:

  A data frame containing the data. The data frame must have at least
  one row.

- columns:

  Unquoted column names or tidyselect helpers specifying the columns for
  which to calculate the summary. Defaults to call columns in the
  inputted data frame.

- ...:

  Additional arguments passed to the `min`, `quantile`, `median`, and
  `max` functions, such as `na.rm`.

## Value

A tibble in long format with columns:

- column:

  The name of the column.

- n:

  The number of non-missing values in the column for numeric variables
  and the number of non-missing values in the group for categorical,
  factor, and logical columns.

- group:

  The group level or value for categorical, factor, and logical columns.

- type:

  The type of data in the column (numeric, character, factor, or
  logical).

- min:

  The minimum value (for numeric columns).

- Q1:

  The first quartile (for numeric columns).

- mean:

  The mean value (for numeric columns).

- median:

  The median value (for numeric columns).

- Q3:

  The third quartile (for numeric columns).

- max:

  The maximum value (for numeric columns).

- sd:

  The standard deviation (for numeric columns).

## Examples

``` r
# Example usage with a simple data frame
df <- tibble::tibble(
  category = factor(c("A", "B", "A", "C")),
  int_values = c(10, 15, 7, 8),
  num_values = c(8.2, 0.3, -2.1, 5.5),
  one_missing_value = c(NA, 1, 2, 3),
  flag = c(TRUE, FALSE, TRUE, TRUE)
)

# Specify columns
tidy_summary(df, columns = c(category, int_values, num_values, flag))
#> # A tibble: 7 × 11
#>   column         n group type      min    Q1  mean median    Q3   max    sd
#>   <chr>      <int> <chr> <chr>   <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl>
#> 1 int_values     4 NA    numeric   7    7.75 10       9   11.2   15    3.56
#> 2 num_values     4 NA    numeric  -2.1 -0.3   2.97    2.9  6.18   8.2  4.71
#> 3 category       2 A     factor   NA   NA    NA      NA   NA     NA   NA   
#> 4 category       1 B     factor   NA   NA    NA      NA   NA     NA   NA   
#> 5 category       1 C     factor   NA   NA    NA      NA   NA     NA   NA   
#> 6 flag           1 FALSE logical  NA   NA    NA      NA   NA     NA   NA   
#> 7 flag           3 TRUE  logical  NA   NA    NA      NA   NA     NA   NA   

# Defaults to full data frame (note an error will be given without
# specifying `na.rm = TRUE` since `one_missing_value` has an `NA`)
tidy_summary(df, na.rm = TRUE)
#> # A tibble: 8 × 11
#>   column                n group type    min    Q1  mean median    Q3   max    sd
#>   <chr>             <int> <chr> <chr> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl>
#> 1 int_values            4 NA    nume…   7    7.75 10       9   11.2   15    3.56
#> 2 num_values            4 NA    nume…  -2.1 -0.3   2.97    2.9  6.18   8.2  4.71
#> 3 one_missing_value     3 NA    nume…   1    1.5   2       2    2.5    3    1   
#> 4 category              2 A     fact…  NA   NA    NA      NA   NA     NA   NA   
#> 5 category              1 B     fact…  NA   NA    NA      NA   NA     NA   NA   
#> 6 category              1 C     fact…  NA   NA    NA      NA   NA     NA   NA   
#> 7 flag                  1 FALSE logi…  NA   NA    NA      NA   NA     NA   NA   
#> 8 flag                  3 TRUE  logi…  NA   NA    NA      NA   NA     NA   NA   

# Example with additional arguments for quantile functions
tidy_summary(df, columns = c(one_missing_value), na.rm = TRUE)
#> # A tibble: 1 × 11
#>   column                n group type    min    Q1  mean median    Q3   max    sd
#>   <chr>             <int> <chr> <chr> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl>
#> 1 one_missing_value     3 NA    nume…     1   1.5     2      2   2.5     3     1
```
