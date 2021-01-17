#' UI Sidebar
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_sidebar_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  bs4Dash::bs4DashSidebar(
    inputId = ns("sidebar_container"),
    skin = "dark",
    brandColor = "black",
    title = "SpaceX Analysis",
    src = "/www/favicon.png",
    opacity = 1,
    bs4Dash::bs4SidebarMenu(
      id = ns("sidebar"),
      compact = TRUE,
      bs4Dash::bs4SidebarMenuItem(
        "Charts Cumulative",
        tabName = "tab_charts_cum",
        icon = "chart-line"
      ),
      bs4Dash::bs4SidebarMenuItem(
        "Charts Raw",
        tabName = "tab_charts_raw",
        icon = "chart-bar"
      ),
      bs4Dash::bs4SidebarMenuItem(
        "Data",
        tabName = "tab_data",
        icon = "table"
      ),
      bs4Dash::bs4SidebarMenuItem(
        "About",
        tabName = "tab_about",
        icon = "info"
      )
    )
  )
  
}
