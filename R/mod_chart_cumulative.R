#' UI Chart Cumulative
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_chart_cumulative_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  column_width <- 12 # total no. of columns in fluidRow
  left_col_width <- 4
  
  shiny::fluidRow(
    shiny::column(
      left_col_width,
      shiny::wellPanel(
        shiny::h4("Filter Flights"),
        shiny::hr(),
        shiny::fluidRow(
          shiny::column(6, shiny::uiOutput(ns("ns_years"))),
          shiny::column(6, shiny::uiOutput(ns("ns_rocket")))
        ),
        shiny::fluidRow(
          shiny::column(6, shiny::uiOutput(ns("ns_launchpad"))),
          shiny::column(6, shiny::uiOutput(ns("ns_region")))
        )
      )
    ),
    shiny::column(
      column_width - left_col_width,
      shiny::plotOutput(ns("ns_plot"))
    )
  )
  
}

#' Server Chart Cumulative
#' 
#' @param id The namespace identifier.
#' @param tbl_cum The cumulative table.
#' @noRd
#' @importFrom dplyr .data
#' 
mod_chart_cumulative_server <- function(id, tbl_cum) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      ns <- session$ns
      
      min_flight_year <- shiny::reactive(min(tbl_cum()$flight_year))
      max_flight_year <- shiny::reactive(max(tbl_cum()$flight_year))
      
      output$years <-
        shiny::renderUI(
          shiny::sliderInput(
            ns("year_slider"),
            label = "Flight Year",
            min = min_flight_year(),
            max = max_flight_year(),
            value =
              c(
                min_flight_year(),
                max_flight_year()
              ),
            sep = "",
            step = 1
          )
        )
      
      unique_rockets <-
        shiny::reactive(unique(tbl_cum()$rocket_name))
      
      output$rockets <-
        shiny::renderUI(
          shiny::selectInput(
            ns("rocket_select"),
            label = "Rocket Name",
            choices = c("All", unique_rockets())
          )
        )
      
      unique_launchpads <-
        shiny::reactive(unique(tbl_cum()$launchpad_name))
      
      output$launchpads <-
        shiny::renderUI(
          shiny::selectInput(
            ns("launchpad_select"),
            label = "Launchpad Name",
            choices = c("All", unique_launchpads())
          )
        )
      
      unique_regions <- shiny::reactive(unique(tbl_cum()$region))
      
      output$region <-
        shiny::renderUI(
          shiny::selectInput(
            ns("region_select"),
            label = "Region",
            choices = c("All", unique_regions())
          )
        )
      
      ggplot_res <- 96 # best resolution for ggplot2 plots
      
      output$ns_plot <-
        shiny::renderPlot(
          res = ggplot_res,
          {
            shiny::req(
              input$year_slider,
              input$rocket_select,
              input$launchpad_select
            )
            tbl_cum() %>%
              dplyr::filter(
                !.data$upcoming,
                .data$flight_year >= input$year_slider[1],
                .data$flight_year <= input$year_slider[2],
                .data$rocket_name %in% dplyr::case_when(
                  input$rocket_select == "All" ~ unique_rockets(),
                  TRUE ~ input$rocket_select
                ),
                .data$launchpad_name %in% dplyr::case_when(
                  input$launchpad_select == "All" ~ unique_launchpads(),
                  TRUE ~ input$launchpad_select
                ),
                .data$region %in% dplyr::case_when(
                  input$region_select == "All" ~ unique_regions(),
                  TRUE ~ input$region_select
                )
              ) %>%
              dplyr::mutate(
                cum_success = cumsum(.data$success) / dplyr::row_number()
              ) %>%
              ggplot2::ggplot(
                ggplot2::aes(
                  x = .data$flight_date,
                  y = .data$cum_success
                )
              ) +
              ggplot2::geom_step() +
              ggplot2::geom_point(
                data = function(x) { dplyr::filter(x, .data$success)},
                fill = "palegreen4",
                size = 3,
                shape = 24
              ) +
              ggplot2::geom_point(
                data = function(x) { dplyr::filter(x, !.data$success)},
                fill = "firebrick3",
                size = 3,
                shape = 25
              ) +
              ggrepel::geom_label_repel(
                data = function(x) { dplyr::filter(x, !.data$success)},
                ggplot2::aes(
                  label =
                    stringr::str_c(
                      .data$flight_number,
                      .data$flight_name,
                      sep = " - "
                    )
                ),
                point.padding = 1,
                direction = "y",
                force = 3
              ) +
              ggplot2::scale_y_continuous(
                labels = scales::percent,
                limits = c(0, 1)
              ) +
              ggplot2::labs(
                title = "Cumulative Success Rate of SpaceX Launches",
                x = "flight date",
                y = "cumulative success rate"
              )
          }
        )
      
    }
  )
 
}
