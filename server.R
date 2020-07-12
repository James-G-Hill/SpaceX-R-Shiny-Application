# Sources ----------------------------------------------------------------------

source(file = file.path("R", "utils_get_data.R"), local = TRUE)

# Function ---------------------------------------------------------------------

server <- function(input, output) {
  
  # Tables
  tbl_launches <- shiny::reactive({ get_api_launches() })
  tbl_launchpads <- shiny::reactive({ get_api_launchpads() })
  tbl_rockets <- shiny::reactive({ get_api_rockets() })
  
  # Data Tab
  lst_tbls <- reactiveValues()
  lst_tbls$launches <- tbl_launches
  lst_tbls$launchpads <- tbl_launchpads
  lst_tbls$rockets <- tbl_rockets
  data_Server(ns_data, lst_tbls)
  
  # About Tab
  lst_company <- shiny::reactive({ get_api_company() })
  about_Server(ns_about, lst_company)
  
}