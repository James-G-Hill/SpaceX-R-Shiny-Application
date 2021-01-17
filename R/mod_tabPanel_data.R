#' UI TabPanel Data
#' 
#' @param id The namespace identifier.
#' @noRd
#' 
mod_tabPanel_data_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  column_width <- 12
  radio_col_width <- 6
  
  bs4Dash::bs4TabItem(
    tabName = "tab_data",
    bs4Dash::bs4Card(
      title = "Tables",
      width = 12,
      status = "dark",
      collapsible = FALSE,
      closable = FALSE,
      shiny::fluidRow(
        shiny::column(
          radio_col_width,
          shiny::radioButtons(
            ns("ns_radio"),
            "Tables",
            choices = c("Launches", "Launchpads", "Rockets"),
            inline = TRUE
          )
        ),
        shiny::column(
          column_width - radio_col_width,
          shiny::downloadButton(ns("ns_button"))
        )
      ),
      shiny::dataTableOutput(ns("ns_datatable"))
    )
  )
  
}

#' Server TabPanel Data
#'
#' @param id The namespace identifier.
#' @param lst_tbls Tables.
#' @noRd
#' 
mod_tabPanel_data_server <- function(id, lst_tbls) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      rows_per_page <- 5
      
      tbl <-
        shiny::reactive(
          switch(
            input$ns_radio,
            "Launches" = lst_tbls$launches,
            "Launchpads" = lst_tbls$launchpads,
            "Rockets" = lst_tbls$rockets
          ) %>%
            dplyr::rename_with(
              .fn = stringr::str_replace_all,
              .cols = dplyr::everything(),
              "_",
              " "
            )
        )
      
      output$ns_datatable <-
        shiny::renderDataTable(
          tbl(),
          options = list(pageLength = rows_per_page)
        )
      
      output$ns_button <-
        shiny::downloadHandler(
          filename = function(file) {
            stringr::str_c(
              "spacex",
              stringr::str_to_lower(input$ns_radio),
              Sys.Date(),
              ".xlsx",
              sep = "_"
            )
          },
          content = function(con) { writexl::write_xlsx(tbl(), con) }
        )
      
    }
  )
  
}
