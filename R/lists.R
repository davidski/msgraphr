#' Fetch all the lists on a SharePoint site
#'
#' @param site_id Site ID
#' @param token httr auth token
#'
#' @return A somewhat messy list structure :(
#' @export
#'
#' @importFrom glue glue
#'
#' @examples
#' NULL
get_lists <- function(site_id, token) {
  msgraph_api(glue::glue("sites/{site_id}/lists"), token) -> all_lists
  all_lists$content$value
}

#' Fetch the items in a given list
#'
#' @param site_id Site ID from `get_sites()`
#' @param list_id List ID from `get_lists()`
#' @param token httr oauth token
#'
#' @return A tibble
#' @export
#'
#' @importFrom janitor clean_names
#' @importFrom glue glue
#'
#' @examples
#' NULL
get_list_entries <- function(site_id, list_id, token) {
  msgraph_api(glue::glue("sites/{site_id}/lists/{list_id}/items"), query = list("expand" = "fields"), token) -> list_items
  list_items$content$value$fields %>%
    janitor::clean_names() -> list_entries
  names(list_entries) <- names(list_entries) %>%
    gsub(pattern = "_x0020", replacement = "", fixed = TRUE)
  list_entries
}
