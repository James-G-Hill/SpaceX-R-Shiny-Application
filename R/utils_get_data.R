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
  
  url_base <- "https://api.spacexdata.com/v4"
  url_company <- glue::glue("{url_base}/company")
  
  get_api_data(url_company)
  
}

#' GET 'launches' data from the SpaceX API
#' 
#' @return A list of the 'launches' data points.
#' 
get_api_launches <- function() {
  
  url_base <- "https://api.spacexdata.com/v4"
  url_launches <- glue::glue("{url_base}/launches")
  
  get_api_data(url_launches) %>%
    dplyr::mutate(
      crewed = purrr::map(crew, length) > 0,
      flight_date = as.Date(date_utc),
      flight_year = lubridate::year(flight_date),
      failures = as.character(failures)
    ) %>%
    dplyr::select(
      flight_number,
      flight_name = name,
      flight_date,
      flight_year,
      upcoming,
      success,
      failures,
      crewed,
      details,
      id_rocket = rocket,
      id_launchpad = launchpad
    )
  
}

#' GET 'launchpads' data from the SpaceX API
#' 
#' @return A list of the 'launchpads' data points.
#' 
get_api_launchpads <- function() {
  
  url_base <- "https://api.spacexdata.com/v4"
  url_launchpads <- glue::glue("{url_base}/launchpads")
  
  get_api_data(url_launchpads) %>%
    dplyr::select(
      id_launchpad = id,
      launchpad_name = name,
      launchpad_full_name = full_name,
      locality,
      region,
      timezone,
      latitude,
      longitude
    )
  
}

#' GET 'rockets' data from the SpaceX API
#' 
#' @return A list of the 'rockets' data points.
#' 
get_api_rockets <- function() {
  
  url_base <- "https://api.spacexdata.com/v4"
  url_rockets <- glue::glue("{url_base}/rockets")
  
  get_api_data(url_rockets) %>%
    dplyr::mutate(
      engine_number = engines$number,
      engine_type = engines$type,
      engine_layout = engines$layout,
      height_m = height$meters,
      diameter_m = diameter$meters,
      mass_kg = mass$kg
    ) %>%
    dplyr::select(
      id_rocket = id,
      rocket_name = name,
      rocket_desc = description,
      engine_number,
      engine_type,
      engine_layout,
      height_m,
      diameter_m,
      mass_kg
    )
  
}
