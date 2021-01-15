#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}.
#' @noRd
#' 
app_server <- function(input, output, session) {
  
  if (golem::app_prod()) {
    datasets <- get_data()
  } else {
    datasets <- golem::get_golem_options("data")
  }
  
  mod_tabPanel_charts_server("chart", datasets$tbl_combined)
  mod_tabPanel_data_server("data", datasets$lst_tbls)
  mod_tabPanel_about_server("about", datasets$lst_company)

}
