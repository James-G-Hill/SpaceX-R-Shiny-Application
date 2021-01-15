#' UI Charts TabPanel Cumulative
#' 
#' @param id The namespace identifier.
#' @noRd
#' 
mod_tabPanel_charts_cum_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  bs4Dash::bs4TabItem(
    tabName = "tab_charts_cum",
    mod_chart_cumulative_ui(ns("ns_chart_cum"))
  )
  
}

#' Server Charts TabPanel Cumulative
#' 
#' @param id The namespace identifier.
#' @param tbl_combined The combined tables.
#' @noRd
#' @importFrom dplyr .data
#' 
mod_tabPanel_charts_cum_server <- function(id, tbl_combined) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      tbl_cum <-
        shiny::reactive(
          tbl_combined %>%
            dplyr::select(
              .data$flight_date,
              .data$flight_name,
              .data$flight_number,
              .data$success,
              .data$upcoming,
              .data$flight_year,
              .data$launchpad_name,
              .data$region,
              .data$rocket_name
            )
        )
      
      output$ns_chart_cum <-
        mod_chart_cumulative_server("ns_chart_cum", tbl_cum)
      
    }
  )
  
}
