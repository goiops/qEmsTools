#' Pull Dataframe Flight Track
#'
#' Uses the Trajectory API to retrieve a flight track directly
#'
#' Sometimes you just want a flight track. This uses the simple trajectories API
#' to pull a dataframe with just the offset, latitude, longitude and altitude of a flight by second.
#' Not entirely clear just yet what parameters specifically are used.
#' @export
#' @import httr
#' @importFrom dplyr bind_rows
#' @param username the EMS username to be used.
#' @param password the EMS password to be used
#' @param flight_record a numeric, indicating the flight record to be used for generation
#' @param start a numeric, indicating the seconds offset the trajectory should start at (optional, defaults to start of record)
#' @param end a numeric, indicating the seconds offset the trajectory should end at (optional, defaults to end of record)
#' @examples
#' \dontrun{
#' flight_track <- pull_kml_flight_track("firstname.lastname", "password", flight_record = 1)
#' write(flight_track, "flight-track.kml")
#' }
#' @return
#' This function returns the KML data as text XML.To use it, write it to a file with a .kml extension.
#' @author Matt Simmons mattsimmons@qantas.com.au
#'


pull_df_flight_track <- function(username, password, flight_record, start = NULL, end = NULL) {

  base_url = "https://qfa-api.au.efoqa.com/api"
  token_content <- get_emsapi_token(username, password)

  df_request_url <- paste0(base_url,
                           "/v2/ems-systems/1/flights/",
                           flight_record,
                           "/trajectories/")

  if(!is.null(start) & !is.null(end)) {
    df_request_url <- paste0(df_request_url, "?start=", start, "&end=", end)
  } else if(!is.null(start)) {
    df_request_url <- paste0(df_request_url, "?start=", start)
  } else if(!is.null(end)) {
    df_request_url <- paste0(df_request_url, "?end=", end)
  }

  df_request <- httr::GET(url = df_request_url,
                           config = httr::add_headers(`Content-Type` = "application/json",
                                                      Accept = "application/json",
                                                      Authorization = paste0("Bearer ", token_content)
                           ))
  httr::stop_for_status(df_request, task = "pull flight trajectory")
  df_content <- httr::content(df_request)

  names(df_content) <- ""
  df <- dplyr::bind_rows(df_content)
  df$flight_record <- flight_record
  return(df)

}
