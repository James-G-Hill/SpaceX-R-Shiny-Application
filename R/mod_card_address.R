#' UI Card Address
#' 
#' @param id The namespace identifier.
#' @noRd
#' 
mod_card_address_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
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
          bs4Dash::box(
            width = 12,
            title = "HQ",
            collapsible = FALSE,
            closable = FALSE,
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
