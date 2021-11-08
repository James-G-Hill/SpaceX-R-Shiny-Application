#' UI Sidebar
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_sidebar_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  bs4Dash::dashboardSidebar(
    id = ns("sidebar_container"),
    minified = FALSE,
    elevation = 1,
    bs4Dash::sidebarMenu(
      id = ns("sidebar"),
      compact = TRUE,
      bs4Dash::menuItem(
        text = "Charts Cumulative",
        tabName = "tab_charts_cum",
        icon = shiny::icon("chart-line")
      ),
      bs4Dash::menuItem(
        text = "Charts Raw",
        tabName = "tab_charts_raw",
        icon = shiny::icon("chart-bar")
      ),
      bs4Dash::menuItem(
        text = "Data",
        tabName = "tab_data",
        icon = shiny::icon("table")
      ),
      bs4Dash::menuItem(
        text = "About",
        tabName = "tab_about",
        icon = shiny::icon("info")
      )
    )
  )
  
}
