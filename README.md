<!-- README.md is generated from README.Rmd. Please edit that file -->
msgraphr
========

> NOTE: This package is super raw. It’s a shell of some functions that
> work for an immediate need of mine but needs a good bit of polishing.
> `msgraphr` is posted for public consumption in the hope that it may be
> of use to some as I’m time-blocked on putting much effort into this
> right now. PRs o polish the package are **most** welcome.

**msgraphr** is a minimal R wrapper of the SharePoint Online (Office
365) APIs, aiming to allow R users to pull down list information as
dataframes for local analysis. Liberate your data from SharePoint!

Installation
------------

`devtools::install_github("davidski/msgraphr")`

Authentication
--------------

-   Create an application at
    <a href="https://apps.dev.microsoft.com" class="uri">https://apps.dev.microsoft.com</a>
    with the following fields:
    -   `Name` Name of your MS Graph app e.g. `msgraphr_query`
    -   Take note of the `Application Id`, this will be your `client_id`
    -   Generate an application secret and note the value as the
        `Client Secret`
    -   Add a Platform and select `Web`.
        -   `Allow Implicit Flow`: Unchecked
        -   `Redirect URLs`: `http://localhost:1410`
    -   Under Microsoft Graph Permissions specify the scope for which
        you wish to grant access
-   Set `MSGRAPH_PAT` to a location for saving the Oauth2.0 token.

-   To perform the initial authentication.

        msgraph_auth(client_id = "REDACTED", 
                     client_secret = "REDACTED" )

### Scope used

-   `msgraphr` requests the following access scopes:
    -   `User` and `Sites.Read.All` for SharePoint online read acees
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
get_sites(search = "", token) %>% head(1) %>% pull(site_id) -> my_site

# list all the lists on that site
get_lists(site_id = my_site, token) %>% head(1) %>% pull(list_id) -> my_list

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
