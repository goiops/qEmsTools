#' optional_generate_preset_fieldtree
#'
#' wrapper for generate_preset_fieldtree that optionally tries to load from a local db if present.
#'
#' Ideally you'd only ever have to do this once, but not have to write two kinds of code, this is an attempt at that.
#' @export
#' @param qry a Flt_Qry object
#' @param data_file an optional .db file to read the tree in, if present
#' @param full a boolean to force the preset fieldtree to reload anyway
#' @examples
#' \dontrun{
#' con <- getEMSCon("joe.smith")
#' data_file <- "mydb.db"
#' qry <- flt_query(conn = con, ems_name = "my-ems", data_file = data_file) %>%
#' Rems::set_database("FDW Flights") %>%
#' optional_generate_preset_fieldtree(data_file = data_file, full = FALSE)
#' }
#' @return
#' Returns a fltqry object with a fieldtree loaded
#' @author Matt Simmons mattsimmons@qantas.com.au
#'
#'
#'

optional_generate_preset_fieldtree <- function(qry, data_file = NA, full = FALSE) {
if (is.na(data_file) | full | !file.exists(data_file)) {
  return(Rems::generate_preset_fieldtree(qry))
} else {
  return(Rems::load_metadata(qry, file_name = data_file))
}
}
