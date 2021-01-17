#' UI Chart Raw
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_chart_raw_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  column_width <- 12 # total no. of columns in fluidRow
  left_col_width <- 4
  
  bs4Dash::bs4Card(
    title = "Success Rate of Launches",
    width = 12,
    status = "dark",
    collapsible = FALSE,
    closable = FALSE,
    shiny::fluidRow(
      shiny::column(
        left_col_width,
        shiny::selectInput(
          ns("ns_upcoming"),
          "Include Upcoming Launches?",
          choices = c("Yes", "No"),
          selected = "Yes"
        ),
        shiny::selectInput(
          ns("select_var"),
          label = "Select Variable",
          choices = NULL
        )
      ),
      shiny::column(
        column_width - left_col_width,
        shiny::plotOutput(ns("ns_plot"))
      )
    )
  )
  
}

#' Server Chart Raw
#' 
#' @param id The namespace identifier.
#' @param tbl_raw The raw data.
#' @noRd
#' @importFrom dplyr .data
#' 
mod_chart_raw_server <- function(id, tbl_raw) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      unique_var_names <-
        tbl_raw %>%
          dplyr::select(-.data$success, -.data$upcoming) %>%
          names()
      
      shiny::updateSelectInput(
        session,
        "select_var",
        choices = unique_var_names,
        selected = unique_var_names[1]
      )
      
      ggplot_res <- 96 # best resolution for ggplot2 plots
      
      output$ns_plot <-
        shiny::renderPlot(
          res = ggplot_res,
          {
            shiny::req(
              input$ns_upcoming,
              input$select_var
            )
            tbl_raw %>%
              dplyr::filter(
                .data$upcoming %in% dplyr::case_when(
                  input$ns_upcoming == "Yes" ~ c(TRUE, FALSE),
                  TRUE ~ FALSE
                )
              ) %>%
              ggplot2::ggplot(
                ggplot2::aes_string(
                  x = input$select_var,
                  fill = "success"
                )
              ) +
              ggplot2::geom_bar(position = "fill") +
              ggplot2::scale_y_continuous(
                labels = scales::percent,
                limits = c(0, 1)
              ) +
              ggplot2::scale_fill_manual(
                values = c(
                  "success" = "palegreen4",
                  "failure" = "firebrick3",
                  "upcoming" = "darkgrey"
                )
              ) +
              ggplot2::labs(
                title = "Success Rate of SpaceX Launches by Factor",
                subtitle = "Shows the % success rate within each bar",
                y = "success rate"
              )
          }
        )
      
    }
  )
 
}
