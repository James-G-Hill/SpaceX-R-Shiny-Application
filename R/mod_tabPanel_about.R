#' UI TabPanel About
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_tabPanel_about_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  bs4Dash::tabItem(
    tabName = "tab_about",
    shiny::fluidRow(
      shiny::column(
        6,
        mod_card_summary_ui(ns("summary")),
        mod_card_staff_ui(ns("staff")),
      ),
      shiny::column(
        6,
        mod_card_links_ui(ns("links")),
        mod_card_address_ui(ns("address"))
      )
    )
  )
  
}

#' Server TabPanel About
#' 
#' @param id The namespace identifier.
#' @param lst_company Companies.
#' @noRd 
#' 
mod_tabPanel_about_server <- function(id, lst_company) {

  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      mod_card_summary_server("summary", lst_company$summary)
      mod_card_staff_server("staff", lst_company)
      mod_card_links_server("links", lst_company)
      mod_card_address_server("address", lst_company)
      
    }
  )
 
}
