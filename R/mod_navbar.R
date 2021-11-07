#' UI Navbar
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_navbar_ui <- function(id) {
  
  bs4Dash::dashboardHeader(
    title =
      bs4Dash::dashboardBrand(
        title = "SpaceX",
        color = "primary"
      ),
    compact = TRUE,
    border = FALSE
  )

}
