# Variables --------------------------------------------------------------------

ns_plot <- "ns_plot"
ns_upcoming <- "ns_upcoming"
ns_vars <- "ns_vars"

# Functions --------------------------------------------------------------------

row_chart_raw_UI <- function(id) {
  
  ns <- shiny::NS(id)
  
  left_col_width <- 4
  
  shiny::fluidRow(
    shiny::column(
      left_col_width,
      shiny::wellPanel(
        shiny::h4("Filter Factors"),
        shiny::hr(),
        shiny::uiOutput(ns(ns_years)),
        shiny::selectInput(
          ns(ns_upcoming),
          "Include Upcoming Launches?",
          choices = c("Yes", "No"),
          selected = "Yes"
        ),
        shiny::uiOutput(ns(ns_vars))
      )
    ),
    shiny::column(
      column_width - left_col_width,
      plotOutput(ns(ns_plot))
    )
  )
  
}

row_chart_raw_Server <- function(id, tbl_raw) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      ns <- session$ns
      
      unique_var_names <-
        shiny::reactive(
          {
            tbl_raw() %>%
              dplyr::select(-success, -upcoming) %>%
              names()
          }
        )
      
      output$ns_vars <-
        shiny::renderUI(
          {
            shiny::selectInput(
              ns("select_var"),
              label = "Select Variable",
              choices = unique_var_names(),
              selected = unique_var_names()[1]
            )
          }
        )
      
      output$ns_plot <-
        shiny::renderPlot(
          res = ggplot_res,
          {
            shiny::req(
              input$ns_upcoming,
              input$select_var
            )
            tbl_raw() %>%
              dplyr::filter(
                upcoming %in% dplyr::case_when(
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