# Variables --------------------------------------------------------------------

ns_chart_cum <- "ns_chart_cum"
ns_chart_raw <- "ns_chart_raw"

# Functions --------------------------------------------------------------------

charts_UI <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::tabPanel(
    title = "Charts"
  )
  
}

charts_Server <- function(id) {
  
  shiny::moduleServer(
    id,
    function(input, output, server) {
      
    }
  )
  
}
