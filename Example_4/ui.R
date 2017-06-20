#
# Phoenix R Users Group
# June 21, 2017
#
# Shiny Application Development - Part II
# Example 4
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

# We define the page using the dashboardPage() funciton.
# Notice that all items (headers, sidebars, etc.) must
# be separated by a comma. The same rule applies with 
# items within these functions - just like with the 
# "shiny" package. 
dashboardPage(
  
  # We defined a header using the dashboardHeader() function.
  dashboardHeader(),
  
  # We define a sidebar using the dashboardSidebar() function.
  dashboardSidebar(),
  
  # We define the body of the page with the dashboardBody() function.
  dashboardBody()
)
