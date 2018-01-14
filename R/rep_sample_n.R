#' Repeating sampling.
#' 
#' @param tbl tbl of data.
#' @param size The number of rows to select.
#' @param replace Sample with or without replacement?
#' @param reps The number of samples to collect.
#' @return A tbl_df that aggregates all created samples, with the addition of a \code{replicate} column that the tbl_df is also grouped by
#' @source \url{https://github.com/OpenIntroOrg/oilabs-r-package/blob/master/R/rep_sample_n.R}
#' @export
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' N <- 2400
#' tub <- data_frame(
#' ball_ID = 1:N,
#' color = c(rep("red", 900), rep("white", N-900))
#' )
#' 
#' p_hats <- tub %>%
#' rep_sample_n(size=50, reps=10) %>% 
#' group_by(replicate) %>% 
#' summarize(prop_red = mean(color == "red"))
#' 
#' ggplot(p_hats, aes(x = prop_red)) + 
#'     geom_histogram(binwidth = 0.05)
rep_sample_n <- function(tbl, size, replace = FALSE, reps = 1)
{
  assertive::assert_is_data.frame(tbl)
  assertive::assert_is_numeric(size)
  assertive::assert_is_logical(replace)
  assertive::assert_is_numeric(reps)
  
  n <- nrow(tbl)
  i <- unlist(replicate(reps, sample.int(n, size, replace = replace), simplify = FALSE))
  
  rep_tbl <- cbind(replicate = rep(1:reps,rep(size,reps)), tbl[i,])
  
  dplyr::group_by(rep_tbl, replicate)
}