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

  glue::glue("{get_golem_config('url_base')}/company") |>
    get_api_data()
  
}

#' GET 'launches' data from the SpaceX API
#' 
#' @return A list of the 'launches' data points.
#' @importFrom dplyr .data
#' 
get_api_launches <- function() {

  glue::glue("{get_golem_config('url_base')}/launches") |>
    get_api_data() |>
    dplyr::mutate(
      crewed = purrr::map(.data$crew, length) > 0,
      flight_date = as.Date(.data$date_utc),
      flight_year = lubridate::year(.data$flight_date),
      failures = as.character(.data$failures)
    ) |>
    dplyr::select(
      .data$flight_number,
      flight_name = .data$name,
      .data$flight_date,
      .data$flight_year,
      .data$upcoming,
      .data$success,
      .data$failures,
      .data$crewed,
      .data$details,
      id_rocket = .data$rocket,
      id_launchpad = .data$launchpad
    )
  
}

#' GET 'launchpads' data from the SpaceX API
#' 
#' @return A list of the 'launchpads' data points.
#' @importFrom dplyr .data
#' 
get_api_launchpads <- function() {
  
  glue::glue("{get_golem_config('url_base')}/launchpads") |>
    get_api_data() |>
    dplyr::select(
      id_launchpad = .data$id,
      launchpad_name = .data$name,
      launchpad_full_name = .data$full_name,
      .data$locality,
      .data$region,
      .data$timezone,
      .data$latitude,
      .data$longitude
    )
  
}

#' GET 'rockets' data from the SpaceX API
#' 
#' @return A list of the 'rockets' data points.
#' @importFrom dplyr .data
#' 
get_api_rockets <- function() {
  
  glue::glue("{get_golem_config('url_base')}/rockets") |>
    get_api_data() |>
    dplyr::mutate(
      engine_number = .data$engines$number,
      engine_type = .data$engines$type,
      engine_layout = .data$engines$layout,
      height_m = .data$height$meters,
      diameter_m = .data$diameter$meters,
      mass_kg = .data$mass$kg
    ) |>
    dplyr::select(
      id_rocket = .data$id,
      rocket_name = .data$name,
      rocket_desc = .data$description,
      .data$engine_number,
      .data$engine_type,
      .data$engine_layout,
      .data$height_m,
      .data$diameter_m,
      .data$mass_kg
    )
  
}
