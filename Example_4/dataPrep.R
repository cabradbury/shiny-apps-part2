#
# Phoenix R Users Group
# June 23, 2017
#
# Shiny Application Development - Part II
# Example 4
#
# Author: Charles Bradbury
#
# About:
# dataPrep.R: Code to obtain and prepare the data prior to displaying
#             it in the shiny application.
#

# Get data, if it hasn't already been loaded. 
if(file.exists("./data/Crime Stats.csv") == TRUE) {
  crimeData <- read.csv("./data/Crime Stats.csv")
} else {
  download.file("https://www.phoenix.gov/OpenDataFiles/Crime%20Stats.csv", "./data/Crime Stats.csv")
  crimeData <- read.csv("./data/Crime Stats.csv")
}

# Clean and prepare data. Let's change some data types to make it 
# easier to sort, plot and filter results.
crimeData$INC.NUMBER <- as.factor(crimeData$INC.NUMBER)
crimeData$OCCURRED.ON <- as.POSIXlt(crimeData$OCCURRED.ON, format = "%m/%d/%Y %H:%M")
crimeData$OCCURRED.TO <- as.POSIXlt(crimeData$OCCURRED.TO, format = "%m/%d/%Y %H:%M")
crimeData$UCR.CRIME.CATEGORY <- as.character(crimeData$UCR.CRIME.CATEGORY)
crimeData$X100.BLOCK.ADDR <- as.character(crimeData$X100.BLOCK.ADDR)
crimeData$ZIP <- as.factor(crimeData$ZIP)
crimeData$PREMISE.TYPE<- as.character(crimeData$PREMISE.TYPE)

# Save the data out to an RData file to preserve data types, etc..
save(crimeData, file="./data/CrimeStats.RData")
