# Variables --------------------------------------------------------------------

ns_button <- "ns_button"
ns_radio <- "ns_radio"

# Functions --------------------------------------------------------------------

data_UI <- function(id) {
  
  ns <- shiny::NS(id)
  
  radio_col_width <- 6
  
  shiny::tabPanel(
    title = "Data",
    shiny::fluidRow(
      shiny::column(
        radio_col_width,
        shiny::radioButtons(
          ns(ns_radio),
          "Tables",
          choices = c(
            "Launches",
            "Launchpads",
            "Rockets"
          ),
          inline = TRUE
        )
      ),
      shiny::column(
        column_width - radio_col_width,
        shiny::downloadButton(ns(ns_button))
      )
    ),
    shiny::hr(),
    shiny::fluidRow()
  )
  
}

data_Server <- function(id, lst_tbls) {
  
  shiny::moduleServer(
    id,
    function(input, output, server) {
      
    }
  )
    
}