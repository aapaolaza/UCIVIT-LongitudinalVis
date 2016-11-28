
installMissingPackages <- function(){
  list.of.packages <- c("shiny","ggplot2","lattice","lme4","lmerTest","ggplot2","stringr")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  else print("All listed packages are already installed")
}
installMissingPackages()


library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("LongLinearMixedModel"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    sidebarPanel(
      
      #featureToUse
      radioButtons("featureToUse", "Feature to use:",
                   c("urlEpisodeDurationms" = "urlEpisodeDurationms",
                     "mouseTimeToClickTime" = "mouseTimeToClickTime",
                     "scrollControlledSpeedAbs" = "scrollControlledSpeedAbs",
                     "mouseMedianIdleTimeDuration" = "mouseMedianIdleTimeDuration",
                     "mouseClickSpeedClickTime" = "mouseClickSpeedClickTime")),
      #urlFilter
      radioButtons("urlFilter", "Url to use:",
                   c("AnonymisedUrl" = "http://www.cs.manchester.ac.uk/",
                     "AnonymisedUrl2" = "http://www.cs.manchester.ac.uk/Aitor")),
                   
                   #c("http://www.cs.manchester.ac.uk/" = "http://www.cs.manchester.ac.uk/",
                    # "http://www.cs.manchester.ac.uk/Aitor" = "http://www.cs.manchester.ac.uk/Aitor")),
      #filterByUrl
      checkboxInput("filterByUrl", label = "filterByUrl", value = TRUE),
      br(),
      #userLimit
      sliderInput("userLimit", label = "User Limit", min = 0, max = 1000, value = 500),
      #activeTimeThreshold
      sliderInput("activeTimeThreshold",
                  label = "activeTimeThreshold to determine the size of the bins, in minutes",
                  min = 0, max = 20, value = 1),#1 * 60 * 1000
      #minActiveTimeBinNumber = 4
      #activeBinTimeLimit = 20
      sliderInput("activeTimeBin", label = "Active Time Limits", min = 0, 
                  max = 100, value = c(4, 20)),
      #xlimit
      #In case an xlimit is wanted, set it to -1 otherwise
      sliderInput("xlimit", label = "xlimit?, -1 otherwise", min = -1, max = 1000, value = -1),
      
      ###Parameters for the mixed linear model.
      #filterByUrl
      checkboxInput("logariseFeature", label = "logariseFeature", value = TRUE),
      checkboxInput("logariseActiveTime", label = "logariseActiveTime", value = TRUE),
      checkboxInput("plotAgainstBins", label = "plotAgainstBins", value = FALSE),
      checkboxInput("plotDataPoints", label = "plotDataPoints", value = FALSE),
      
      br(),
      actionButton("refresh", label = "Refresh plots")
    ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Density functions", plotOutput("densityPlot", height = "1200px")),
                  tabPanel("Linear plots", plotOutput("linearPlot", height = "1200px")),
                  tabPanel("Lattice plot", plotOutput("latticePlot", height = "1200px")),
                  tabPanel("Lattice plot vs Mixed Model", plotOutput("latticeMixedPlot", height = "1200px")),
                  tabPanel("Mixed Model", plotOutput("mixedPlot", height = "1200px")),
                  tabPanel("Mixed Model diagnose", plotOutput("mixedDiagnose", height = "1200px")),
                  
                  tabPanel("Summary", verbatimTextOutput("summary")),
                  tabPanel("Table", tableOutput("table"))
      )
    )
  )
))