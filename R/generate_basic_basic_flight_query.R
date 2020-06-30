#' generate_basic_flight_query
#'
#' Shortcut to create a basic flight query object
#'
#' Creates a new flight query object with a updated fieldtree, and takeoff/landing valid fields
#' filtered to true. Designed to shortcut some of the boilerplate required for EMS queries.
#'
#' @export
#' @param connection_object a ems connection object
#' @param ems_name a string, the name of the EMS instance.
#' @param db_name a string, the name of a .db file to read the tree in. Will attempt to use existing if present.
#' @param reload_preset_fieldtree a boolean to force the preset fieldtree to reload anyway
#'
#' @examples
#' \dontrun{
#' con <- getEMSCon("joe.smith")
#' data_file <- "mydb.db"
#' basic_qry <- generate_basic_flight_query(con, "My-Ems", data_file)
#' }
#' @return
#' Returns a fltqry object for flights with the basic fieldtree updated and some filtering set.
#' @author Matt Simmons mattsimmons@qantas.com.au
#'
#'
#'

generate_basic_flight_query <- function(connection_object, ems_name, db_name, reload_preset_fieldtree = FALSE) {
  base_qry <- flt_query(conn = connection_object, ems_name, db_name)
  db_qry <- base_qry %>%
    set_database("FDW Flights") %>%
    optional_generate_preset_fieldtree(data_file = db_name, full = reload_preset_fieldtree)
  field_qry <- db_qry %>%
    Rems::update_fieldtree("navigation")
  filter_basic_qry <- field_qry %>%
    Rems::filter("'takeoff valid' == TRUE") %>%
    Rems::filter("'landing valid' == TRUE")
  return(filter_basic_qry)
}
