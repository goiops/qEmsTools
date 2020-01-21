#' emsMultifilter
#'
#' Apply multiple filters in one function call as a vector.
#'
#' Usually you have to make multiple function calls to apply multiple filters - this simplifies that.
#' @export
#' @import Rems
#' @importFrom rstudioapi askForPassword
#' @param qry a FltQuery object
#' @param filter_vector a string vector of filter statements of the form c("'Dimension' == 'Value',...)
#' @examples
#' \dontrun{
#' filter_vector <- c("'Fleet' == 'A380'", "'Flight Date (Exact)' == '2019-01-01'")
#' filtered_qry <- emsMultifilter(qry, filter_vector)
#' }
#' @return
#' This function returns a FltQuery object with all of the filters in filter_vector applied to it.
#' @author Matt Simmons mattsimmons@qantas.com.au
#'

emsMultifilter <- function(qry, filter_vector) {
  for (k in 1:length(filter_vector)) {
    filter_item <- filter_vector[k]
    qry <- Rems::filter(qry, filter_item)
  }
  return(qry)
}
