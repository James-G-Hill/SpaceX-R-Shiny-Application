#' UI Card Links
#' 
#' @param id The namespace identifier.
#' @noRd
#' 
mod_card_links_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::uiOutput(ns("links"))
  
}

#' Server Card Links
#'
#' @param id The namespace identifier.
#' @param company Data about the company.
#' @noRd
#' 
mod_card_links_server <- function(id, company) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      output$links <-
        shiny::renderUI(
          bs4Dash::bs4Card(
            width = 12,
            title = "Links",
            shiny::a(href = company$links$website, "SpaceX"),
            shiny::br(),
            shiny::a(href = company$links$flickr, "Flickr"),
            shiny::br(),
            shiny::a(href = company$links$twitter, "Twitter"),
            shiny::br(),
            shiny::a(href = company$links$elon_twitter, "Elon Musk Twitter")
          )
        )
    
    }
  )
  
}
