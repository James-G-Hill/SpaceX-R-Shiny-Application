#' UI Card Address
#' 
#' @param id The namespace identifier.
#' @noRd
#' 
mod_card_address_ui <- function(id) {
  
  ns <- NS(id)
  
  shiny::uiOutput(ns("address"))
  
}

#' Server Card Address
#'
#' @param id The namespace identifier.
#' @param company Data about the company.
#' @noRd
#' 
mod_card_address_server <- function(id, company) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      output$address <-
        shiny::renderUI(
          bs4Dash::bs4Card(
            width = 12,
            title = "HQ",
            shiny::p(
              stringr::str_c(
                "Street",
                company$headquarters$address,
                sep = " : "
              )
            ),
            shiny::p(
              stringr::str_c(
                "City",
                company$headquarters$city,
                sep = " : "
              )
            ),
            shiny::p(
              stringr::str_c(
                "State",
                company$headquarters$state,
                sep = " : "
              )
            )
          )
        )
      
    }
  )
  
}
