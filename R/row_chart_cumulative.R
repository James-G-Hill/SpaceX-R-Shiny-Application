# Variables --------------------------------------------------------------------

ns_plot <- "ns_plot"
ns_launchpad <- "launchpads"
ns_rocket <- "rockets"
ns_years <- "years"

# Functions --------------------------------------------------------------------

row_chart_cum_UI <- function(id) {
  
  ns <- shiny::NS(id)
  
  left_col_width <- 4
  
  shiny::fluidRow(
    shiny::column(
      left_col_width,
      shiny::wellPanel(
        shiny::h4("Filter Flights"),
        # shiny::hr(),
        shiny::uiOutput(ns(ns_years)),
        shiny::uiOutput(ns(ns_rocket)),
        shiny::uiOutput(ns(ns_launchpad))
      )
    ),
    shiny::column(
      column_width - left_col_width,
      plotOutput(ns(ns_plot))
    )
  )
  
}

row_chart_cum_Server <- function(id, tbl_cum) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      ns <- session$ns
      
      min_flight_year <- shiny::reactive({ min(tbl_cum()$flight_year) })
      max_flight_year <- shiny::reactive({ max(tbl_cum()$flight_year) })
      
      output$years <-
        shiny::renderUI(
          {
            shiny::sliderInput(
              ns("year_slider"),
              label = "Launch Year",
              min = min_flight_year(),
              max = max_flight_year(),
              value = c(
                min_flight_year(),
                max_flight_year()
              ),
              sep = "",
              step = 1
            )
          }
        )
      
      unique_rockets <-
        shiny::reactive(
          {
            unique(tbl_cum()$rocket_name)
          }
        )
      
      output$rockets <-
        shiny::renderUI(
          {
            shiny::selectInput(
              ns("rocket_select"),
              label = "Rocket Type",
              choices = c("All", unique_rockets())
            )
          }
        )
      
      unique_launchpads <-
        shiny::reactive(
          {
            unique(tbl_cum()$launchpad_name)
          }
        )
      
      output$launchpads <-
        shiny::renderUI(
          {
            shiny::selectInput(
              ns("launchpad_select"),
              label = "Launchpad",
              choices = c("All", unique_launchpads())
            )
          }
        )
      
      output$ns_plot <-
        shiny::renderPlot(
          {
            shiny::req(input$year_slider, input$rocket_select)
            tbl_cum() %>%
              dplyr::filter(
                !upcoming,
                flight_year >= input$year_slider[1],
                flight_year <= input$year_slider[2],
                rocket_name %in% dplyr::case_when(
                  input$rocket_select == "All" ~ unique_rockets(),
                  TRUE ~ input$rocket_select
                ),
                launchpad_name %in% dplyr::case_when(
                  input$launchpad_select == "All" ~ unique_launchpads(),
                  TRUE ~ input$launchpad_select
                )
              ) %>%
              dplyr::mutate(
                cum_success = cumsum(success) / dplyr::row_number()
              ) %>%
              ggplot2::ggplot(
                ggplot2::aes(
                  x = flight_date,
                  y = cum_success
                )
              ) +
              ggplot2::geom_step() +
              ggplot2::geom_point() +
              ggplot2::scale_y_continuous(
                labels = scales::percent,
                limits = c(0, 1)
              ) +
              ggplot2::labs(
                title = "Cumulative Success Rate of SpaceX Launches",
                y = "cumulative success rate"
              )
          }
        )
      
    }
  )
  
}