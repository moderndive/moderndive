#' This function calculates the five-number summary (minimum, first quartile, median, third quartile, maximum) for specified numeric columns in a data frame and returns the results in a long format. It also handles categorical, factor, and logical columns by counting the occurrences of each level or value, and includes the results in the summary. The `type` column indicates whether the data is numeric, character, factor, or logical.
#'
#' @param df A data frame containing the data. The data frame must have at least one row.
#' @param columns Unquoted column names or tidyselect helpers specifying the columns for which to calculate the summary. Defaults to call columns in the inputted data frame.
#' @param ... Additional arguments passed to the `min`, `quantile`, `median`, and `max` functions, such as `na.rm`.
#'
#' @return A tibble in long format with columns:
#' \describe{
#'   \item{column}{The name of the column.}
#'   \item{n}{The number of non-missing values in the column for numeric variables and the number of non-missing values in the group for categorical, factor, and logical columns.}
#'   \item{group}{The group level or value for categorical, factor, and logical columns.}
#'   \item{type}{The type of data in the column (numeric, character, factor, or logical).}
#'   \item{min}{The minimum value (for numeric columns).}
#'   \item{Q1}{The first quartile (for numeric columns).}
#'   \item{mean}{The mean value (for numeric columns).}
#'   \item{median}{The median value (for numeric columns).}
#'   \item{Q3}{The third quartile (for numeric columns).}
#'   \item{max}{The maximum value (for numeric columns).}
#'   \item{sd}{The standard deviation (for numeric columns).}
#' }
#'
#' @importFrom dplyr reframe tibble across group_by count mutate bind_rows
#' @importFrom rlang enquo sym
#' @importFrom tidyr pivot_longer unnest_wider
#' @importFrom purrr map_chr map_dfr
#' @export
#'
#' @examples
#' # Example usage with a simple data frame
#' df <- tibble::tibble(
#'   category = factor(c("A", "B", "A", "C")),
#'   int_values = c(10, 15, 7, 8),
#'   num_values = c(8.2, 0.3, -2.1, 5.5),
#'   one_missing_value = c(NA, 1, 2, 3),
#'   flag = c(TRUE, FALSE, TRUE, TRUE)
#' )
#' 
#' # Specify columns
#' tidy_summary(df, columns = c(category, int_values, num_values, flag))
#'
#' # Defaults to full data frame (note an error will be given without
#' # specifying `na.rm = TRUE` since `one_missing_value` has an `NA`)
#' tidy_summary(df, na.rm = TRUE)
#' 
#' # Example with additional arguments for quantile functions
#' tidy_summary(df, columns = c(one_missing_value), na.rm = TRUE)
tidy_summary <- function(df, columns = names(df), ...) {
  
  # Check if df is a data frame
  if (!is.data.frame(df)) {
    stop("The input `df` must be a data frame.")
  }
  
  # Check if df has at least one row
  if (nrow(df) == 0) {
    stop("The input `df` must have at least one row.")
  }
  
  # Capture the columns using enquo() for tidyselect behavior
  columns <- enquo(columns)
  
  # Store the original types of the columns
  original_types <- df |> 
    dplyr::select(!!columns) |> 
    purrr::map_chr(~{
      if (is.numeric(.)) {
        "numeric"
      } else if (is.factor(.)) {
        "factor"
      } else if (is.character(.)) {
        "character"
      } else if (is.logical(.)) {
        "logical"
      } else {
        "other"
      }
    }) |> 
    tibble::enframe(name = "column", value = "type")
  
  num_numeric <- original_types |> dplyr::filter(type == "numeric") |> nrow()
  num_categorical <- original_types |> 
    dplyr::filter(type %in% c("character", "factor", "logical")) |> 
    nrow()
  
  numeric_summary <- NULL
  categorical_logical_summary <- NULL
  
  # Process numeric columns
  if (num_numeric > 0) {
    numeric_summary <- df |> 
      dplyr::reframe(across(
        .cols = !!columns,
        .fns = ~ if(is.numeric(.x)) {
          tibble(
            n = sum(!is.na(.x)),
            group = NA_character_,
            type = "numeric",
            min = min(.x, ...),
            Q1 = quantile(.x, 0.25, ...),
            mean = mean(.x, ...),
            median = median(.x, ...),
            Q3 = quantile(.x, 0.75, ...),
            max = max(.x, ...),
            sd = sd(.x, ...)
          )
        } else {
          NULL
        },
        .names = "{.col}"
      )) |>
      tidyr::pivot_longer(
        cols = everything(),
        names_to = "column",
        values_to = "summary"
      ) |>
      tidyr::unnest_wider(summary)
  }
  
  # Process categorical/factor/logical columns
  if (num_categorical > 0) {
    categorical_logical_summary <- original_types |>
      dplyr::filter(type %in% c("character", "factor", "logical")) |>
      dplyr::pull(column) |>
      purrr::map_dfr(~ {
        df |>
          dplyr::count(!!rlang::sym(.x)) |>
          dplyr::rename(group = !!rlang::sym(.x)) |>
          dplyr::mutate(
            group = as.character(group),
            column = .x,
            type = original_types |> dplyr::filter(column == .x) |> dplyr::pull(type),
            min = NA_real_,
            Q1 = NA_real_,
            mean = NA_real_,
            median = NA_real_,
            Q3 = NA_real_,
            max = NA_real_,
            sd = NA_real_
          )
      })
  }
  
  # Combine the numeric and categorical/logical summaries
  summary_long <- dplyr::bind_rows(numeric_summary, categorical_logical_summary)
  
  return(summary_long)
}
