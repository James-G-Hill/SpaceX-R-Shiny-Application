# Variables --------------------------------------------------------------------

url_base <- "https://api.spacexdata.com/v4"

url_company <- glue::glue("{url_base}/company")

# Functions --------------------------------------------------------------------

#' GET data from the SpaceX API
#' 
#' @param url The url of the api.
#' @return An R object containing the data.
#' 
get_api_data <- function(url) {
  
  jsonlite::fromJSON(url)
  
}

#' GET 'company' data from the SpaceX API
#' 
#' @return A list of the 'company' data points.
#' 
get_api_company <- function() {
  
  get_api_data(url_company)
  
}
