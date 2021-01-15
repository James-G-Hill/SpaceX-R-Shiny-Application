#' UI Card Staff
#' 
#' @param id The namespace identifier.
#' @noRd
#' 
mod_card_staff_ui <- function(id) {
  
  ns <- NS(id)
  
  shiny::uiOutput(ns("staff"))
  
}

#' Server Card Staff
#'
#' @param id The namespace identifier.
#' @param company Data about the company.
#' @noRd
#' 
mod_card_staff_server <- function(id, company) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
    
    output$staff <-
      shiny::renderUI(
        bs4Dash::bs4Card(
          width = 12,
          title = "Staff",
          shiny::p(
            stringr::str_c("Founder", company$founder, sep = " : ")
          ),
          shiny::p(
            stringr::str_c("CEO", company$ceo, sep = " : ")
          ),
          shiny::p(
            stringr::str_c("CTO", company$cto, sep = " : ")
          ),
          shiny::p(
            stringr::str_c("COO", company$coo, sep = " : ")
          ),
          shiny::p(
            stringr::str_c(
              "CTO Propulsion",
              company$cto_propulsion,
              sep = " : "
            )
          )
        )
      )
    
    }
  )
  
}
