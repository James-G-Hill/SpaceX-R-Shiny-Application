#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`.
#' @noRd
#' 
app_ui <- function(request) {
  
  shiny::tagList(
    golem_add_external_resources(),
    bs4Dash::bs4DashPage(
      sidebar_min = FALSE,
      controlbar_collapsed = TRUE,
      controlbar_overlay = TRUE,
      title = "Aerospace - SpaceX",
      navbar = mod_navbar_ui("navbar"),
      sidebar = mod_sidebar_ui("sidebar"),
      body = mod_dashBody_ui("dashbody"),
      fresh::use_theme(spacex_theme)
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
    golem::favicon(ext = "png"),
    golem::bundle_resources(
      path = app_sys("app/www"),
      app_title = "spacex.app"
    )
  )
  
}
