# Variables --------------------------------------------------------------------

ns_chart_cum <- "ns_chart_cum"
# ns_chart_raw <- "ns_chart_raw"

# Functions --------------------------------------------------------------------

charts_UI <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::tabPanel(
    title = "Charts",
    row_chart_cum_UI(ns(ns_chart_cum)),
    shiny::hr()
  )
  
}

charts_Server <- function(id, tbl_combined) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      tbl_cum <-
        shiny::reactive(
          {
            tbl_combined() %>%
              dplyr::select(
                flight_date,
                success,
                upcoming,
                flight_year,
                launchpad_name,
                rocket_name
              )
          }
        )
      
      output$ns_chart_cum <-
        row_chart_cum_Server(ns_chart_cum, tbl_cum)
      
      tbl_raw <-
        shiny::reactive(
          {
            tbl_combined() %>%
              dplyr::select(
                success,
                upcoming,
                crewed,
                engine_layout,
                engine_number,
                engine_type,
                flight_year,
                launchpad_name,
                locality,
                region,
                rocket_name
              )
          }
        )
      
    }
  )
  
}
