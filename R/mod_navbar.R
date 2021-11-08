#' UI Navbar
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_navbar_ui <- function(id) {
  
  brand <-
    shiny::tags$a(
      class = "brand-link",
      href = "#",
      shiny::tags$img(
        src = file.path("www", "favicon.png"),
        class = "brand-image",
        style = htmltools::css(opacity = 1)
      ),
      shiny::tags$span(
        "SpaceX",
        class = "brand-text font-weight-light",
        style = htmltools::css(color = "black")
      )
    )
  
  bs4Dash::dashboardHeader(
    title = brand,
    compact = TRUE,
    border = FALSE
  )

}
