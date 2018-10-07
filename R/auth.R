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
  # 1. Register an app in MS Graph as a "Web app", setting the
  #    redirect URI <http://localhost:1410/>.
  # 2. Insert the App name:
  app_name <- 'Rstats Queries' # not important for authorization grant flow
  # 3. Insert the created apps client ID which was issued after app creation:


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

  # Step through the authorization chain:
  #    1. You will be redirected to you authorization endpoint via web browser.
  #    2. Once you responded to the request, the endpoint will redirect you to
  #       the local address specified by httr.
  #    3. httr will acquire the authorization code (or error) from the data
  #       posted to the redirect URI.
  #    4. If a code was acquired, httr will contact your authorized token access
  #       endpoint to obtain the token.
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
