<!-- README.md is generated from README.Rmd. Please edit that file -->

msgraphr
========

> NOTE: This package is quite raw. I am not currently using Office 365
> and cannot develop or debug features apart from the general MS Graph
> interface. Pull Requests are **most** welcome!

**msgraphr** is a minimal R wrapper of the SharePoint Online (Office
365) APIs, aiming to allow R users to pull down list information as
dataframes for local analysis. Liberate your data from SharePoint!

Installation
------------

`devtools::install_github("davidski/msgraphr")`

Authentication
--------------

-   Create an application at
    <a href="https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade" class="uri">https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade</a>
    with the following fields:

-   `Name` Name of your MS Graph app e.g. `msgraphr_query`.

-   Under `Redirect URIs` at a web link pointing to
    `http://localhost:1410`.

-   Take note of the `Application Id`, this will be your `client_id`.

-   Under `Certificates & Secrets` generate an application secret and
    note the value for use as the `Client Secret`.

-   Add a Platform and select `Web`.

    -   `Allow Implicit Flow`: Unchecked

-   Under API Permissions, alter the Microsoft Graph permissions to
    specify the scopes for which you wish to grant access.

-   (OPTIONAL, BUT RECOMMENDED) Set the `MSGRAPH_PAT` environment
    variable to a file location on disk for `msgraphr` to cache the
    Oauth2.0 token. Defaults to the current working directory.

-   To perform the initial authentication.

        msgraph_auth(client_id = "REDACTED", 
                     client_secret = "REDACTED" )

### Scope used

-   `msgraphr` requests the following access scopes:
    -   `User` and `Sites.Read.All` for SharePoint online read access
    -   `offline_user` so that tokens may be auto-refreshed without
        further user action

Usage
-----

``` r
library(tidyverse)
library(msgraphr)

# auth
token <- msgraph_auth()

# list all the sites to which you have accesss
get_sites(search = "", token) %>% head(1) %>% pull(id) -> my_site

# list all the lists on that site
get_lists(site_id = my_site, token) %>% head(1) %>% pull(id) -> my_list

# fetch all the entries on that list
get_list_entries(site_id = my_site, list_id = my_list, token)

# go forth and do amazing things!
```

References
----------

See the [MS
Graph](https://developer.microsoft.com/en-us/graph/docs/concepts/overview)
API documentation.

Contributing
------------

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.

License
-------

The [MIT License](LICENSE) applies.
