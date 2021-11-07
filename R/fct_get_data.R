#' Get the data from the API
#' 
#' @return A list of the datasets.
#' 
get_data <- function() {
  
  datasets <- list()
  
  datasets$lst_company <- get_api_company()
  
  tbl_launches <- get_api_launches()
  
  tbl_launchpads <- get_api_launchpads()
  
  tbl_rockets <- get_api_rockets()
  
  datasets$tbl_combined <-
    tbl_launches |>
      dplyr::left_join(
        tbl_launchpads,
        by = c("id_launchpad" = "id_launchpad")
      ) |>
      dplyr::left_join(
        tbl_rockets,
        by = c("id_rocket" = "id_rocket")
      )
  
  datasets$lst_tbls <- list()
  
  datasets$lst_tbls$launches <- tbl_launches
  datasets$lst_tbls$launchpads <- tbl_launchpads
  datasets$lst_tbls$rockets <- tbl_rockets
  
  return(datasets)
  
}
