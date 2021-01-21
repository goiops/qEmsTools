#' Pull KML Flight Track
#'
#' Uses the KML API to retrieve and write a KML trajectory directly
#'
#' Sometimes you just want a KML file. This does that. Only KML types prebuilt are available -
#' you'll need to check the API to see which those are.
#' @export
#' @import httr htmltools
#' @param username the EMS username to be used.
#' @param password the EMS password to be used
#' @param flight_record a numeric, indicating the flight record to be used for generation
#' @param trajectory_config a string indicating the trajectory config to be used. The available ones can be viewed at https://qfa-api.au.efoqa.com:443/api/v2/ems-systems/1/trajectory-configurations
#' @examples
#' \dontrun{
#' flight_track <- pull_kml_flight_track("firstname.lastname", "password", flight_record = 1)
#' write(flight_track, "flight-track.kml")
#' }
#' @return
#' This function returns the KML data as text XML.To use it, write it to a file with a .kml extension.
#' @author Matt Simmons mattsimmons@qantas.com.au
#'
#'
#'

pull_kml_flight_track <- function(username, password, flight_record, trajectory_config = "Flight Pulse 1.0") {

  base_url = "https://qfa-api.au.efoqa.com/api"

  token_content <- get_emsapi_token(username, password)

  trajectory_urlify <- htmltools::urlEncodePath(trajectory_config)

  kml_request <- httr::GET(url = paste0(base_url,
                                  "/v2/ems-systems/1/flights/",
                                  flight_record,
                                  "/kml-trajectories/",
                                  trajectory_urlify),
                     config = httr::add_headers(`Content-Type` = "application/json",
                                          Accept = "application/json",
                                          Authorization = paste0("Bearer ", token_content)
                     ))

  return(httr::content(kml_request, as = "text"))
}

