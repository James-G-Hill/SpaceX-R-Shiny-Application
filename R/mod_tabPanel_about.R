#' UI TabPanel About
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_tabPanel_about_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::tabPanel(
    title = "About",
    shiny::htmlOutput(
      style =
        glue::glue(
          "
          width: 35%;
          text-align: center;
          align: center;
          margin-left: auto;
          margin-right: auto;
          "
        ),
      ns("ns_about")
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
      
      output$ns_about <-
        shiny::renderUI(
          shiny::tagList(
            shiny::h1(lst_company$name),
            shiny::br(),
            shiny::p(lst_company$summary),
            shiny::hr(),
            tags_staff(lst_company),
            shiny::hr(),
            tags_links(lst_company),
            shiny::hr(),
            tags_address(lst_company)
          )
        )
      
    }
  )
 
}
