#' UI dashBody
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_dashBody_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  bs4Dash::dashboardBody(
    bs4Dash::tabItems(
      mod_tabPanel_charts_cum_ui(ns("chart_cum")),
      mod_tabPanel_charts_raw_ui(ns("chart_raw")),
      mod_tabPanel_data_ui(ns("data")),
      mod_tabPanel_about_ui(ns("about"))
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
    
      mod_tabPanel_charts_cum_server("chart_cum", datasets$tbl_combined)
      mod_tabPanel_charts_raw_server("chart_raw", datasets$tbl_combined)
      mod_tabPanel_data_server("data", datasets$lst_tbls)
      mod_tabPanel_about_server("about", datasets$lst_company)
   
    }
  )
  
}
