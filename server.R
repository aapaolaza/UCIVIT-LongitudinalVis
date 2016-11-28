
installMissingPackages <- function(){
  list.of.packages <- c("shiny","ggplot2","lattice","lme4","lmerTest","ggplot2","stringr")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  else print("All listed packages are already installed")
}
installMissingPackages()

library(shiny)
library(ggplot2)
library(lattice)
library(lme4)
options(shiny.trace=FALSE)

appName <<- "LongLinearMixedModel"
cat(paste("Starting Web aplication:",appName))

#This function returns the main dataObject
getEpisodeData <- function(){
  print(paste("getEpisodeData():START at ", Sys.time()))
  
  #Load globalEpisodePoolAllUrls
  #load(paste(appName,"/data/globalEpisodePoolAllUrlsObject.RData",sep=""))
  load("data/globalEpisodePoolAllUrlsObject.RData")
  #globalEpisodePoolAllUrlsObject = load("LongLinearMixedModel/data/globalEpisodePoolAllUrlsObject.RData")
  #globalEpisodePoolAllUrlsObject = load("globalEpisodePoolAllUrlsObject.RData")
  print(paste(nrow(globalEpisodePoolAllUrls)," rows loaded"))
  
  print(paste("getEpisodeData():END at ", Sys.time()))
  
  return(globalEpisodePoolAllUrls)
}

# Define server logic for random distribution application
shinyServer(function(input, output) {
  print("shinyServer()")
  #processDataForPlots()
  
  
  # Reactive expression to generate the requested distribution.
  # This is called whenever the inputs change. The output
  # functions defined below then all use the value computed from
  # this expression
  data <- reactive({
    print("data(): reactive")
    #input that will trigger the replot
    input$refresh
    
    #SOURCE: http://shiny.rstudio.com/articles/progress.html
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "DATA LOADING", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    # Create a callback function to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }
    
    loadInputFromUI(updateProgress)
    processDataForPlots(updateProgress)
  })
  
  # Generate a plot of the data. Also uses the inputs to build
  # the plot label. Note that the dependencies on both the inputs
  # and the data reactive expression are both tracked, and
  # all expressions are called in the sequence implied by the
  # dependency graph
  
  output$densityPlot <- renderPlot({
    print("output$densityPlot()")
    data()
    
    #SOURCE: http://shiny.rstudio.com/articles/progress.html
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "DENSITY PLOTS", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    # Create a callback function to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }
    
    # Compute the new data, and pass in the updateProgress function so
    # that it can update the progress indicator.
    
    activeTimeVsFeatureDensityVisualisations(plotData,
                                             featureToUse,
                                             urlFilter,
                                             userLimit,
                                             activeTimeThreshold,
                                             minActiveTimeBinLimit,
                                             maxActiveTimeBinLimit,
                                             xlimit,
                                             updateProgress)
  })
  
  output$linearPlot <- renderPlot({
    print("output$linearPlot()")
    data()
    
    #SOURCE: http://shiny.rstudio.com/articles/progress.html
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "LINEAR PLOTS", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    # Create a callback function to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }
    
    activeTimeVsFeatureLineVisualisations(ggplotHistData=plotData,
                                          featureToUse = featureToUse,
                                          urlFilter = urlFilter,
                                          userLimit = userLimit,
                                          activeTimeThreshold = activeTimeThreshold,
                                          minActiveTimeBinLimit = minActiveTimeBinLimit,
                                          maxActiveTimeBinLimit = maxActiveTimeBinLimit,
                                          updateProgress = updateProgress)
  })
  
  output$latticePlot <- renderPlot({
    print("output$latticePlot()")
    data()
    
    #SOURCE: http://shiny.rstudio.com/articles/progress.html
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "LATTICE PLOT", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    # Create a callback function to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }
    
    ####SET DATA FOR LINEAR ANALYSIS
    if (filterByUrl)
      additionalTitleInfo = paste("\n  urlFilter =",urlFilter,
                                  "userLimit =", userLimit, "maxActiveTimeBinLimit =", maxActiveTimeBinLimit,
                                  "minActiveTimeBinLimit =",minActiveTimeBinLimit)
    else
      additionalTitleInfo = paste("\n  urlFilter = NO",
                                  "userLimit =", userLimit, "maxActiveTimeBinLimit =", maxActiveTimeBinLimit,
                                  "minActiveTimeBinLimit =",minActiveTimeBinLimit)
    
    activeTimeVsFeatureLatticeLinearPlot (data=plotData, 
                                          additionalTitleInfo=additionalTitleInfo, 
                                          featureToUse=featureToUse,
                                          maxUsers = 49,
                                          logariseFeature = logariseFeature,
                                          logariseActiveTime = logariseActiveTime,
                                          nRows = 7,
                                          nColumns = 7,
                                          updateProgress = updateProgress)
  })
  
  output$latticeMixedPlot <- renderPlot({
    print("output$latticeMixedPlot()")
    data()
    
    #SOURCE: http://shiny.rstudio.com/articles/progress.html
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "LATTICE MIXED LINEAR PLOT", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    # Create a callback function to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }
    
    ####SET DATA FOR LINEAR ANALYSIS
    if (filterByUrl)
      additionalTitleInfo = paste("\n  urlFilter =",urlFilter,
                                  "userLimit =", userLimit, "maxActiveTimeBinLimit =", maxActiveTimeBinLimit,
                                  "minActiveTimeBinLimit =",minActiveTimeBinLimit)
    else
      additionalTitleInfo = paste("\n  urlFilter = NO",
                                  "userLimit =", userLimit, "maxActiveTimeBinLimit =", maxActiveTimeBinLimit,
                                  "minActiveTimeBinLimit =",minActiveTimeBinLimit)
    
    mixedLinearModel = obtainMixedLinearModel()
    activeTimeVsFeatureLatticeMixedLinearPlot(data=plotData, 
                                              additionalTitleInfo=additionalTitleInfo, 
                                              linearModel = mixedLinearModel,
                                              featureToUse = featureToUse,
                                              ordinateToUse = ordinateToUse,
                                              maxUsers = 49,
                                              logariseFeature = logariseFeature,
                                              logariseActiveTime = logariseActiveTime,
                                              nRows = 7,
                                              nColumns = 7,
                                              updateProgress = updateProgress)    
    
  })
  
  output$mixedPlot <- renderPlot({
    print("output$mixedPlot()")
    data()
    
    #SOURCE: http://shiny.rstudio.com/articles/progress.html
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "MIXED LINEAR PLOT", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    # Create a callback function to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }
    
    ####SET DATA FOR LINEAR ANALYSIS
    if (filterByUrl)
      additionalTitleInfo = paste("\n  urlFilter =",urlFilter,
                                  "userLimit =", userLimit, "maxActiveTimeBinLimit =", maxActiveTimeBinLimit,
                                  "minActiveTimeBinLimit =",minActiveTimeBinLimit)
    else
      additionalTitleInfo = paste("\n  urlFilter = NO",
                                  "userLimit =", userLimit, "maxActiveTimeBinLimit =", maxActiveTimeBinLimit,
                                  "minActiveTimeBinLimit =",minActiveTimeBinLimit)
	###FIX FOR UIST!!!
    additionalTitleInfo =""
    
    mixedLinearModel = obtainMixedLinearModel()
    plotMixedModel(linearModel=mixedLinearModel,
                   dataframe=plotData,
                   featureToUse=featureToUse,
                   ordinateToUse=ordinateToUse,
                   logariseFeature = logariseFeature,
                   logariseActiveTime = logariseActiveTime,
                   plotCoefficients = FALSE,
                   additionalTitleInfo = additionalTitleInfo,
                   plotDataPoints = plotDataPoints,
                   groupingFactor = "sid",
                   updateProgress = updateProgress)
    
    
  })
  
  output$mixedDiagnose <- renderPlot({
    print("output$mixedDiagnose()")
    data()
    
    #SOURCE: http://shiny.rstudio.com/articles/progress.html
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "DIAGNOSIS PLOT", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    # Create a callback function to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }
    
    mixedLinearModel = obtainMixedLinearModel()
    
    diagnoseResiduals(mixedLinearModel = mixedLinearModel,
                      lookForInfluentialPoins = FALSE,
                      updateProgress = updateProgress)
  })
  
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    print("output$summary()")
    data()
    
    #SOURCE: http://shiny.rstudio.com/articles/progress.html
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "MIXED LINEAR PLOT SUMMARY", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    # Create a callback function to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }
    
    
    if (is.function(updateProgress)) {
      updateProgress(value = 1/2,
                     detail = paste("Calculating the Mixed Linear Model at ", Sys.time()))
    }
    
    mixedLinearModel = obtainMixedLinearModel()
    
    if (is.function(updateProgress)) {
      updateProgress(value = 2/2,
                     detail = paste("Reporting Mixed Linear Model at ", Sys.time()))
    }
    
    print("##################MODEL######################")
    #summary(mixedLinearModel)
    
    print("##################MODEL WITH MEMORY EFFECTS######################")
    mixedLinearModel = obtainMixedLinearModelMemoryEffects()
    #summary(mixedLinearModel)

    #summary(data())
  })
  
  # Generate an HTML table view of the data
  output$table <- renderTable({
    print("output$table()")
    print(paste("Number of rows should be:",nrow(plotData)))
    plotData
  })
  
  
  loadInputFromUI <- function(updateProgress = NULL){
    print("loadInputFromUI()")
    
    # If we were passed a progress update function, call it
    if (is.function(updateProgress)) {
      updateProgress(value = 1/5,
                     detail = paste("Loading input from the interface", " at ", Sys.time()))
    }
    
    featureToUse <<- input$featureToUse
    ordinateToUse <<- "calculatedActiveTime"
    
    urlFilter <<- input$urlFilter#"http://www.cs.manchester.ac.uk/"
    filterByUrl <<- input$filterByUrl#TRUE
    #urlFilter <<- "http://www.kupkb.org/tab0"
    
    userLimit <<- input$userLimit#500
    #Input for activeTimeThreshold is in minutes, need to transform it to ms
    activeTimeThreshold <<- input$activeTimeThreshold * 60 * 1000
    minActiveTimeBinLimit <<- input$activeTimeBin[1]#4
    maxActiveTimeBinLimit <<- input$activeTimeBin[2]#20
    
    #In case an xlimit is wanted, set it to -1 otherwise
    xlimit <<- input$xlimit#-1#200
    
    ###Parameters for the mixed linear model.
    logariseFeature <<- input$logariseFeature#TRUE
    logariseActiveTime <<- input$logariseActiveTime#TRUE
    plotAgainstBins <<- input$plotAgainstBins#FALSE
    plotDataPoints <<- input$plotDataPoints#FALSE
  }
  
  
  ######Processing the data according to the provided inputs
  processDataForPlots <- function(updateProgress = NULL){
    
    # If we were passed a progress update function, call it
    if (is.function(updateProgress)) {
      updateProgress(value = 2/5,
                     detail = paste("Starting processing of the data for the plots", " at ", Sys.time()))
    }
    
    print(paste("processDataForPlots():START at ", Sys.time()))
    processDataintoLogAndNotLog()
    print("processDataForPlots: getting plotData")
    plotData <<- nonLogarisedData
    
    ###################FILTERING PROCESS############
    #Filtering by url
    #   urlFilter = "http://www.cs.manchester.ac.uk/"
    #urlFilter = "http://www.kupkb.org/tab0"
    if (filterByUrl){
      print(paste("Filtering out events for url:",urlFilter, " at ", Sys.time()))
      plotData <<- plotData[plotData$url == urlFilter,]
    }
    else{
      print("NOT Filtering out events for url, all episodes for Web site are included")
    }  
    
    ###########CODE TO ADD CUSTOM FEATURES  
    #########USING THE FEATURE DIVIDED BY EPISODE DURATION
    #   plotData$mouseDistanceDivByEpisDurSec = plotData$mouseMoveTotalDistance / (plotData$urlEpisodeDurationms/1000)
    #   featureToUse = "mouseDistanceDivByEpisDurSec"
    
    print("Loading plotData and arranging bins")
    print("Thresholds are:")
    print(paste("featureToUse = ",featureToUse))
    print(paste("urlFilter = ",urlFilter))
    print(paste("userLimit = ",userLimit))
    print(paste("activeTimeThreshold = ",activeTimeThreshold))
    print(paste("minActiveTimeBinLimit = ",minActiveTimeBinLimit))
    print(paste("maxActiveTimeBinLimit = ",maxActiveTimeBinLimit))
    
    # If we were passed a progress update function, call it
    if (is.function(updateProgress)) {
      updateProgress(value = 3/5,
                     detail = paste("Filtering the data to the specified bins, ", minActiveTimeBinLimit," and ", maxActiveTimeBinLimit, " at ", Sys.time()))
    }
    
    plotData <<- activeTimeloadAndFilterDataByBins(plotData,
                                                   featureToUse,
                                                   urlFilter,
                                                   userLimit,
                                                   activeTimeThreshold,
                                                   minActiveTimeBinLimit,
                                                   maxActiveTimeBinLimit)
    
    # If we were passed a progress update function, call it
    if (is.function(updateProgress)) {
      updateProgress(value = 4/5,
                     detail = paste("Resetting the max bin and max user values if too high, at ", Sys.time()))
    }
    
    
    if (maxActiveTimeBinLimit > max(plotData$calculatedActiveTimeBins)){
      print(paste("maxActiveTimeBinLimit was too big!!! reset to plotData's max number", max(plotData$calculatedActiveTimeBins)))
      maxActiveTimeBinLimit =  max(plotData$calculatedActiveTimeBins)
    }
    
    if (userLimit > length(unique(plotData$sid))){
      print(paste("userLimit was too big!!! reset to data's number of users", length(unique(plotData$sid))))
      userLimit = length(unique(plotData$sid))
    }
    
    #####episodeDuration to minutes
    #If the feature to be used is episodeDuration, then I can scale it down to minutes (to increase readability, as opposed to ms)
    #if (featureToUse == "urlEpisodeDurationms"){
    #  plotData$urlEpisodeDurationMin <<- plotData$urlEpisodeDurationms/60/1000
    #  featureToUse = "urlEpisodeDurationMin"
    #}
    
    # If we were passed a progress update function, call it
    if (is.function(updateProgress)) {
      updateProgress(value = 5/5,
                     detail = paste("End of data processing for plots, at ", Sys.time()))
    }
    
    
    print(paste("processDataForPlots():END at ", Sys.time()))
  }
  
  
  obtainMixedLinearModel <- function(){
    print("obtainMixedLinearModel():START")
    print(ordinateToUse)
    
    mixedLinearModel = activeTimeVsFeatureMixedModel(plotData = plotData,
                                                     featureToUse = featureToUse,
                                                     ordinateToUse = ordinateToUse,
                                                     logariseFeature = logariseFeature,
                                                     logariseActiveTime = logariseActiveTime,
                                                     userLimit = userLimit,
                                                     filterByUrl = filterByUrl)
    
    return(mixedLinearModel)
  }
  
  obtainMixedLinearModelMemoryEffects <- function(){
    print("obtainMixedLinearModel():START")
    print(ordinateToUse)
    
    mixedLinearModel = activeTimeVsFeatureMixedModelMemoryEffects(plotData = plotData,
																 featureToUse = featureToUse,
																 ordinateToUse = ordinateToUse,
																 logariseFeature = logariseFeature,
																 logariseActiveTime = logariseActiveTime,
																 userLimit = userLimit,
																 filterByUrl = filterByUrl)
    
    return(mixedLinearModel)
  }
  
  
  print("shinyServer(): running code after functions are loaded")
  #data()
  #loadInputFromUI()
  #processDataForPlots()
  print("shinyServer(): end of initialisation, reactive actions start now")
})


##########################################ANALYSIS FUNCTIONS#################################################


##Code to create comparable visualisations of each of the episodes for appropriate features


#Before runnig this script, remember to run the code contained in "loadLoadAllEpisodes()"
processDataintoLogAndNotLog <- function(){
  print(paste("processDataintoLogAndNotLog():START at ", Sys.time()))
  #   urlToFilter = "http://www.cs.manchester.ac.uk/"
  #   #   
  #   print(paste("Processing CS data into logarised and non-logarised data from url: ",urlToFilter))
  #   #   
  #   filteredGlobalEpisodePool = globalEpisodePoolAllUrls[globalEpisodePoolAllUrls$url==urlToFilter,]
  
  print(paste("Processing CS data into logarised and non-logarised data from ALL urls"))
  globalEpisodePoolAllUrls = getEpisodeData()
  filteredGlobalEpisodePool = globalEpisodePoolAllUrls
  
  #Add total scroll distance per episode
  filteredGlobalEpisodePool$totalScrollAbs = filteredGlobalEpisodePool$positiveScroll + filteredGlobalEpisodePool$negativeScroll
  
  #   excludedColumns = c("sid", "sessionstartms", "urlSessionCounter", "urlEpisodeDurationms", "calculatedActiveTime")
  
  #   columnFilter = c("sid","url", "urlSessionCounter","urlSinceLastSession","calculatedActiveTime","urlEpisodeDurationms","numberOfMousewheel",
  #                    "positiveScroll","negativeScroll","totalScrollAbs","scrollControlledPosDelta", "scrollControlledNegDelta"
  #                    , "scrollControlledTotalDeltaAbs", "scrollControlledSpeed", "scrollControlledSpeedAbs",
  #                    "scrollControlledDuration")
  #   filteredGlobalEpisodePool = filteredGlobalEpisodePool[,names(filteredGlobalEpisodePool) %in% columnFilter]
  
  #Filter for a minimum number of occurrences per user
  #   occurrenceThreshold = 10
  #   print(paste("Leaving in users with more than ", occurrenceThreshold, " occurrences"))
  #   listOfUsers = names(table(filteredGlobalEpisodePool$sid)[table(filteredGlobalEpisodePool$sid)>occurrenceThreshold])
  #   filteredGlobalEpisodePool = filteredGlobalEpisodePool[filteredGlobalEpisodePool$sid %in% listOfUsers,]
  
  filteredGlobalEpisodePool$sid = factor(filteredGlobalEpisodePool$sid)
  
  filteredGlobalEpisodePool = filteredGlobalEpisodePool[filteredGlobalEpisodePool$calculatedActiveTime>0,]
  
  #######SET THE MISSING VALUES FOR PARTICULAR FEATURES FROM '0' TO 'NA'
  #The case of urlSinceLastSession is quite problematic, as we don't want to take into account the first occurrence...
  #filteredGlobalEpisodePool$urlSinceLastSession[filteredGlobalEpisodePool$urlSinceLastSession==0] = NA
  
  
  #first look for non ocurring scroll behaviours.
  
  controlledScrollZeroIndexList = (filteredGlobalEpisodePool$controlledScrollCounter==0)
  
  filteredGlobalEpisodePool$scrollControlledPosDelta[controlledScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollControlledNegDelta[controlledScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollControlledTotalDelta[controlledScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollControlledTotalDeltaAbs[controlledScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollControlledSpeed[controlledScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollControlledSpeedAbs[controlledScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollControlledDuration[controlledScrollZeroIndexList] = NA
  
  fastMouseScrollCycleZeroIndexList = (filteredGlobalEpisodePool$fastMouseScrollCycleCounter==0)
  
  filteredGlobalEpisodePool$scrollFastScrollCyclePosDelta[fastMouseScrollCycleZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastScrollCycleNegDelta[fastMouseScrollCycleZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastScrollCycleTotalDelta[fastMouseScrollCycleZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastScrollCycleTotalDeltaAbs[fastMouseScrollCycleZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastScrollCycleSpeed[fastMouseScrollCycleZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastScrollCycleSpeedAbs[fastMouseScrollCycleZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastScrollCycleDuration[fastMouseScrollCycleZeroIndexList] = NA
  
  fastSingleDirectionMouseScrollZeroIndexList = (filteredGlobalEpisodePool$fastSingleDirectionMouseScrollCounter==0)
  
  filteredGlobalEpisodePool$scrollFastSingleDirectPosDelta[fastSingleDirectionMouseScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastSingleDirectNegDelta[fastSingleDirectionMouseScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastSingleDirectTotalDelta[fastSingleDirectionMouseScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastSingleDirectTotalDeltaAbs[fastSingleDirectionMouseScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastSingleDirectSpeed[fastSingleDirectionMouseScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastSingleDirectSpeedAbs[fastSingleDirectionMouseScrollZeroIndexList] = NA
  filteredGlobalEpisodePool$scrollFastSingleDirectDuration[fastSingleDirectionMouseScrollZeroIndexList] = NA
  
  #I had reasons to set clicktimes from '0' to NA. I wrote them in the e-logbook, date 02/09/2014.
  #Basically, sometimes I get some mouseclick information, but not the rest. They should never ever be '0', so it's more solid to do it this way.
  #I changed it again!! Now instead of using each value, I use the "counter" for each value, which gives me the actual count.
  #Using always the "counter" makes my code more consistent, and prevents discarding values which could be '0'
  filteredGlobalEpisodePool$mouseClickSpeedClickTime[filteredGlobalEpisodePool$mouseClickSpeedCounter==0] = NA
  filteredGlobalEpisodePool$mouseIdleAfterClickTime[filteredGlobalEpisodePool$mouseIdleAfterClickCounter==0] = NA
  filteredGlobalEpisodePool$mouseTimeToClickTime[filteredGlobalEpisodePool$mouseTimeToClickCounter==0] = NA
  
  
  failToClickStreakZeroIndexList = (filteredGlobalEpisodePool$mouseFailToClickCounter==0)
  filteredGlobalEpisodePool$mouseFailToClickStreakDuration[failToClickStreakZeroIndexList] = NA
  filteredGlobalEpisodePool$mouseFailToClickDistanceBetweenClicks[failToClickStreakZeroIndexList] = NA
  filteredGlobalEpisodePool$mouseFailToClickNumberOfClicks[failToClickStreakZeroIndexList] = NA
  
  mouseLackOfMousePrecisionZeroIndexList = (filteredGlobalEpisodePool$mouseLackOfMousePrecisionCounter==0)
  filteredGlobalEpisodePool$mouseLackOfMousePrecisionFirstMouseOverTime[mouseLackOfMousePrecisionZeroIndexList] = NA
  filteredGlobalEpisodePool$mouseLackOfMousePrecisionNumberOfMouseOver[mouseLackOfMousePrecisionZeroIndexList] = NA
  
  mouseLackOfMousePrecisionZeroIndexList = (filteredGlobalEpisodePool$mouseRepeatedClicksCounter==0)
  filteredGlobalEpisodePool$mouseRepeatedClicksNumberOfClicks[mouseLackOfMousePrecisionZeroIndexList] = NA
  filteredGlobalEpisodePool$mouseRepeatedClicksTimeBetweenClicks[mouseLackOfMousePrecisionZeroIndexList] = NA
  
  
  
  ###Discarding the mouseOverevents whose mouseOver events were not valid....
  #First look for episodes in which incorrect mouseover take place
  incorrectMouseOverIndexList = (filteredGlobalEpisodePool$mouseMoveIncorrectMouseOverCount > 0)
  
  #Then set the corresponding distances and values to NA
  filteredGlobalEpisodePool$mouseMoveTotalDistance[incorrectMouseOverIndexList] = NA
  filteredGlobalEpisodePool$mouseMoveStartTimems[incorrectMouseOverIndexList] = NA
  filteredGlobalEpisodePool$mouseMoveEndTimems[incorrectMouseOverIndexList] = NA
  
  #I will also set the '0' remaining distances to NA.
  #These '0' distances came from episodes in which only 1 mouseover or mousemove event was registered.
  filteredGlobalEpisodePool$mouseMoveTotalDistance[filteredGlobalEpisodePool$mouseMoveTotalDistance == 0] = NA
  
  ##If there is '0' mouse idle time, then there was no idle time at all.
  filteredGlobalEpisodePool$mouseMeanIdleTimeDuration[filteredGlobalEpisodePool$mouseMeanIdleTimeDuration == 0] = NA
  filteredGlobalEpisodePool$mouseMedianIdleTimeDuration[filteredGlobalEpisodePool$mouseMedianIdleTimeDuration == 0] = NA
  
  
  #Divide the data into logarised and not logarised
  logarisedData <<- filteredGlobalEpisodePool
  nonLogarisedData <<- filteredGlobalEpisodePool
  
  logarisedData$calculatedActiveTime <<- signedlog10(logarisedData$calculatedActiveTime)
  logarisedData$scrollControlledPosDelta <<- signedlog10(logarisedData$scrollControlledPosDelta)
  logarisedData$scrollControlledNegDelta <<- signedlog10(logarisedData$scrollControlledNegDelta)
  logarisedData$scrollControlledSpeedAbs <<-  signedlog10(logarisedData$scrollControlledSpeedAbs)
  logarisedData$scrollControlledDuration <<- signedlog10(logarisedData$scrollControlledDuration)
  logarisedData$totalScrollAbs <<- signedlog10(logarisedData$totalScrollAbs)
  logarisedData$urlEpisodeDurationms <<- signedlog10(logarisedData$urlEpisodeDurationms)
  logarisedData$urlSinceLastSession <<- signedlog10(logarisedData$urlSinceLastSession)
  
  logarisedData$episodeDurationms <<- signedlog10(logarisedData$episodeDurationms)
  logarisedData$sdTimeSinceLastSession <<- signedlog10(logarisedData$sdTimeSinceLastSession)
  
  #   #Some features would work better if normalised
  #   sessionstartmsMean <- mean(logarisedData$sessionstartms)
  #   logarisedData$sessionstartms <<- logarisedData$sessionstartms - sessionstartmsMean
  
  print(paste("processDataintoLogAndNotLog():END at ", Sys.time()))
}



#This function gets the data obtains from "processDataintoLogAndNotLog", and adds the 
#active time bin values. It also filters the data according to certain parameters

activeTimeloadAndFilterDataByBins <- function(ggplotHistData = nonLogarisedData,
                                              featureToUse = "urlEpisodeDurationms",
                                              urlFilter = "http://www.cs.manchester.ac.uk/",
                                              userLimit = 500,
                                              activeTimeThreshold = 0.5 * 60 * 1000,
                                              minActiveTimeBinLimit = 20,
                                              maxActiveTimeBinLimit = 20){
  
  
  print(paste("activeTimeloadAndFilterDataByBins():START at ", Sys.time()))
  #In some cases some values for that feature are NA, we will filter out those ones.
  naFeatureIndexList = is.na(ggplotHistData[[featureToUse]])
  print(paste("Filtering out ",length(naFeatureIndexList[naFeatureIndexList])," NA elements out of ",
              nrow(ggplotHistData)," for ",featureToUse, " at ", Sys.time()))
  ggplotHistData = ggplotHistData[!naFeatureIndexList,]
  
  #########Do I want to manually scale values? if so, do it in the next lines
  
  
  ##Do we want to limit the users to get only the "x" most prominent ones?
  #userLimit = length(unique(ggplotHistData$sid))#20
  #   userLimit = 500
  print(paste("Filtering out down to top ", userLimit, "users", " at ", Sys.time()))
  if (userLimit > length(unique(ggplotHistData$sid)))
    userLimit = length(unique(ggplotHistData$sid))
  
  topUsers = names(sort(table(ggplotHistData$sid),decreasing = TRUE)[1:userLimit])
  ggplotHistData = ggplotHistData[ggplotHistData$sid %in% topUsers,]
  print(paste("Filtered down to ", nrow(ggplotHistData), "records"))
  
  
  #In order to plot calculatedAcitve time in the same way as the urlEpisodes,
  #I need to set certain thresholds for the creation of bins.
  #I'll start with 10 minutes, and see where that takes me
  #   activeTimeThreshold = 0.5 * 60 * 1000
  ggplotHistData$calculatedActiveTimeBins =  round(ggplotHistData$calculatedActiveTime / activeTimeThreshold)
  
  
  ##We can also limit the analysis to the users who appear a minimum number of times
  #userLimit = length(unique(ggplotHistData$sid))#20
  #   minActiveTimeBinLimit = 20
  print(paste("Filtering out users without a minimum of ", minActiveTimeBinLimit, " at ", Sys.time()))
  for (userIndex in unique(ggplotHistData$sid)){
    #if the given user's active time bin counter is smaller than threshold, we remove it
    if (max(ggplotHistData[ggplotHistData$sid == userIndex,]$calculatedActiveTimeBins) < minActiveTimeBinLimit){
      ggplotHistData = ggplotHistData[ggplotHistData$sid != userIndex,]
    }
  }
  print(paste("Filtered down to ", nrow(ggplotHistData), "records"))
  
  
  
  #We can limit the histogram to the first "x" bins of activeTime, so it's more visible
  #   maxActiveTimeBinLimit = 20
  print(paste("Filtering out any bin beyond ",maxActiveTimeBinLimit," to avoid oversignificance at ", Sys.time()))
  
  ggplotHistData = ggplotHistData[ggplotHistData$calculatedActiveTimeBins <= maxActiveTimeBinLimit,]
  
  print(paste("Returning data object with ",nrow(ggplotHistData), " rows"))
  
  print(paste("activeTimeloadAndFilterDataByBins():END at ", Sys.time()))
  
  return (ggplotHistData)
  
}

activeTimeVsFeatureDensityVisualisations <- function(ggplotHistData,
                                                     featureToUse = "urlEpisodeDurationms",
                                                     urlFilter = "http://www.cs.manchester.ac.uk/",
                                                     userLimit = 500,
                                                     activeTimeThreshold = 0.5 * 60 * 1000,
                                                     minActiveTimeBinLimit = 20,
                                                     maxActiveTimeBinLimit = 20,
                                                     xlimit = -1,
                                                     updateProgress = NULL){
  print(paste("activeTimeVsFeatureDensityVisualisations() with xlimit=",xlimit))
  ##############AVERAGE values per activeTimeBin
  ####For this graph I will take the average/mean value for each user, to show a unique value per activity bin.
  avgGgplotHistData = data.frame(sid = character(),
                                 count =  as.numeric(character()),
                                 featureMean = as.numeric(character()),
                                 featureMedian =as.numeric(character()),
                                 calculatedActiveTimeBins =as.numeric(character()),
                                 stringsAsFactors = FALSE)
  #print(typeof(ggplotHistData))
  print(paste("Calculating the mean and median values of ", length(unique(ggplotHistData$sid))," users", " at ", Sys.time()))
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 1/5,
                   detail = paste("Calculating the mean and median values of ", length(unique(ggplotHistData$sid))," users", " at ", Sys.time()))
  }
  
  #For each user, and for each activeTimeBin, get the average, and add it to the frame.
  for (userIndex in unique(ggplotHistData$sid)){
    # print(paste("Processing user ",userIndex))
    userHistDataTemp = ggplotHistData[ggplotHistData$sid == userIndex,]
    for (binIndex in unique(userHistDataTemp$calculatedActiveTimeBins)){
      #print(paste("Processing user ",userIndex, " in bin number: ",binIndex))
      avgGgplotHistData[nrow(avgGgplotHistData)+1,] = 
        list(sid = userIndex,
             count = nrow(userHistDataTemp[userHistDataTemp$calculatedActiveTimeBins == binIndex,]),
             featureMean = mean(as.numeric(userHistDataTemp[userHistDataTemp$calculatedActiveTimeBins == binIndex,][[featureToUse]])),
             featureMedian = median(as.numeric(userHistDataTemp[userHistDataTemp$calculatedActiveTimeBins == binIndex,][[featureToUse]])),
             "calculatedActiveTimeBins" = binIndex)
      #str(mean(as.numeric(userHistDataTemp[userHistDataTemp$calculatedActiveTimeBins == binIndex,][[featureToUse]])))
    }
  }
  
  print(paste("Setting the labels for the activeTime bins for ", maxActiveTimeBinLimit," bins", " at ", Sys.time()))
  
  #I will add the amount of users for each bin (looks dirty, but it's simple to do so it appears in the legend.)
  for (binIndex in 0:maxActiveTimeBinLimit){
    labelToSet =  paste("bin ",binIndex, " with ",nrow(ggplotHistData[ggplotHistData$calculatedActiveTimeBins == binIndex,])," users.")
    ggplotHistData$calculatedActiveTimeBins[ggplotHistData$calculatedActiveTimeBins == binIndex] = labelToSet
    
    labelToSet =  paste("bin ",binIndex, " with ",nrow(avgGgplotHistData[avgGgplotHistData$calculatedActiveTimeBins == binIndex,])," users.")
    avgGgplotHistData$calculatedActiveTimeBins[avgGgplotHistData$calculatedActiveTimeBins == binIndex] = labelToSet
    
  }
  
  
  #We factorise them for them to be used in the plot.
  ggplotHistData$calculatedActiveTimeBins =  as.factor(ggplotHistData$calculatedActiveTimeBins)
  
  print(paste("Plotting distribution per active time bin for the first ",maxActiveTimeBinLimit," bins of ",activeTimeThreshold/60/1000," minutes for feature ",
              featureToUse, " at ", Sys.time()))
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 2/5,
                   detail = paste("Plotting distribution per active time bin for the first ",maxActiveTimeBinLimit," bins of ",activeTimeThreshold/60/1000," minutes for feature ",
                                  featureToUse, " at ", Sys.time()))
  }
  
  if (xlimit==-1){
    histPlot1 = ggplot(data=ggplotHistData, aes_string(featureToUse, color= "calculatedActiveTimeBins"))  +
      geom_density(alpha = 0.1) + 
      ggtitle(paste(featureToUse, " distribution per active time bin for the top "
                    ,userLimit,"users,\n with a minimum of ", minActiveTimeBinLimit," active bins in bins of ",activeTimeThreshold/60/1000," minutes"))
  }
  else{
    histPlot1 = ggplot(data=ggplotHistData, aes_string(featureToUse, color= "calculatedActiveTimeBins"))  +
      geom_density(alpha = 0.1) + 
      xlim(0, xlimit) + 
      ggtitle(paste(featureToUse, " distribution per active time bin for the top "
                    ,userLimit,"users,\n with a minimum of ", minActiveTimeBinLimit," active bins in bins of "
                    ,activeTimeThreshold/60/1000," minutes, and xlimit ", xlimit ))
  }
  #print(histPlot1)
  
  ################AVERAGE AND MEDIAN PLOTS
  #We factorise them for them to be used in the plot.
  avgGgplotHistData$calculatedActiveTimeBins =  as.factor(avgGgplotHistData$calculatedActiveTimeBins)
  
  print(paste("Plotting mean per user distribution of the first ",maxActiveTimeBinLimit," bins of ",activeTimeThreshold/60/1000," minutes for feature ",
              featureToUse, " at ", Sys.time()))
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 3/5,
                   detail = paste("Plotting mean per user distribution of the first ",maxActiveTimeBinLimit," bins of ",activeTimeThreshold/60/1000," minutes for feature ",
                                  featureToUse, " at ", Sys.time()))
  }
  
  if (xlimit==-1){
    histPlot2 = ggplot(data=avgGgplotHistData, aes(featureMean, color= calculatedActiveTimeBins))  +
      geom_density(alpha = 0.1) + #xlim(0, 120000) + 
      ggtitle(paste(featureToUse, " MEAN per user distribution per episode for the top "
                    ,userLimit,"users, in bins of ",activeTimeThreshold/60/1000," minutes"))
  }
  else{
    histPlot2 = ggplot(data=avgGgplotHistData, aes(featureMean, color= calculatedActiveTimeBins))  +
      geom_density(alpha = 0.1)+
      xlim(0, xlimit) + 
      ggtitle(paste(featureToUse, " MEAN per user distribution per episode for the top "
                    ,userLimit,"users, in bins of ",activeTimeThreshold/60/1000," minutes, and xlimit ", xlimit ))
  }
  
  
  #print(histPlot2)
  
  print(paste("Plotting median per user distribution of
              the first ",maxActiveTimeBinLimit," bins of ",activeTimeThreshold/60/1000," minutes for feature ",
              featureToUse, " at ", Sys.time()))
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 4/5,
                   detail = paste("Plotting median per user distribution of the first ",maxActiveTimeBinLimit," bins of ",activeTimeThreshold/60/1000," minutes for feature ",
                                  featureToUse, " at ", Sys.time()))
  }
  
  if (xlimit==-1){
    histPlot3 = ggplot(data=avgGgplotHistData, aes_string("featureMedian", color= "calculatedActiveTimeBins"))  +
      geom_density(alpha = 0.1) + #xlim(0, 120000) + 
      ggtitle(paste(featureToUse, " MEDIAN per user distribution per episode for the top "
                    ,userLimit,"users, in bins of ",activeTimeThreshold/60/1000," minutes"))
  }
  else{
    histPlot3 = ggplot(data=avgGgplotHistData, aes_string("featureMedian", color= "calculatedActiveTimeBins"))  +
      geom_density(alpha = 0.1) +
      xlim(0, xlimit) + 
      ggtitle(paste(featureToUse, " MEDIAN per user distribution per episode for the top "
                    ,userLimit,"users, in bins of ",activeTimeThreshold/60/1000," minutes, and xlimit ", xlimit ))
  }
  
  #print(histPlot3)
  
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 5/5,
                   detail = paste("Plotting all plots together at ", Sys.time()))
  }
  
  multiplot(histPlot1, histPlot2, histPlot3, cols=1)
  ##########
  
}

activeTimeVsFeatureLineVisualisations <- function(ggplotHistData,
                                                  featureToUse = "urlEpisodeDurationms",
                                                  urlFilter = "http://www.cs.manchester.ac.uk/",
                                                  userLimit = 500,
                                                  activeTimeThreshold = 0.5 * 60 * 1000,
                                                  minActiveTimeBinLimit = 20,
                                                  maxActiveTimeBinLimit = 20,
                                                  updateProgress = NULL){
  print(paste("activeTimeVsFeatureLineVisualisations():START at ", Sys.time()))
  print("Calculating averages and medians")
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 1/3,
                   detail = paste("Calculating averages and medians at ", Sys.time()))
  }
  
  print(paste("ggplotHistData has ",nrow(ggplotHistData)," rows"))
  averageFeatureValue=c()
  medianFeatureValue = c()
  
  averageTimeSinceValue=c()
  medianTimeSinceValue = c()
  
  userNumber = c()
  
  maxActiveTimeBinIndex = maxActiveTimeBinLimit
  if (maxActiveTimeBinIndex > max(as.numeric(ggplotHistData$calculatedActiveTimeBins)))
    maxActiveTimeBinIndex = max(as.numeric(ggplotHistData$calculatedActiveTimeBins))
  
  for(i in 1:maxActiveTimeBinIndex){
    #print(paste("episodeIndex is ", i))
    
    episodeFeatureValue = ggplotHistData[ggplotHistData$calculatedActiveTimeBins==i,][[featureToUse]]
    
    #Filter the NA out
    episodeFeatureValue = episodeFeatureValue[!is.na(episodeFeatureValue)]
    
    averageFeatureValue = c(averageFeatureValue,(mean(episodeFeatureValue)))
    medianFeatureValue = c(medianFeatureValue,(median(episodeFeatureValue)))
    
    episodeTimeSinceValue = ggplotHistData[ggplotHistData$calculatedActiveTimeBins==i,]$urlSinceLastSession
    averageTimeSinceValue=c(averageTimeSinceValue, (mean(episodeTimeSinceValue)))
    medianTimeSinceValue = c(medianTimeSinceValue, (median(episodeTimeSinceValue)))
    
    userNumber = c(userNumber,length(unique(ggplotHistData[ggplotHistData$calculatedActiveTimeBins==i,]$sid)))
    print(paste("number of users for bin number ",i," was ",length(unique(ggplotHistData[ggplotHistData$calculatedActiveTimeBins==i,]$sid))))
  }
  
  print("Calculating ")
  print(paste("Plotting averages and medians for the first ",maxActiveTimeBinIndex, " for feature ",featureToUse))
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 2/3,
                   detail = paste("Plotting averages and medians for the first ",maxActiveTimeBinIndex, " for feature ", featureToUse, " at ", Sys.time()))
  }
  
  gPlotFrame <- data.frame(averageFeatureValue,medianFeatureValue,
                           averageTimeSinceValue,medianTimeSinceValue,
                           userNumber, activeTimeBinCounter = 1:maxActiveTimeBinIndex)
  gPlotFrameGlobal <<- gPlotFrame
  
  featureValuePlot = ggplot(data=gPlotFrame, aes(activeTimeBinCounter)) +
    ggtitle(paste("Average and median of ",featureToUse)) + 
    geom_line(aes(y = averageFeatureValue, colour = "averageValue")) + 
    geom_line(aes(y = medianFeatureValue, colour = "medianValue"))
  
  timeSinceValuePlot = ggplot(data=gPlotFrame, aes(activeTimeBinCounter)) +
    ggtitle(paste("Average and median of TimeSince")) + 
    geom_line(aes(y = averageTimeSinceValue, colour = "averageValue")) + 
    geom_line(aes(y = medianTimeSinceValue, colour = "medianValue"))
  
  userCountPlot = ggplot(data=gPlotFrame, aes(activeTimeBinCounter)) + 
    geom_line(aes(y = userNumber, colour = "userNumber"))
  
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 3/3,
                   detail = paste("Plotting all plots together at ", Sys.time()))
  }
  
  multiplot(featureValuePlot, timeSinceValuePlot,userCountPlot, cols=1)
  print(paste("activeTimeVsFeatureLineVisualisations():END at ", Sys.time()))
}

######MIXED LINEAR MODEL
#I'll plot a mixed linear model with the data I have from the users, so I get the whole picture.
activeTimeVsFeatureMixedModel <- function(plotData,
                                          featureToUse = "urlEpisodeDurationms",
                                          ordinateToUse = "calculatedActiveTime",
                                          logariseFeature = FALSE,
                                          logariseActiveTime = FALSE,
                                          userLimit = 500,
                                          filterByUrl = FALSE){
  
  print(paste("activeTimeVsFeatureMixedModel():START at ", Sys.time()))
  print(ordinateToUse)
  mixedModelData = plotData
  
  if(logariseFeature){
    print(paste("Logarising ", featureToUse))
    mixedModelData[[featureToUse]] = signedlog10(mixedModelData[[featureToUse]])
  }
  if(logariseActiveTime){
    print(paste("Logarising ", ordinateToUse))
    mixedModelData[[ordinateToUse]] = signedlog10(mixedModelData[[ordinateToUse]])
  }
  
  
  if (filterByUrl){
    print("Data was filtered by url, obtaining model")
    lme4RanEffect <- 
      lmer(get(ordinateToUse) ~ get(featureToUse)
           + (1 + get(featureToUse)|sid), data = mixedModelData)
    print(summary(lme4RanEffect))
  }
  else{
    print("Data was not filtered by url, adding url as fixed effect")
    mixedModelData = data
    mixedModelData$url = as.character(mixedModelData$url)
    mixedModelData$url = as.factor(mixedModelData$url)
    
    mixedModelData$sid = as.character(mixedModelData$sid)
    mixedModelData$sid = as.factor(mixedModelData$sid)
    
    
    ####I still need to decide which one to use....
    lme4RanEffect <- 
      lmer(get(ordinateToUse) ~ get(featureToUse) + (1 + get(featureToUse)|url)
           + (1 + get(featureToUse)|sid), data = mixedModelData)
    
    lme4RanEffect <- 
      lmer(get(ordinateToUse) ~ get(featureToUse) + (1 + get(featureToUse)|url/sid)
           , data = mixedModelData)
    
    summary(lme4RanEffect)
  }
  
  #diagnoseResiduals(lme4RanEffect,lookForInfluentialPoins = FALSE)
  
  #summary(lme4RanEffect)
  
  print(paste("activeTimeVsFeatureMixedModel():END at ", Sys.time()))
  
  return (lme4RanEffect)
}


#####Mixed model with Memory effects

#I'll plot a mixed linear model with the data I have from the users, so I get the whole picture.
activeTimeVsFeatureMixedModelMemoryEffects <- function(plotData,
                                          featureToUse = "urlEpisodeDurationms",
                                          ordinateToUse = "calculatedActiveTime",
                                          logariseFeature = FALSE,
                                          logariseActiveTime = FALSE,
                                          userLimit = 500,
                                          filterByUrl = FALSE){
  
  print(paste("activeTimeVsFeatureMixedModel():START at ", Sys.time()))
  print(ordinateToUse)
  mixedModelData = plotData
  
  if(logariseFeature){
    print(paste("Logarising ", featureToUse))
    mixedModelData[[featureToUse]] = signedlog10(mixedModelData[[featureToUse]])
  }
  if(logariseActiveTime){
    print(paste("Logarising ", ordinateToUse))
    mixedModelData[[ordinateToUse]] = signedlog10(mixedModelData[[ordinateToUse]])
  }
  
  
  if (filterByUrl){
    print("Data was filtered by url, obtaining model")
    lme4RanEffect <- 
      lmer(get(ordinateToUse) ~ get(featureToUse) + urlSinceLastSession
           + (1 + get(featureToUse)|sid), data = mixedModelData)
    print(summary(lme4RanEffect))
  }
  else{
    print("Data was not filtered by url, adding url as fixed effect")
    mixedModelData = data
    mixedModelData$url = as.character(mixedModelData$url)
    mixedModelData$url = as.factor(mixedModelData$url)
    
    mixedModelData$sid = as.character(mixedModelData$sid)
    mixedModelData$sid = as.factor(mixedModelData$sid)
    
    
    ####I still need to decide which one to use....
    lme4RanEffect <- 
      lmer(get(ordinateToUse) ~ get(featureToUse) + (1 + get(featureToUse)|url)
           + (1 + get(featureToUse)|sid), data = mixedModelData)
    
    lme4RanEffect <- 
      lmer(get(ordinateToUse) ~ get(featureToUse) + (1 + get(featureToUse)|url/sid)
           , data = mixedModelData)
    
    summary(lme4RanEffect)
  }
  
  #diagnoseResiduals(lme4RanEffect,lookForInfluentialPoins = FALSE)
  
  #summary(lme4RanEffect)
  
  print(paste("activeTimeVsFeatureMixedModel():END at ", Sys.time()))
  
  return (lme4RanEffect)
}


###Code to create a lattice graph with all the groups with just the linear model for each user
activeTimeVsFeatureLatticeLinearPlot <-function(data,
                                                additionalTitleInfo,
                                                maxUsers = 49,
                                                featureToUse = "mouseMedianIdleTimeDuration",
                                                ordinateToUse = "calculatedActiveTime",
                                                logariseFeature = FALSE,
                                                logariseActiveTime = FALSE,
                                                nRows = 7,
                                                nColumns = 7,
                                                updateProgress = NULL){
  
  print(paste("activeTimeVsFeatureLatticeLinearPlot():START at ", Sys.time()))
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 1/3,
                   detail = paste("Start of the Lattice plot data calculation at ", Sys.time()))
  }
  
  if(logariseFeature){
    newFeatureLabel = paste(featureToUse,"_log10",sep="")
    data[[newFeatureLabel]] = signedlog10(data[[featureToUse]])
    featureToUse = newFeatureLabel
  }
  if(logariseActiveTime){
    newOrdinateToUse = paste(ordinateToUse,"_log10",sep="")
    data[[newOrdinateToUse]] = signedlog10(data[[ordinateToUse]])
    ordinateToUse = newOrdinateToUse
  }
  
  print(paste("Processing ",length(unique(data$sid)), " users, when the max number is: ",maxUsers))
  #If we have too many users, we narrow them down. We will only show a sample of them
  if (length(unique(data$sid))>maxUsers){
    sidList = unique(data$sid)[1:maxUsers]
    data = data[data$sid %in% sidList,]
  }
  
  
  plotTitle = paste(ordinateToUse,"~",featureToUse,additionalTitleInfo)
  
  colors.withinSubjectIncreasing = "green"
  colors.withinSubjectDecreasing = "darkgreen"
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 2/3,
                   detail = paste("Calculating data for ", maxUsers, " users at ", Sys.time()))
  }
  
  p <- dotplot(get(ordinateToUse) ~ get(featureToUse) | sid, data, scale=list(y=list(cex=.4)),
               xlab=featureToUse, ylab=ordinateToUse,
               main = plotTitle,
               layout = c(nRows,nColumns),
               panel = function(x, y) {
                 panelIndex = panel.number()
                 panel.xyplot(x, y,t="p", pch = ".",cex = 3)
                 
                 if (coef(lm(y ~ x))[2] > 0)
                   panel.abline(lm(y ~ x),col=colors.withinSubjectIncreasing,lty =1,lwd=2)
                 else
                   panel.abline(lm(y ~ x),col=colors.withinSubjectDecreasing,lty =1,lwd=2)
               },
               auto.key=list(
                 text=c("Within-subject increasing",
                        "Within-subject decreasing"),
                 cex.title=1,
                 lines=TRUE, points=FALSE,
                 space="top", columns=3, pch="-", cex=.8,
                 lwd = 5,
                 lty = c(1,2,3)),
               par.settings = simpleTheme(lwd = 5,
                                          col = c(colors.withinSubjectIncreasing,colors.withinSubjectDecreasing))
               
  )
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 3/3,
                   detail = paste("Plotting lattice plot at ", Sys.time()))
  }
  plot(p)
  print(paste("activeTimeVsFeatureLatticeLinearPlot():END at ", Sys.time()))
}

###Code to create a lattice graph with all the groups from a particular given mixed model
activeTimeVsFeatureLatticeMixedLinearPlot <-function(data,
                                                     additionalTitleInfo,
                                                     linearModel,
                                                     maxUsers = 49,
                                                     featureToUse = "mouseMedianIdleTimeDuration",
                                                     ordinateToUse = "calculatedActiveTime",
                                                     logariseFeature = FALSE,
                                                     logariseActiveTime = FALSE,
                                                     nRows = 7,
                                                     nColumns = 7,
                                                     updateProgress = NULL){
  
  print(paste("activeTimeVsFeatureLatticeMixedLinearPlot():START at ", Sys.time()))
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 1/3,
                   detail = paste("Start of the Lattice Mixed Linear plot data calculation at ", Sys.time()))
  }
  
  print(paste("Lattice plot of ",featureToUse))
  if(logariseFeature){
    newFeatureLabel = paste(featureToUse,"_log10",sep="")
    data[[newFeatureLabel]] = signedlog10(data[[featureToUse]])
    featureToUse = newFeatureLabel
    print(paste(featureToUse," will be logarised"))
  }
  if(logariseActiveTime){
    newOrdinateToUse = paste(ordinateToUse,"_log10",sep="")
    data[[newOrdinateToUse]] = signedlog10(data[[ordinateToUse]])
    ordinateToUse = newOrdinateToUse
  }
  
  
  coefs <- coef(linearModel) # save the coefficients of this model
  coefList = coefs[["sid"]]
  
  #If we have too many users, we narrow them down. We will only show a sample of them
  if (nrow(coefList)>maxUsers){
    coefList = coefList[1:maxUsers,]
    sidList = rownames(coefList)
    data = data[data$sid %in% sidList,]
  }
  
  #Draw the main predicted line
  mainIntercept = as.numeric(fixef(linearModel)[1])
  mainSlope = as.numeric(fixef(linearModel)[2])
  
  
  plotTitle = paste(ordinateToUse,"~",featureToUse,additionalTitleInfo)
  
  colors.withinSubjectIncreasing = "green"
  colors.withinSubjectDecreasing = "darkgreen"
  colors.mixedModelIncreasing = "red"
  colors.mixedModelDecreasing = "darkred"
  colors.populationIncreasing = "gray54"
  colors.populationDecreasing = "black"
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 1/3,
                   detail = paste("Start of the Lattice Mixed Linear plot data calculation at ", Sys.time()))
  }
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 2/3,
                   detail = paste("Calculating data for ", maxUsers, " users at ", Sys.time()))
  }
  
  p <- dotplot(get(ordinateToUse) ~ get(featureToUse) | sid, data, scale=list(y=list(cex=.4)),
               xlab=featureToUse, ylab=ordinateToUse,
               main = plotTitle,
               ylim = c(-20,200),
               #layout = c(nRows,nColumns),
               panel = function(x, y) {
                 panelIndex = panel.number()
                 panel.xyplot(x, y,t="p", pch = ".",cex = 3)
                 
                 if (coef(lm(y ~ x))[2] > 0)
                   panel.abline(lm(y ~ x),col=colors.withinSubjectIncreasing,lty =1,lwd=2)
                 else
                   panel.abline(lm(y ~ x),col=colors.withinSubjectDecreasing,lty =1,lwd=2)
                 
                 if(coefList[panelIndex,1] > 0)
                   panel.abline(a=coefList[panelIndex,1], b=coefList[panelIndex,2],col=colors.mixedModelIncreasing,lty =1,lwd=2)
                 else
                   panel.abline(a=coefList[panelIndex,1], b=coefList[panelIndex,2],col=colors.mixedModelDecreasing,lty =1,lwd=2)
                 
                 if (mainSlope > 0)
                   panel.abline(a=mainIntercept, b=mainSlope,col=colors.populationIncreasing,lty =1,lwd=2)
                 else
                   panel.abline(a=mainIntercept, b=mainSlope,col=colors.populationDecreasing,lty =1,lwd=2)
                                  
#                                   print(paste("PANEL INDEX IS:",panelIndex))
#                                   print(x)
#                                   print(y)
#                                   print(paste("within user"," with ",lm(y ~ x)[[1]][1],",",lm(y ~ x)[[1]][2]))
#                                   print(paste("MixedModel"," with ",coefList[panelIndex,1],",",coefList[panelIndex,2]))
#                                   print(paste("MAIN"," with ",mainIntercept,",",mainSlope))
               },
               auto.key=list(
                 text=c("Within-subject increasing",
                        "Within-subject decreasing",
                        "Mixed Model increasing", 
                        "Mixed Model decreasing", 
                        "Population increasing",
                        "Population decreasing"),
                 cex.title=1,
                 lines=TRUE, points=FALSE,
                 space="top", columns=3, pch="-", cex=.8,
                 #fill = c(colors.withinSubject,colors.mixedModel,colors.population),
                 lwd = 5,
                 lty = c(1,2,3)),
               par.settings = simpleTheme(lwd = 5,
                                          col = c(colors.withinSubjectIncreasing,colors.withinSubjectDecreasing,
                                                  colors.mixedModelIncreasing,colors.mixedModelDecreasing,
                                                  colors.populationIncreasing,colors.populationDecreasing))
               
  )
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 3/3,
                   detail = paste("Plotting lattice Mixed linear plot at ", Sys.time()))
  }
  
  plot(p)
  print(paste("activeTimeVsFeatureLatticeMixedLinearPlot():END at ", Sys.time()))
}


#Way to call this function:
#plotMixedModel(lme4MouseWithObject,normalisedMouseBehaviourFrame,"mouseTimeToClick","calculatedActiveTime")
plotMixedModel <- function(linearModel=NULL,
                           dataframe=NULL,
                           featureToUse="scrollControlledSpeedAbs",
                           ordinateToUse="calculatedActiveTime",
                           logariseFeature = TRUE,
                           logariseActiveTime = TRUE,
                           plotCoefficients = TRUE,
                           plotDataPoints = TRUE,
                           additionalTitleInfo = "",
                           groupingFactor = "sid",
                           updateProgress = NULL,
                           xRangeLimit = c(-1,-1),
                           yRangeLimit = c(-1,-1)){
  
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    updateProgress(value = 1/4,
                   detail = paste("Start of plotting Linear Mixed Model at ", Sys.time()))
  }
  
  mixedModelData = dataframe
  
  if(logariseFeature){
    print(paste("Logarising ", featureToUse))
    mixedModelData[[featureToUse]] = signedlog10(mixedModelData[[featureToUse]])
  }
  if(logariseActiveTime){
    print(paste("Logarising ", ordinateToUse))
    mixedModelData[[ordinateToUse]] = signedlog10(mixedModelData[[ordinateToUse]])
  }

  plotTitle = paste(ordinateToUse,"~",featureToUse,additionalTitleInfo)
  
  classes <- as.numeric(mixedModelData$sid) # choose data classes: flood frequency 1,2,3
  pchDots <<- c(0:18)#[as.numeric(mixedModelData$sid)]
  
  #Do we have axis limits? If datapoints are plotted, they datapoints limits will determine the axis
  
  if (plotDataPoints){
    plotXlim = c(min(mixedModelData[[featureToUse]]),max(mixedModelData[[featureToUse]]))
    plotYlim = c(min(mixedModelData[[ordinateToUse]]),max(mixedModelData[[ordinateToUse]]))
    pchPlot=pchDots
  }
  else{
    plotXlim = NULL
    plotYlim = NULL
    pchPlot=''
  }
  
  #if we are given limits as paratemers, we override those limits
  #(we compare them with -1-1 because it's their default value if no parameter is given)
  if (!identical(xRangeLimit,c(-1,-1))){
    plotXlim = xRangeLimit
  }
  if (!identical(yRangeLimit,c(-1,-1))){
    plotYlim = yRangeLimit
  }

  
  if (is.function(updateProgress)) {
    updateProgress(value = 2/4,
                   detail = paste("If plotting of the points is required, they will be shown now, at ", Sys.time()))
  }
  

  plot(mixedModelData[[featureToUse]],mixedModelData[[ordinateToUse]], col=classes, pch=pchPlot,
       xlab=featureToUse, ylab=ordinateToUse,main=plotTitle,
       xlim = plotXlim,
       ylim = plotYlim)
  if (is.function(updateProgress)) {
    updateProgress(value = 3/4,
                   detail = paste("Calculating and plotting individual coefficients at ", Sys.time()))
  }
  
  
  coefs <- coef(linearModel) # save the coefficients of this model
  coefList = coefs[[groupingFactor]]
  
  increasingCount = 0
  decreasingCount = 0
  for(i in 1:nrow(coefList)){
    #abline(a=coefs$classes[i,1], b=coefs$classes[i,2],col=i, lty=i) # plot resulting lines
    #green if negative, red if positive
    if (coefList[i,2]<0){
      abline(a=coefList[i,1], b=coefList[i,2],col="green", lty=i) # plot resulting lines
      decreasingCount = decreasingCount+1
    }
    else{
      abline(a=coefList[i,1], b=coefList[i,2],col="red", lty=i) # plot resulting lines
      increasingCount = increasingCount+1
    }
    #This line works!!! sets a different colour per line
    #abline(a=coefs$sid[i,1], b=coefs$sid[i,2],col=i, lty=i) # plot resulting lines
  } 
  
  #Draw the main predicted line
  mainIntercept = as.numeric(fixef(linearModel)[1])
  mainSlope = as.numeric(fixef(linearModel)[2])
  abline(a=mainIntercept, b=mainSlope,col="black", lty=1)
  
  if (is.function(updateProgress)) {
    updateProgress(value = 4/4,
                   detail = paste("Plotting population model at ", Sys.time()))
  }
  
  #####LEGEND
  legend("topright", # places a legend at the appropriate place
         c(paste("Increasing count:",increasingCount),
           paste("Decreasing count:",decreasingCount)), # puts text in the legend 
         lty=c(1,1), # gives the legend appropriate symbols (lines)
         lwd=c(2.5,2.5),col=c("red","green")) # gives the legend lines the correct color and width
}

#This function diagnose residuals from a particular model
# The steps taken are described on MOndoDB MapReduce notes on 15/08/2014
diagnoseResiduals <- function(mixedLinearModel = NULL, lookForInfluentialPoins = TRUE, updateProgress = NULL){
  
  if (is.function(updateProgress)) {
    updateProgress(value = 1/5,
                   detail = paste("Obtaining data from the mixed linear model at ", Sys.time()))
  }
  
  #We will plot 3 figures in a single long column
  par(mfrow=c(3,1)) 
  
  #   print(summary(mixedLinearModel))
  #   print(coef(mixedLinearModel))
  
  if (is.function(updateProgress)) {
    updateProgress(value = 2/5,
                   detail = paste("Calculating fitted vs residuals graph at ", Sys.time()))
  }
  
  print("Plotting fitted vs residuals graph, it should look like a blob")
  #fittResGraph = 
  plot(fitted(mixedLinearModel),residuals(mixedLinearModel),
                      main="Fitted vs residuals graph, it should look like a blob")
  
  if (is.function(updateProgress)) {
    updateProgress(value = 3/5,
                   detail = paste("Calculating residuals histogram at ", Sys.time()))
  }
  
  print("Plotting histogram of residuals, it should follow a normal distribution")
  #resHist = 
  hist(residuals(mixedLinearModel),
                 main="Histogram of residuals, it should follow a normal distribution")
  
  if (is.function(updateProgress)) {
    updateProgress(value = 4/5,
                   detail = paste("Calculating residuals QQplot at ", Sys.time()))
  }
  print("Plotting QQplot of residuals, it should follow a normal distribution (diagonal line with centre in 0,0)")
  #resQQPlot = 
  qqnorm(residuals(mixedLinearModel),
                     main="QQplot of residuals, it should follow a normal distribution (diagonal line with centre in 0,0)")
  
  if (is.function(updateProgress)) {
    updateProgress(value = 5/5,
                   detail = paste("If influential points need to be found, they will be calculated now at ", Sys.time()))
  }
  if (lookForInfluentialPoins){
    print("Calculating the influential points, it could take a while if it has many classes")
    library(influence.ME)
    #attach(filteredMouseBehaviourFrame)
    influenceOfVars = influence(mixedLinearModel, group="sid")
    
    # Any value that changes the sign of the slope is an influential point.
    # Look for values which are different by half of the absolute value of the slope.
    #Even if these values are found,
    #two reports should be created reporting differences with and without those objects.
    
    dfbetaValues = dfbetas(influenceOfVars)
    dfbetaNames = names(dfbetaValues[,1])
    
    #Looking for values which are more than half the absolute value of the slope
    coefVal = as.numeric(fixef(mixedLinearModel)[2])
    dfbetaValues = as.numeric(dfbetaValues[,2])
    
    coefVal=abs(coefVal)
    dfbetaValues=abs(dfbetaValues)
    
    influentialPointNames = dfbetaNames[dfbetaValues > (coefVal/2)]
    influentialPointValues = dfbetaValues[dfbetaValues > (coefVal/2)]
    
    #We sort names and values from big to small
    influentialPointNames = influentialPointNames[order(influentialPointValues,decreasing = TRUE)]
    influentialPointValues = sort(influentialPointValues,decreasing = TRUE)
    
    if (length(influentialPointNames)>0){
      print(paste("From a total of ",length(dfbetaValues)," the following ",length(influentialPointNames),
                  " were found users were found to be too influential, rerun the model without them."))
      print(paste(influentialPointNames,influentialPointValues))
    }
    else{
      print("Hooray!! There are no influential points!")
    }
  }
  else
    print("lookForInfluentialPoins was false, rerun with lookForInfluentialPoins set to TRUE to test for influential points")
  
  #Alternative to influence code
  #   all.res=numeric(nrow(mydataframe))
  #   for(i in 1:nrow(mydataframe)){
  #     myfullmodel=lmer(response~predictor+
  #                        (1+predictor|randomeffect),POP[-i,])
  #     all.res[i]=fixef(myfullmodel)[some number]
  #   }
  #
  
  #resetPar()
  #Multiplot doesn't really work with nonggplot figures
  #multiplot(fittResGraph, resHist,resQQPlot, cols=1)
  
}


#From http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


# From http://www.r-statistics.com/2013/05/log-transformations-for-skewed-and-wide-distributions-from-practical-data-science-with-r/
# a logarithmic transformation that works for negative values.
signedlog10 = function(x) {
  ifelse(abs(x) <= 1, 0, sign(x)*log10(abs(x)))
}


#Function to reset the par, in case it had changed
#IN our case we only change it in the diagnose plot
resetPar <- function() {
  dev.new()
  op <- par(no.readonly = TRUE)
  dev.off()
  op
}
