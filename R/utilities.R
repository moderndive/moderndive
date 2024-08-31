# Copied from ggplot2:
# https://github.com/tidyverse/ggplot2/blob/master/R/utilities.r
message_wrap <- function(...) {
  msg <- paste(..., collapse = "", sep = "")
  wrapped <- strwrap(msg, width = getOption("width") - 2)
  message(paste0(wrapped, collapse = "\n"))
}

utils::globalVariables(c("type", "column"))
