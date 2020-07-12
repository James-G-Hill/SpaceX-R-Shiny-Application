ui <-
  shiny::navbarPage(
    title = "Aerospace - SpaceX",
    charts_UI(ns_chart),
    data_UI(ns_data),
    about_UI(ns_about)
  )