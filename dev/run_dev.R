# Set options here
options(golem.app.prod = FALSE)

# Detach all loaded packages and clean your environment
golem::detach_all_attached()

# Document and reload your package
golem::document_and_reload()

datasets <- readRDS(here::here("dev", "data", "datasets.RDS"))

spacex.app::run_app(
  options = list(launch.browser = TRUE),
  data = datasets
)
