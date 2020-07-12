# Sources ----------------------------------------------------------------------

source(file = file.path("R", "utils_get_data.R"), local = TRUE)

# Function ---------------------------------------------------------------------

server <- function(input, output) {
  
  lst_company <- shiny::reactive({ get_api_company() })
  
  about_Server(ns_about, lst_company)
  
}