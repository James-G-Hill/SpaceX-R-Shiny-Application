ui <-
  shiny::navbarPage(
    title = "Aerospace - SpaceX",
    data_UI(ns_data),
    about_UI(ns_about)
  )