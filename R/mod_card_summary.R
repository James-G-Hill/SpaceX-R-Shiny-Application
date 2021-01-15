#' UI Card Summary
#' 
#' @param id The namespace identifier.
#' @noRd
#' 
mod_card_summary_ui <- function(id) {
  
  ns <- NS(id)
  
  shiny::uiOutput(ns("summary"))

}

#' Server Card Summary
#'
#' @param id The namespace identifier.
#' @param summary A summary of the company.
#' @noRd
#' 
mod_card_summary_server <- function(id, summary) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {

      output$summary <-
        shiny::renderUI(
          bs4Dash::bs4Card(
            width = 12,
            title = "Mission Statement",
            summary
          )
        )
    
    }
  )
  
}
