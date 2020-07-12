# Demonstration Shiny Application - SpaceX Launch Risk

A demonstration R Shiny application using a SpaceX API.

## Introduction

The following application is a demonstraction R Shiny application.
The purpose is to show how an application may be designed for a corporate insurer.
It allows the user to examine the success rate of SpaceX rocket launches.
Underwriters could use the application to evaluate the risk of future rocket launches.

## Features

The application has the following features:

1. Interactive chart showing cumulative success rate of rocket launches
2. Interactive chart showing success rate of launces dependent on varying factors.
3. Navigation of the underlying data tables.
4. Ability to download the data tables to Excel.
5. Information on SpaceX, the company whose data is being analysed.

## Running on shinyapps.io

1. You will need an account at 'www.shinyapps.io'.
2. You will need to install 'rsconnect' package (`install.packages('rsconnect')`).
3. You will need to follow the instructions for authorizing an account.
4. Load the library 'rsconnect' locally (`library('rsconnect')`)
5. Deploy with `rsconnect::deployApp('path/to/your/app')`

