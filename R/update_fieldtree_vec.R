#' Update Fieldtree (Vectorized)
#'
#' Rems::update_fieldtree, but takes tree as vector, instead of arguments
#'
#' Rems::update_fieldtree takes the tree positions as arguments, which is more intuitive but annoying
#' when you want to reuse a tree multiple times. This wraps the function and takes a string vector instead.
#'
#' @export
#' @importFrom Rems update_fieldtree
#' @importFrom rlang call2 `!!!`
#' @param qry a Rems fltqry object, to be updated with an extended fieldtree
#' @param tree a string vector, where each string is the parent folder name. Partial matching is supported.
#' @param exclude_tree whatever exclude_tree does??
#' @examples
#' \dontrun{
#' base_tree <- c("profiles", "standard", "p1")
#' qry2 <- update_fieldtree_vec(qry, c(base_tree, "processing"), exclude_tree = c())
#' }
#' @return
#' This function returns an updated fltqry object.
#' @author Matt Simmons mattsimmons@qantas.com.au
#'
#'

update_fieldtree_vec <- function(qry, tree, exclude_tree = c()) {
  args <- list(qry = qry, exclude_tree = exclude_tree)
  fieldtree_call <- rlang::call2("update_fieldtree", tree, !!!args, .ns = "Rems")
  return(eval(fieldtree_call))
}
