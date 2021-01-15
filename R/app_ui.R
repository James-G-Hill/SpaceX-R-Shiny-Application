#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`.
#' @noRd
#' 
app_ui <- function(request) {
  
  shiny::tagList(
    golem_add_external_resources(),
    shiny::fluidPage(
      shiny::h1("Aerospace - SpaceX"),
      charts_UI(ns_chart),
      data_UI(ns_data),
      about_UI(ns_about)
    )
  )
  
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @noRd
#' 
golem_add_external_resources <- function() {
  
  golem::add_resource_path("www", app_sys("app/www"))
 
  shiny::tags$head(
    golem::favicon(),
    golem::bundle_resources(
      path = app_sys("app/www"),
      app_title = "spacex.app"
    )
  )
  
}
