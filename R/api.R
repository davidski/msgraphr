default_api_version <- function() {"v1.0"} # default to the current production version

msgraph_url <- function(api_version = "v1.0") {
  paste0("https://graph.microsoft.com/", api_version)
}

#' Find the location of the OAuth token cache
#'
#' @return Path to the on-disk OAuth cache
msgraph_token <- function() {
  token <- Sys.getenv('MSGRAPH_PAT', "")
  if (token == "") {
    token <- ".msgraphr_token.rds"
    warning("Defaulting to the current working directory for saving the OAuth token. Set the MSGRAPH_PAT envirornment variable to a file location to override.", .call = FALSE)
  }
  token
}

msgraph_read_token <- function(token_location = msgraph_token()) {
  if (!file.exists(token_location)) stop("Unable to find the MSGRAPH OAuth token on disk.", .call = FALSE)
  readRDS(token_location)
}

#' Execute a GET request against the MS Graph API
#'
#' Calls bare API end points and returns a wrapped `httr` response object
#' to a higher level function for presentation.
#'
#' @param path API endpoint to retrieve
#' @param msgraph_token Oauth2 token as returned from `httr::oauth2_token()`
#' @param query Named list of parameters to use as the URL query
#' @param api_version Version of the Graph API to call
#'
#' @return A msgraph_api object
#' @export
#'
#' @importFrom httr modify_url GET http_type accept_json authenticate content
#' @importFrom jsonlite fromJSON
#'
#' @examples
#' NULL
msgraph_api <- function(path, msgraph_token, query = NULL, api_version = default_api_version()) {
  path <- c(api_version, path)
  url <- httr::modify_url(msgraph_url(), path = path, query = query)
  resp <- httr::GET(url, httr::accept_json(), config = httr::config(token = msgraph_token))
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = TRUE)

  structure(
    list(
      content = parsed,
      path = paste0(path, collaspe = "/"),
      response = resp
    ),
    class = "msgraph_api"
  )
}

print.msgraph_api <- function(x, ...) {
  cat("<MSGRAPH ", x$path, ">\n", sep = "")
  utils::str(x$content)
  invisible(x)
}
