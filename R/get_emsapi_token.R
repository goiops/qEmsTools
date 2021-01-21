#' Get EMS API Token
#'
#' A simple function to get an EMS API token
#'
#' A simple implementation that gets the token required for other API calls.
#'
#' @export
#' @import httr
#' @param username the EMS username to be used.
#' @param password the EMS password to be used
#' @examples
#' \dontrun{
#' token <- get_emsapi_token("first.name", "password")
#' }
#' @return
#' This function returns a string that can be used as the authorization token for other API calls.
#' @author Matt Simmons mattsimmons@qantas.com.au
#'

get_emsapi_token <- function(username, password) {

  base_url = "https://qfa-api.au.efoqa.com/api"

  token_body <- list( grant_type = "password",
                      username   = username,
                      password   = password)

  token_header <- c("Content-Type" = "application/x-www-form-urlencoded")

  token <- httr::POST(url = paste0(base_url,"/token"),
                      config = httr::add_headers(.headers = token_header),
                      body = token_body,
                      encode = "form"
                      )
  httr::stop_for_status(token, "get authentication token")

  token_content <- httr::content(token)$access_token
  return(token_content)
}
