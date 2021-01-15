#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}.
#' @import shiny
#' @noRd
#' 
app_server <- function(input, output, session) {
  
  ms_per_s <- 1000 # milliseconds per second
  s_per_m <- 60 # seconds per minutes
  m_per_h <- 60 # minutes per hour
  
  timer <- shiny::reactiveTimer(m_per_h * s_per_m * ms_per_s)
  
  # Tables
  
  lst_company <-
    shiny::reactive(
      {
        timer()
        get_api_company()
      }
    )
  
  tbl_launches <-
    shiny::reactive(
      {
        timer()
        get_api_launches()
      }
    )
  
  tbl_launchpads <-
    shiny::reactive(
      {
        timer()
        get_api_launchpads()
      }
    )
  
  tbl_rockets <-
    shiny::reactive(
      {
        timer()
        get_api_rockets()
      }
    )
  
  tbl_combined <-
    shiny::reactive(
      tbl_launches() %>%
        dplyr::left_join(
          tbl_launchpads(),
          by = c("id_launchpad" = "id_launchpad")
        ) %>%
        dplyr::left_join(
          tbl_rockets(),
          by = c("id_rocket" = "id_rocket")
        )
    )
  
  lst_tbls <- shiny::reactiveValues()
  
  lst_tbls$launches <- tbl_launches
  lst_tbls$launchpads <- tbl_launchpads
  lst_tbls$rockets <- tbl_rockets
  
  # Servers
  charts_Server(ns_chart, tbl_combined)
  data_Server(ns_data, lst_tbls)
  about_Server(ns_about, lst_company)

}
