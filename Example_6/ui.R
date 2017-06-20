#
# Phoenix R Users Group
# June 21, 2017
#
# Shiny Application Development - Part II
# Example 6
#
# Author: Charles Bradbury
#
# About:
# ui.R: Presentation layer for the application.
#

# Load the shinydashboard package. We will use this 
# as opposed to the "shiny" package in the examples
# for Part I. This will give us some advanced UI
# capabilities.
library(shinydashboard)
library(shiny)
library(plotly)

# We define the page using the dashboardPage() funciton.
# Notice that all items (headers, sidebars, etc.) must
# be separated by a comma. The same rule applies with 
# items within these functions - just like with the 
# "shiny" package. 
dashboardPage(
  
  # We defined a header using the dashboardHeader() function.
  dashboardHeader(title = "Phoenix Crime Stats"),
  
  # We define a sidebar using the dashboardSidebar() function.
  dashboardSidebar(uiOutput("chooseCategory")),
  
  # We define the body of the page with the dashboardBody() function.
  dashboardBody(
    
    # Now, we need a place to put a plot, this time we use a tabBox(), 
    # but it requires we put it in a row (or column) just like a box().
    fluidRow(
      infoBoxOutput("last7Days", width = 3),
      infoBoxOutput("last30Days", width = 3),
      infoBoxOutput("last60Days", width = 3),
      infoBoxOutput("last90Days", width = 3),
      tabBox(
        width = 12,
        id = "tabset1",
        tabPanel("Crimes by Category", plotOutput("crimesByMonthBarChart")),
        tabPanel("Crime Data", dataTableOutput("crimeDataTable")),
        tabPanel("Total Crimes per Month", plotlyOutput("totalCrimesByMonthPlotlyBarChart")),
        tabPanel("Crimes By Category - Plotly", plotlyOutput("crimesByMonthBarChartDynamicPlotlyBarChart"))
      )
    )
  )
)
