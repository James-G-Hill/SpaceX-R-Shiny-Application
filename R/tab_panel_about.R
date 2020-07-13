# Variables --------------------------------------------------------------------

ns_about <- "ns_about"

# Functions --------------------------------------------------------------------

about_UI <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::tabPanel(
    title = "About",
    shiny::htmlOutput(
      style =
        glue::glue(
          "
          width: 35%;
          text-align: center;
          align: center;
          margin-left: auto;
          margin-right: auto;
          "
      ),
      ns(ns_about)
    )
  )
  
}

about_Server <- function(id, lst_company) {
  
  shiny::moduleServer(
    id,
    function(input, output, session) {
      
      output$ns_about <-
        shiny::renderUI(
          {
            shiny::tagList(
              shiny::h1(lst_company()$name),
              shiny::br(),
              shiny::p(lst_company()$summary),
              shiny::hr(),
              tags_staff(lst_company),
              shiny::hr(),
              tags_links(lst_company),
              shiny::hr(),
              tags_address(lst_company)
            )
          }
        )
      
    }
  )
  
}

# Helper Functions -------------------------------------------------------------

#' Create HTML for Staff
#' 
#' @param lst_company A reactive list of company information.
#' @return A list of HTML tags.
#' 
tags_staff <- function(lst_company) {
  
  shiny::tagList(
    shiny::h2("Staff"),
    shiny::br(),
    shiny::p(
      stringr::str_c("Founder", lst_company()$founder, sep = " : ")
    ),
    shiny::p(
      stringr::str_c("CEO", lst_company()$ceo, sep = " : ")
    ),
    shiny::p(
      stringr::str_c("CTO", lst_company()$cto, sep = " : ")
    ),
    shiny::p(
      stringr::str_c("COO", lst_company()$coo, sep = " : ")
    ),
    shiny::p(
      stringr::str_c(
        "CTO Propulsion",
        lst_company()$cto_propulsion,
        sep = " : "
      )
    )
  )
  
}

#' Create HTML for Links
#' 
#' @param lst_company A reactive list of company information.
#' @return A list of HTML tags.
#' 
tags_links <- function(lst_company) {
  
  shiny::tagList(
    shiny::h2("Links"),
    shiny::br(),
    shiny::a(href = lst_company()$links$website, "SpaceX"),
    shiny::br(),
    shiny::a(href = lst_company()$links$flickr, "Flickr"),
    shiny::br(),
    shiny::a(href = lst_company()$links$twitter, "Twitter"),
    shiny::br(),
    shiny::a(href = lst_company()$links$elon_twitter, "Elon Musk Twitter")
  )
  
}

#' Create HTML for an Address
#' 
#' @param lst_company A reactive list of company information.
#' @return A list of HTML tags.
#' 
tags_address <- function(lst_company) {
  
  shiny::tagList(
    shiny::h2("HQ"),
    shiny::br(),
    shiny::p(
      stringr::str_c(
        "Street",
        lst_company()$headquarters$address,
        sep = " : "
      )
    ),
    shiny::p(
      stringr::str_c(
        "City",
        lst_company()$headquarters$city,
        sep = " : "
      )
    ),
    shiny::p(
      stringr::str_c(
        "State",
        lst_company()$headquarters$state,
        sep = " : "
      )
    )
  )
  
}
