#' UI Charts TabPanel
#' 
#' @param id The namespace identifier.
#' @noRd
#' 
mod_tabPanel_charts_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  bs4Dash::bs4TabItem(
    tabName = "tab_charts",
    mod_chart_cumulative_ui(ns("ns_chart_cum")),
    shiny::hr(),
    mod_chart_raw_ui(ns("ns_chart_raw"))
  )

}
  
#' Server Charts TabPanel
#' 
#' @param id The namespace identifier.
#' @param tbl_combined The combined tables.
#' @noRd
#' @importFrom dplyr .data
#' 
mod_tabPanel_charts_server <- function(id, tbl_combined) {
  
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
      
      tbl_raw <-
        shiny::reactive(
          tbl_combined %>%
            dplyr::mutate(
              engine_number = as.character(.data$engine_number),
              flight_year = as.character(.data$flight_year),
              success =
                dplyr::case_when(
                  is.na(.data$success) ~ "upcoming",
                  !.data$success ~ "failure",
                  TRUE ~ "success"
                )
            ) %>%
            dplyr::select(
              .data$success,
              .data$upcoming,
              .data$crewed,
              .data$engine_layout,
              .data$engine_number,
              .data$flight_year,
              .data$launchpad_name,
              .data$locality,
              .data$region,
              .data$rocket_name
            )
        )
      
      output$ns_chart_raw <-
        mod_chart_raw_server("ns_chart_raw", tbl_raw)
      
    }
  )
 
}
