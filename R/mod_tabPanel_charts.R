#' UI Charts TabPanel
#' 
#' @param id The namespace identifier.
#' @noRd
#' 
mod_tabPanel_charts_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::tabPanel(
    title = "Charts",
    row_chart_cum_UI(ns("ns_chart_cum")),
    shiny::hr(),
    row_chart_raw_UI(ns("ns_chart_raw"))
  )
  
}
  
#' Server Charts TabPanel
#' 
#' @param id The namespace identifier.
#' @param tbl_combined The combined tables.
#' @noRd
#' 
mod_tabPanel_charts_server <- function(id, tbl_combined) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      tbl_cum <-
        shiny::reactive(
          tbl_combined() %>%
            dplyr::select(
              flight_date,
              flight_name,
              flight_number,
              success,
              upcoming,
              flight_year,
              launchpad_name,
              region,
              rocket_name
            )
        )
      
      output$ns_chart_cum <-
        row_chart_cum_Server("ns_chart_cum", tbl_cum)
      
      tbl_raw <-
        shiny::reactive(
          tbl_combined() %>%
            dplyr::mutate(
              engine_number = as.character(engine_number),
              flight_year = as.character(flight_year),
              success =
                dplyr::case_when(
                  is.na(success) ~ "upcoming",
                  !success ~ "failure",
                  TRUE ~ "success"
                )
            ) %>%
            dplyr::select(
              success,
              upcoming,
              crewed,
              engine_layout,
              engine_number,
              flight_year,
              launchpad_name,
              locality,
              region,
              rocket_name
            )
        )
      
      output$ns_chart_raw <-
        row_chart_raw_Server("ns_chart_raw", tbl_raw)
      
    }
  )
 
}
