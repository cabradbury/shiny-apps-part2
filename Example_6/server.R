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
# server.R: Server-side application processing, data loading,
#           preparation and manipulation.
#
# Notes: This was the original server.R file that came from 
#        the last example in Part I. Nothing needs to be 
#        changed in this file - the only items we will 
#        change are the UI so it can use a dashboards-style
#        layout and add some new charts.

# Load needed packages
library(shiny)
library(shinydashboard)
library(zoo)
library(plotly)
library(lubridate)

# Define server-side logic for loading data, 
# generating plots and other items. All variables
# are loaded as an element of the "output" variable.
shinyServer(function(input, output) {
  
  # Load Data
  load("./data/CrimeStats.RData")
  
  # Drop-down selection box for which data set. We use a renderUI object type since
  # this will be rendered as a control widget in the UI. Basically, we prep everything
  # here and then simply display it on the UI side with a uiOutput()
  output$chooseCategory <- renderUI({
    selectInput("category", "Select a Category:", as.list(unique(crimeData$UCR.CRIME.CATEGORY)), selected = as.list(unique(crimeData$UCR.CRIME.CATEGORY))[[1]])
  })
  
  # Create a table of the data set for the users reference. A simple renderTable can be
  # used, but renderDataTable is fancier and allows search and sorting out of the box.
  # The lengthMenu option at the bottom tells the data table to give the options of 
  # 10, 25 and 50 records per page, but to default to 10 at the beginning. 
  output$crimeDataTable <- renderDataTable({
    crimeData
  }, options = list(lengthMenu = c(10, 25, 50), pageLength = 10))

  # Create a plot of the data - this will be a reactive plot based on the input provided
  # but the selectInput() / renderUI() created in the first step above. Notice that we 
  # are subsetting the data being plotted by the input$category, as that is where the
  # option selected is stored. 
  output$crimesByMonthBarChart <- renderPlot({
    crimeDataRefined <- subset(crimeData, as.factor(crimeData$UCR.CRIME.CATEGORY) == input$category)
    if(nrow(crimeDataRefined) > 0) {
      crimesByMonth <- setNames(aggregate(crimeDataRefined$INC.NUMBER~as.yearmon(crimeDataRefined$OCCURRED.ON), data=crimeDataRefined, FUN = length), c("Month", "Count"))
      barplot(crimesByMonth$Count, ylab="Count", names.arg = crimesByMonth$Month, las=2)
    }
  })
  
  output$totalCrimesByMonthPlotlyBarChart <- renderPlotly({
    crimeDataAggregate <- setNames(aggregate(crimeData$INC.NUMBER~as.yearmon(crimeData$OCCURRED.ON), data=crimeData, FUN = length), c("Month", "Count"))
    plot_ly(x = crimeDataAggregate$Month, y = crimeDataAggregate$Count, name = "Crimes Per Month", type = "bar")
  })
  
  output$crimesByMonthBarChartDynamicPlotlyBarChart <- renderPlotly({
    crimeDataRefinedPlotly <- subset(crimeData, as.factor(crimeData$UCR.CRIME.CATEGORY) == input$category)
    if(nrow(crimeDataRefinedPlotly ) > 0) {
      crimesByMonthPlotly <- setNames(aggregate(crimeDataRefinedPlotly $INC.NUMBER~as.yearmon(crimeDataRefinedPlotly$OCCURRED.ON), data=crimeDataRefinedPlotly, FUN = length), c("Month", "Count"))
      plot_ly(x = as.Date(crimesByMonthPlotly$Month), y = crimesByMonthPlotly$Count, name = "Crimes Per Month", type = "bar")
    }
  })
  
  output$last7Days <- renderInfoBox({
    crimesLastSevenDays <- nrow(subset(crimeData, crimeData$OCCURRED.ON <= crimeData$OCCURRED.ON[which.max(as.POSIXct(crimeData$OCCURRED.ON))] & crimeData$OCCURRED.ON >= crimeData$OCCURRED.ON[which.max(as.POSIXct(crimeData$OCCURRED.ON))] - days(7)))
    infoBox("Crimes Last 7 Days", crimesLastSevenDays, icon = icon("glyphicon glyphicon-stats", lib = "glyphicon"), color = "blue")
  })
  
  output$last30Days <- renderInfoBox({
    crimesLastSevenDays <- nrow(subset(crimeData, crimeData$OCCURRED.ON <= crimeData$OCCURRED.ON[which.max(as.POSIXct(crimeData$OCCURRED.ON))] & crimeData$OCCURRED.ON >= crimeData$OCCURRED.ON[which.max(as.POSIXct(crimeData$OCCURRED.ON))] - days(30)))
    infoBox("Crimes Last 30 Days", crimesLastSevenDays, icon = icon("glyphicon glyphicon-stats", lib = "glyphicon"), color = "blue")
  })
  
  output$last60Days <- renderInfoBox({
    crimesLastSevenDays <- nrow(subset(crimeData, crimeData$OCCURRED.ON <= crimeData$OCCURRED.ON[which.max(as.POSIXct(crimeData$OCCURRED.ON))] & crimeData$OCCURRED.ON >= crimeData$OCCURRED.ON[which.max(as.POSIXct(crimeData$OCCURRED.ON))] - days(60)))
    infoBox("Crimes Last 60 Days", crimesLastSevenDays, icon = icon("glyphicon glyphicon-stats", lib = "glyphicon"), color = "blue")
  })
  
  output$last90Days <- renderInfoBox({
    crimesLastSevenDays <- nrow(subset(crimeData, crimeData$OCCURRED.ON <= crimeData$OCCURRED.ON[which.max(as.POSIXct(crimeData$OCCURRED.ON))] & crimeData$OCCURRED.ON >= crimeData$OCCURRED.ON[which.max(as.POSIXct(crimeData$OCCURRED.ON))] - days(90)))
    infoBox("Crimes Last 90 Days", crimesLastSevenDays, icon = icon("glyphicon glyphicon-stats", lib = "glyphicon"), color = "blue")
  })
  
})
