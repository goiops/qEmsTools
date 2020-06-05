#' getEMSCon
#'
#' Get an EMS Connection object using prompts
#'
#' This securely creates an EMS connection object by using the RStudio prompt feature, so it's not stored in your History.
#' @export
#' @import Rems
#' @importFrom rstudioapi askForPassword
#' @importFrom httr config
#' @param username An EMS username as a string, usually something like "firstname.lastname"
#' @param server_url A URL indicating the root string of the API. Should be left at default unless connecting to another system.
#' @examples
#' \dontrun{
#' con <- getEMSCon("joe.bloggs")
#' qry <- Rems::flt_query(conn = con, ems_name = "my-ems", data_file = "example.db")
#' }
#' @return
#' This function returns a EMS connection object to be used in a FltQuery call.
#' @author Matt Simmons mattsimmons@qantas.com.au
#'
#'
#'


getEMSCon <- function(username, server_url = "https://qfa-api.au.efoqa.com/api") {

  password <- rstudioapi::askForPassword(prompt = "Enter your eFOQA password:")

  connection_object <- Rems::connect(usr = username, pwd = password, server_url = server_url)

  return(connection_object)

}
