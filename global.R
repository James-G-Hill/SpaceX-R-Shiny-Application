# Libraries --------------------------------------------------------------------

library(curl)
library(magrittr)

# Namespaces -------------------------------------------------------------------

ns_about <- "about"
ns_chart <- "chart"
ns_data <- "data"

# Magic Numbers ----------------------------------------------------------------

column_width <- 12 # total no. of columns in fluidRow

ms_per_s <- 1000 # milliseconds per second
s_per_m <- 60 # seconds per minutes
m_per_h <- 60 # minutes per hour

ggplot_res <- 96 # best resolution for ggplot2 plots
