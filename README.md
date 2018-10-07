<!-- README.md is generated from README.Rmd. Please edit that file -->
MSgraphr
========

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
    -   Set as a `web` app
    -   Note the client ID and client secret
    -   Specify the scope for which you wish to grant access, `msgraphr`
        expects `User` and `Sites.Read`
-   Set `MSGRAPH_PAT` to a location for saving the Oauth2.0 token.

-   Invoke `msgraph_auth()` to perform the initial Oauth2.0
    authentication.

Usage
-----

Full docs are coming…

``` r
library(tidyverse)
library(msgraphr)

# list all the sites to which you have accesss
get_sites() %>% head(1) %>% pull(site_id) -> my_site

# list all the lists on that site
get_lists(site_id = my_site) %>% head(1) %>% pull(list_id) -> my_list

# fetch all the entries on that list
get_list_entries(site_id = my_site, list_id = my_list)

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
