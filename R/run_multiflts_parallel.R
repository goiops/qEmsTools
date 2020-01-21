#' run_multiflts_parallel
#'
#' Runs run_multiflts in parallel
#'
#' The longest pole in the tent with multiflts is usually each query - this one makes multiple calls in parallel, as many as your computer will allow.
#' @export
#' @importFrom future plan
#' @importFrom furrr future_map
#' @import purrr
#' @import Rems
#' @param flight_record_vector A vector of flight records
#' @param ts_query a time series FltQuery object
#' @examples
#' \dontrun{
#' ts_multidata <- tsDataExtractor(c(7835627, 1351387, 34543534), ts_query = ts_query)
#' }
#' @return
#' This function returns a list of time_series data lists.
#' @author Matt Simmons mattsimmons@qantas.com.au
#'
#'

run_multiflts_parallel <- function(flight_record_vector, ts_query) {

  future::plan(future::multiprocess)

  ts_records <- furrr::future_map(flight_record_vector,
             ~ Rems::run_multiflts(ts_query, flight = .x))

  return(ts_records)
}
