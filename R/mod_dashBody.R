#' UI dashBody
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_dashBody_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  bs4Dash::bs4DashBody(
    bs4Dash::bs4TabItems(
      mod_tabPanel_charts_ui("chart"),
      mod_tabPanel_data_ui("data"),
      mod_tabPanel_about_ui("about")
    )
  )
  
}
    
#' Server dashBody
#'
#' @param id The namespace identifier.
#' @param datasets The datasets as a list.
#' @noRd
#' 
mod_dashBody_server <- function(id, datasets) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
    
      mod_tabPanel_charts_server("chart", datasets$tbl_combined)
      mod_tabPanel_data_server("data", datasets$lst_tbls)
      mod_tabPanel_about_server("about", datasets$lst_company)
   
    }
  )
  
}
