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
    title = "SpaceX",
    src = "www/logo.svg",
    opacity = 1,
    bs4Dash::bs4SidebarMenu(
      id = ns("sidebar"),
      compact = TRUE,
      bs4Dash::bs4SidebarMenuItem(
        "Charts",
        tabName = "tab_charts",
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
