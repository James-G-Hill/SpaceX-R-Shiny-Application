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
      stringr::str_c("Founder", lst_company$founder, sep = " : ")
    ),
    shiny::p(
      stringr::str_c("CEO", lst_company$ceo, sep = " : ")
    ),
    shiny::p(
      stringr::str_c("CTO", lst_company$cto, sep = " : ")
    ),
    shiny::p(
      stringr::str_c("COO", lst_company$coo, sep = " : ")
    ),
    shiny::p(
      stringr::str_c(
        "CTO Propulsion",
        lst_company$cto_propulsion,
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
    shiny::a(href = lst_company$links$website, "SpaceX"),
    shiny::br(),
    shiny::a(href = lst_company$links$flickr, "Flickr"),
    shiny::br(),
    shiny::a(href = lst_company$links$twitter, "Twitter"),
    shiny::br(),
    shiny::a(href = lst_company$links$elon_twitter, "Elon Musk Twitter")
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
        lst_company$headquarters$address,
        sep = " : "
      )
    ),
    shiny::p(
      stringr::str_c(
        "City",
        lst_company$headquarters$city,
        sep = " : "
      )
    ),
    shiny::p(
      stringr::str_c(
        "State",
        lst_company$headquarters$state,
        sep = " : "
      )
    )
  )
  
}
