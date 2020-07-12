# Sources ----------------------------------------------------------------------

source(file = file.path("R", "utils_get_data.R"), local = TRUE)

# Function ---------------------------------------------------------------------

server <- function(input, output) {
  
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
  
  lst_tbls <- reactiveValues()
  
  lst_tbls$launches <- tbl_launches
  lst_tbls$launchpads <- tbl_launchpads
  lst_tbls$rockets <- tbl_rockets
  
  # Servers
  charts_Server(ns_chart)
  data_Server(ns_data, lst_tbls)
  about_Server(ns_about, lst_company)
  
}