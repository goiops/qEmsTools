#' tsDataExtractor
#'
#' Pulls out the dataframe part of a time-series extract and appends the flight record as a column.
#'
#' Time series are usually return as a nested list - this turns them into a simpler format.
#' @export
#' @param ts_data_record a single time-series object returned by a time-series query
#' @examples
#' \dontrun{
#' ts_data <- tsDataExtractor(ts_data_record)
#' }
#' @return
#' This function returns a dataframe with all the time-series parameters requested as well as an extra column for the flight record.
#' @author Matt Simmons mattsimmons@qantas.com.au
#'
#'

tsDataExtractor <- function(ts_data_record) {

  ts_data_record <- ts_data_record[[1]]
  out <- ts_data_record$ts_data
  out$`Flight Record` <- ts_data_record$flt_data$`Flight Record`

  return(out)

}
