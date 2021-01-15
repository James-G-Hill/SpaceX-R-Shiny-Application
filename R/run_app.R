#' Run the Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#' @param options A list of options.
#' @export
#' 
run_app <- function(..., options = list()) {
  
  golem::with_golem_options(
    app =
      shiny::shinyApp(
        ui = app_ui, 
        server = app_server,
        options = options
      ), 
    golem_opts = list(...)
  )
  
}
