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
  
  mod_dashBody_server("dashbody", datasets)

}
