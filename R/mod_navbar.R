#' UI Navbar
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_navbar_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  bs4Dash::bs4DashNavbar(
    skin = "dark",
    compact = TRUE
  )

}
