#' UI Chart Cumulative
#'
#' @param id The namespace identifier.
#' @noRd
#' 
mod_chart_cumulative_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  column_width <- 12 # total no. of columns in fluidRow
  left_col_width <- 4
  
  bs4Dash::box(
    title = "Cumulative Launch Success",
    width = 12,
    collapsible = FALSE,
    closable = FALSE,
    shiny::fluidRow(
      shiny::column(
        left_col_width,
        shiny::sliderInput(
          ns("years"),
          label = "Flight Year",
          min = 0,
          max = 0,
          value = c(0, 0),
          sep = "",
          step = 1
        ),
        shiny::selectInput(
          ns("rocket"),
          label = "Rocket Name",
          choices = "All"
        ),
        shiny::selectInput(
          ns("launchpad"),
          label = "Launchpad Name",
          choices = "All"
        ),
        shiny::selectInput(
          ns("region"),
          label = "Region",
          choices = "All"
        )
      ),
      shiny::column(
        column_width - left_col_width,
        shiny::plotOutput(ns("ns_plot"))
      )
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
      
      shiny::updateSliderInput(
        session,
        "years",
        min = min(tbl_cum$flight_year),
        max = max(tbl_cum$flight_year),
        value =
          c(
            min(tbl_cum$flight_year),
            max(tbl_cum$flight_year)
          )
        )
      
      shiny::updateSelectInput(
        session,
        "rocket",
        choices = c("All", unique(tbl_cum$rocket_name))
      )
      
      shiny::updateSelectInput(
        session,
        "launchpad",
        choices = c("All", unique(tbl_cum$launchpad_name))
      )
      
      shiny::updateSelectInput(
        session,
        "region",
        choices = c("All", unique(tbl_cum$region))
      )
      
      ggplot_res <- 96 # best resolution for ggplot2 plots
      
      output$ns_plot <-
        shiny::renderPlot(
          res = ggplot_res,
          {
            shiny::req(
              input$years,
              input$rocket,
              input$launchpad,
              input$region
            )
            tbl_cum |>
              dplyr::filter(
                !.data$upcoming,
                .data$flight_year >= input$years[1],
                .data$flight_year <= input$years[2],
                .data$rocket_name %in%
                  dplyr::case_when(
                    input$rocket == "All" ~ unique(tbl_cum$rocket_name),
                    TRUE ~ input$rocket
                  ),
                .data$launchpad_name %in%
                  dplyr::case_when(
                    input$launchpad == "All" ~ unique(tbl_cum$launchpad_name),
                    TRUE ~ input$launchpad
                  ),
                .data$region %in% dplyr::case_when(
                  input$region == "All" ~ unique(tbl_cum$region),
                  TRUE ~ input$region
                )
              ) |>
              dplyr::mutate(
                cum_success = cumsum(.data$success) / dplyr::row_number()
              ) |>
              ggplot2::ggplot(
                ggplot2::aes(
                  x = .data$flight_date,
                  y = .data$cum_success
                )
              ) +
              ggplot2::geom_step() +
              ggplot2::geom_point(
                data = \(x) { dplyr::filter(x, .data$success) },
                fill = "palegreen4",
                size = 3,
                shape = 24
              ) +
              ggplot2::geom_point(
                data = \(x) { dplyr::filter(x, !.data$success) },
                fill = "firebrick3",
                size = 3,
                shape = 25
              ) +
              ggrepel::geom_label_repel(
                data = \(x) { dplyr::filter(x, !.data$success) },
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
