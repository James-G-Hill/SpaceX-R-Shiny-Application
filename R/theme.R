spacex_theme <-
  fresh::create_theme(
    fresh::bs4dash_status(
      dark = "black"
    ),
    fresh::bs4dash_layout(
      main_bg = "white"
    ),
    fresh::bs4dash_sidebar_dark(
      bg = "black",
      hover_bg = "white",
      color = "white",
      hover_color = "black",
      active_color = "#bfff00"
    ),
    fresh::bs4dash_vars(
      headings_color = "white",
      navbar_dark_color = "white"
    )
  )
