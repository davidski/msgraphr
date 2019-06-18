#' Perform the OAuth 2.0 dance with MS Graph
#'
#' @return A `httr` oauth token object
#'
#' @param client_id Application Id from MS Graph
#' @param client_secret Application password from MS Graph
#' @export
#' @importFrom httr oauth_endpoint oauth2.0_token oauth_app
#'
#' @examples
#' NULL
msgraph_auth <- function(client_id, client_secret) {
  app_name <- 'Rstats Queries' # not important for authorization grant flow

  # API resource ID to request access for, e.g. MS Graph
  resource_uri <- 'https://graph.microsoft.com'

  # Scopes to authorize
  scopes <- c("User.Read", "Sites.Read.All", "offline_access")

  msgraph_endpoint <- httr::oauth_endpoint(base_url = "https://login.microsoftonline.com/common",
                                           authorize = "oauth2/v2.0/authorize",
                                           access    = "oauth2/v2.0/token")

  # Create the app instance
  myapp <- httr::oauth_app(appname = app_name,
                           key = client_id,
                           secret = client_secret)

  msgraph_token <- httr::oauth2.0_token(msgraph_endpoint, myapp,
                                        scope = scopes,
                                        cache = msgraph_token(),
                                        #user_params = list(resource = resource_uri),
                                        use_oob = FALSE)
  if (('error' %in% names(msgraph_token$credentials)) &&
      (nchar(msgraph_token$credentials$error) > 0)) {
    errorMsg <- paste(
      'Error while acquiring token.',
      paste('Error message:', msgraph_token$credentials$error),
      paste(
        'Error description:',
        msgraph_token$credentials$error_description
      ),
      paste('Error code:', msgraph_token$credentials$error_codes),
      sep = '\n'
    )
    stop(errorMsg)
  }

  # Resource API can be accessed through "msgraph_token" at this point.
  msgraph_token
}
