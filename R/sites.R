#' Fetch a tibble of SharePoint sites
#'
#' @param searchquery Optional search
#' @param token httr oauth token
#'
#' @return A tibble
#' @export
#'
#' @importFrom dplyr select
#' @importFrom rlang .data
#'
#' @examples
#' NULL
get_sites <- function(searchquery = NULL, token = msgraph_read_token()) {
  if (!is.null(searchquery)) searchquery <- list("search" = searchquery)
  site_resp <- msgraph_api("sites", query = searchquery, token)
  site_resp$content$value %>% dplyr::select(-.data$root)
}
