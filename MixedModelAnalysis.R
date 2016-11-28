
##WARNING! It won't work if is not sourced
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

#Workspace folder

rWorkspacePath = this.dir

#CS data is in DATACS and Kupb data is in DATAKUPKB
#rDataWorkspacePath = paste(rWorkspacePath,"/DATACS/",sep="")
rDataWorkspacePath = paste(rWorkspacePath,"/data/",sep="")


installMissingPackages <- function(){
  list.of.packages <- c("shiny","ggplot2","lattice","lme4","lmerTest","ggplot2","stringr")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  else print("All listed packages are already installed")
}

installMissingPackages()

###LIBRARIES
library("lmerTest")
library("ggplot2")
library("stringr")

#DON'T Stop when any warning is found
options(warn=0)
options(stringsAsFactors = FALSE)

#Remove warnings
assign("last.warning", NULL, envir = baseenv())

#Remove scientifi (e+12) notation
options(scipen=999)



resetAndReload <- function (){
  
  print(paste("Loading",rDataWorkspacePath,"data"))
    
  print (paste("    Loading scrollData at ",Sys.time()))

  filename <- paste(rDataWorkspacePath,"scrollStatistics.csv",sep="")
  if (file.exists(filename)){
    scrollStatisticsDat <<- read.csv( paste(rDataWorkspacePath,"scrollStatistics.csv",sep=""), header = TRUE)
  }
  else{
    scrollStatisticsDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"scrollEpisodeDuration.csv",sep="")
  if (file.exists(filename)){
    scrollEpisodeDurationDat <<- read.csv( paste(rDataWorkspacePath,"scrollEpisodeDuration.csv",sep=""), header = TRUE)
  }
  else{
    scrollEpisodeDurationDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"scrollControlledScrollBehaviour.csv",sep="")
  if (file.exists(filename)){
    scrollControlledScrollDat <<- read.csv( paste(rDataWorkspacePath,"scrollControlledScrollBehaviour.csv",sep=""), header = TRUE)
  }
  else{
    scrollControlledScrollDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"scrollFastMouseScrollCycleBehaviour.csv",sep="")
  if (file.exists(filename)){
    scrollFastMouseScrollCycleDat <<- read.csv( paste(rDataWorkspacePath,"scrollFastMouseScrollCycleBehaviour.csv",sep=""), header = TRUE)
  }
  else{
    scrollFastMouseScrollCycleDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"scrollFastSingleDirectionMouseScroll.csv",sep="")
  if (file.exists(filename)){
    scrollFastSingleDirectionMouseScrollDat <<- read.csv( paste(rDataWorkspacePath,"scrollFastSingleDirectionMouseScroll.csv",sep=""), header = TRUE)
  }
  else{
    scrollFastSingleDirectionMouseScrollDat <<-  getNewDataFrame()
  }
  ###MOUSE BEHAVIOURS
  print (paste("    Loading mouseData at ",Sys.time()))

  filename <- paste(rDataWorkspacePath,"mouseStatistics.csv",sep="")
  if (file.exists(filename)){
    mouseStatisticsDat <<- read.csv( paste(rDataWorkspacePath,"mouseStatistics.csv",sep=""), header = TRUE)
  }
  else{
    mouseStatisticsDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseEpisodeDuration.csv",sep="")
  if (file.exists(filename)){
    mouseEpisodeDurationDat <<- read.csv( paste(rDataWorkspacePath,"mouseEpisodeDuration.csv",sep=""), header = TRUE)
  }
  else{
    mouseEpisodeDurationDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseClickSpeed.csv",sep="")
  if (file.exists(filename)){
    mouseClickSpeedDat <<- read.csv( paste(rDataWorkspacePath,"mouseClickSpeed.csv",sep=""), header = TRUE)
  }
  else{
    mouseClickSpeedDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseFailToClick.csv",sep="")
  if (file.exists(filename)){
    mouseFailToClickDat <<- read.csv( paste(rDataWorkspacePath,"mouseFailToClick.csv",sep=""), header = TRUE)
  }
  else{
    mouseFailToClickDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseHoveringOver.csv",sep="")
  if (file.exists(filename)){
    mouseHoveringOverDat <<- getNewDataFrame()#read.csv( paste(rDataWorkspacePath,"mouseHoveringOver.csv",sep=""), header = TRUE)
  }
  else{
    mouseHoveringOverDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseIdleAfterClick.csv",sep="")
  if (file.exists(filename)){
    mouseIdleAfterClickDat <<- read.csv( paste(rDataWorkspacePath,"mouseIdleAfterClick.csv",sep=""), header = TRUE)
  }
  else{
    mouseIdleAfterClickDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseIdleTime.csv",sep="")
  if (file.exists(filename)){
    mouseIdleTimeDat <<- read.csv( paste(rDataWorkspacePath,"mouseIdleTime.csv",sep=""), header = TRUE)
  }
  else{
    mouseIdleTimeDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseLackOfMousePrecision.csv",sep="")
  if (file.exists(filename)){
    mouseLackOfMousePrecisionDat <<- read.csv( paste(rDataWorkspacePath,"mouseLackOfMousePrecision.csv",sep=""), header = TRUE)
  }
  else{
    mouseLackOfMousePrecisionDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseRepeatedClicks.csv",sep="")
  if (file.exists(filename)){
    mouseRepeatedClicksDat <<- read.csv( paste(rDataWorkspacePath,"mouseRepeatedClicks.csv",sep=""), header = TRUE)
  }
  else{
    mouseRepeatedClicksDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseTimeToClick.csv",sep="")
  if (file.exists(filename)){
    mouseTimeToClickDat <<- read.csv( paste(rDataWorkspacePath,"mouseTimeToClick.csv",sep=""), header = TRUE)
  }
  else{
    mouseTimeToClickDat <<-  getNewDataFrame()
  }
  
  ###MOUSE MOVE BEHAVIOURS
  

  filename <- paste(rDataWorkspacePath,"mouseMoveStatistics.csv",sep="")
  if (file.exists(filename)){
    mouseMoveStatisticsDat <<- read.csv( paste(rDataWorkspacePath,"mouseMoveStatistics.csv",sep=""), header = TRUE)
  }
  else{
    mouseMoveStatisticsDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseMoveEpisodeDuration.csv",sep="")
  if (file.exists(filename)){
    mouseMoveEpisodeDurationDat <<- read.csv( paste(rDataWorkspacePath,"mouseMoveEpisodeDuration.csv",sep=""), header = TRUE)
  }
  else{
    mouseMoveEpisodeDurationDat <<-  getNewDataFrame()
  }

  filename <- paste(rDataWorkspacePath,"mouseMove.csv",sep="")
  if (file.exists(filename)){
    mouseMoveBehaviourDat <<- read.csv( paste(rDataWorkspacePath,"mouseMove.csv",sep=""), header = TRUE)
  }
  else{
    mouseMoveBehaviourDat <<-  getNewDataFrame()
  }
}

#This function saves the current state of the data into a "Global" state, so it can be recovered afterwards
saveCurrentDatToGlobal <- function (){
  
  #After loading the data, we'll keep a global copy of everything, to retrieve users after filtering
  scrollStatisticsDatGlobal <<- scrollStatisticsDat
  scrollEpisodeDurationDatGlobal <<- scrollEpisodeDurationDat
  scrollControlledScrollDatGlobal <<- scrollControlledScrollDat
  scrollFastMouseScrollCycleDatGlobal <<- scrollFastMouseScrollCycleDat
  scrollFastSingleDirectionMouseScrollDatGlobal <<- scrollFastSingleDirectionMouseScrollDat
  
  ###MOUSE BEHAVIOURS
  mouseStatisticsDatGlobal <<- mouseStatisticsDat
  mouseEpisodeDurationDatGlobal <<- mouseEpisodeDurationDat
  mouseClickSpeedDatGlobal <<- mouseClickSpeedDat
  mouseFailToClickDatGlobal <<- mouseFailToClickDat
  mouseHoveringOverDatGlobal <<- mouseHoveringOverDat
  mouseIdleAfterClickDatGlobal <<- mouseIdleAfterClickDat
  mouseIdleTimeDatGlobal <<- mouseIdleTimeDat
  mouseLackOfMousePrecisionDatGlobal <<- mouseLackOfMousePrecisionDat
  mouseRepeatedClicksDatGlobal <<- mouseRepeatedClicksDat
  mouseTimeToClickDatGlobal <<- mouseTimeToClickDat
  
  #MOUSE MOVE BEHAVIOURS
  mouseMoveStatisticsDatGlobal <<- mouseMoveStatisticsDat
  mouseMoveEpisodeDurationDatGlobal <<- mouseMoveEpisodeDurationDat
  mouseMoveBehaviourDatGlobal <<- mouseMoveBehaviourDat
}


#This function RESTORES the current state of the data FROM a "Global" state
restoreDataFromGlobal <- function (){
  
  #Restore all users before processing the next one
  scrollStatisticsDat <<- scrollStatisticsDatGlobal
  scrollEpisodeDurationDat <<- scrollEpisodeDurationDatGlobal
  scrollControlledScrollDat <<- scrollControlledScrollDatGlobal
  scrollFastMouseScrollCycleDat <<- scrollFastMouseScrollCycleDatGlobal
  scrollFastSingleDirectionMouseScrollDat <<- scrollFastSingleDirectionMouseScrollDatGlobal
  
  ###MOUSE BEHAVIOURS
  mouseStatisticsDat <<- mouseStatisticsDatGlobal
  mouseEpisodeDurationDat <<- mouseEpisodeDurationDatGlobal
  mouseClickSpeedDat <<- mouseClickSpeedDatGlobal
  mouseFailToClickDat <<- mouseFailToClickDatGlobal
  mouseHoveringOverDat <<- mouseHoveringOverDatGlobal
  mouseIdleAfterClickDat <<- mouseIdleAfterClickDatGlobal
  mouseIdleTimeDat <<- mouseIdleTimeDatGlobal
  mouseLackOfMousePrecisionDat <<- mouseLackOfMousePrecisionDatGlobal
  mouseRepeatedClicksDat <<- mouseRepeatedClicksDatGlobal
  mouseTimeToClickDat <<- mouseTimeToClickDatGlobal
  
  #MOUSE MOVE BEHAVIOURS
  mouseMoveStatisticsDat <<- mouseMoveStatisticsDatGlobal
  mouseMoveEpisodeDurationDat <<- mouseMoveEpisodeDurationDatGlobal
  mouseMoveBehaviourDat <<- mouseMoveBehaviourDatGlobal
  
}

getNewDataFrame <- function(){
  
  return (data.frame("sid" = character(),
                     "sessionstartms" = as.numeric(character()),
                     "url" = character(),
                     "urlSessionCounter" = as.numeric(character()),
                     "urlSinceLastSession" = as.numeric(character()),
                     "urlEpisodeDurationms" = as.numeric(character()),
                     "sdSessionCounter" = as.numeric(character()),
                     "sdTimeSinceLastSession" = as.numeric(character()),
                     "episodeDurationms" = as.numeric(character()),
                     "calculatedActiveTime" = as.numeric(character()),
                     "sdCalculatedActiveTime" = as.numeric(character()),
                     
                     #Scroll attributes
                     "positiveScroll" = as.numeric(character()),
                     "negativeScroll" = as.numeric(character()),
                     "numberOfMousewheel" = as.numeric(character()),
                     
                     #scrollBehaviour attributes
                     "scrollFastScrollCyclePosDelta" = as.numeric(character()),
                     "scrollFastScrollCycleNegDelta" = as.numeric(character()),
                     "scrollFastScrollCycleTotalDelta" = as.numeric(character()),
                     "scrollFastScrollCycleTotalDeltaAbs" = as.numeric(character()),
                     "scrollFastScrollCycleSpeed" = as.numeric(character()),
                     "scrollFastScrollCycleSpeedAbs" = as.numeric(character()),
                     "scrollFastScrollCycleDuration" = as.numeric(character()),
                     
                     "scrollFastSingleDirectPosDelta" = as.numeric(character()),
                     "scrollFastSingleDirectNegDelta" = as.numeric(character()),
                     "scrollFastSingleDirectTotalDelta" = as.numeric(character()),
                     "scrollFastSingleDirectTotalDeltaAbs" = as.numeric(character()),
                     "scrollFastSingleDirectSpeed" = as.numeric(character()),
                     "scrollFastSingleDirectSpeedAbs" = as.numeric(character()),
                     "scrollFastSingleDirectDuration" = as.numeric(character()),
                     
                     "scrollControlledPosDelta" = as.numeric(character()),
                     "scrollControlledNegDelta" = as.numeric(character()),
                     "scrollControlledTotalDelta" = as.numeric(character()),
                     "scrollControlledTotalDeltaAbs" = as.numeric(character()),
                     "scrollControlledSpeed" = as.numeric(character()),
                     "scrollControlledSpeedAbs" = as.numeric(character()),
                     "scrollControlledDuration" = as.numeric(character()),
                     
                     #scrollBehaviourCounters
                     "controlledScrollCounter" = as.numeric(character()),
                     "fastMouseScrollCycleCounter" = as.numeric(character()),
                     "fastSingleDirectionMouseScrollCounter" = as.numeric(character()),
                     
                     #Mouse attributes
                     "mousedownCounter" = as.numeric(character()),
                     "rightClickCounter" = as.numeric(character()),
                     "middleClickCounter" = as.numeric(character()),
                     "leftClickCounter" = as.numeric(character()),
                     "unknownClickCounter" = as.numeric(character()),
                     "mouseupCounter" = as.numeric(character()),
                     
                     #mousebehaviour attributes
                     "mouseClickSpeedClickTime" = as.numeric(character()), 
                     "mouseFailToClickStreakDuration" = as.numeric(character()), 
                     "mouseFailToClickDistanceBetweenClicks" = as.numeric(character()), 
                     "mouseFailToClickNumberOfClicks" = as.numeric(character()), 
                     "mouseIdleAfterClickTime" = as.numeric(character()), 
                     "mouseMeanIdleTimeDuration" = as.numeric(character()),
                     "mouseMedianIdleTimeDuration" = as.numeric(character()),
                     "mouseTotalIdleTimeDuration" = as.numeric(character()),
                     "mouseLackOfMousePrecisionFirstMouseOverTime" = as.numeric(character()), 
                     "mouseLackOfMousePrecisionNumberOfMouseOver" = as.numeric(character()), 
                     "mouseRepeatedClicksNumberOfClicks" = as.numeric(character()), 
                     "mouseRepeatedClicksTimeBetweenClicks" = as.numeric(character()), 
                     "mouseTimeToClickTime" = as.numeric(character()), 
                     
                     #mouse behaviour counters
                     "mouseClickSpeedCounter" = as.numeric(character()),
                     "mouseEpisodeDurationCounter" = as.numeric(character()),
                     "mouseFailToClickCounter" = as.numeric(character()),
                     "mouseHoveringOverCounter" = as.numeric(character()),
                     "mouseIdleAfterClickCounter" = as.numeric(character()),
                     "mouseIdleTimeCounter" = as.numeric(character()),
                     "mouseLackOfMousePrecisionCounter" = as.numeric(character()),
                     "mouseRepeatedClicksCounter" = as.numeric(character()),
                     "mouseStatisticsCounter" = as.numeric(character()),
                     "mouseTimeToClickCounter" = as.numeric(character()),
                     
                     
                     #Mousemove behaviours
                     "mouseMoveIncorrectMouseMoveCount" = as.numeric(character()),
                     "mouseMoveIncorrectMouseOverCount" = as.numeric(character()),
                     "mouseMoveMouseMoveCount" = as.numeric(character()),
                     "mouseMoveMouseOverCount" = as.numeric(character()),
                     "mouseMoveStartTimems" = as.numeric(character()),
                     "mouseMoveTotalDistance" = as.numeric(character()),
                     "mouseMoveEndTimems" = as.numeric(character()),
                     
                     stringsAsFactors = FALSE))
  
}

#There are two ways to create new episode rows.
#One is using the GLOBAL temp variables, which need to have been assigned before calling this function
constructRowFromTempVars <- function(){
  
  testAndReplaceNullValues()
  
  #Statistics and episode duration will have single values for each episode,
  #but behaviours may occur more than once, so I need to the the mean
  return(c("sid" = "",
           "sessionstartms" = sessionstartmsTemp,
           "url" = urlTemp,
           "urlSessionCounter" = urlSessionCounterTemp,
           "urlSinceLastSession" = urlSinceLastSessionTemp,
           "urlEpisodeDurationms"  = urlEpisodeDurationmsTemp,
           "sdSessionCounter" = sdSessionCounterTemp,
           "sdTimeSinceLastSession" = sdTimeSinceLastSessionTemp,
           "episodeDurationms" = episodeDurationmsTemp,
           "calculatedActiveTime" = calculatedActiveTimeTemp,
           "sdCalculatedActiveTime" = sdCalculatedActiveTimeTemp,
           
           #Scroll attributes
           "positiveScroll" = positiveScrollTemp,
           "negativeScroll" = negativeScrollTemp,
           "numberOfMousewheel" = numberOfMousewheelTemp,
           
           #scrollBehaviour attributes
           "scrollFastScrollCyclePosDelta" = mean(scrollFastScrollCyclePosDeltaTemp),
           "scrollFastScrollCycleNegDelta" = mean(scrollFastScrollCycleNegDeltaTemp),
           "scrollFastScrollCycleTotalDelta" = mean(scrollFastScrollCycleTotalDeltaTemp),
           "scrollFastScrollCycleTotalDeltaAbs" = mean(scrollFastScrollCycleTotalDeltaAbsTemp),
           "scrollFastScrollCycleSpeed" = mean(scrollFastScrollCycleSpeedTemp),
           "scrollFastScrollCycleSpeedAbs" = mean(scrollFastScrollCycleSpeedAbsTemp),
           "scrollFastScrollCycleDuration" = mean(scrollFastScrollCycleDurationTemp),
           
           "scrollFastSingleDirectPosDelta" = mean(scrollFastSingleDirectPosDeltaTemp),
           "scrollFastSingleDirectNegDelta" = mean(scrollFastSingleDirectNegDeltaTemp),
           "scrollFastSingleDirectTotalDelta" = mean(scrollFastSingleDirectTotalDeltaTemp),
           "scrollFastSingleDirectTotalDeltaAbs" = mean(scrollFastSingleDirectTotalDeltaAbsTemp),
           "scrollFastSingleDirectSpeed" = mean(scrollFastSingleDirectSpeedTemp),
           "scrollFastSingleDirectSpeedAbs" = mean(scrollFastSingleDirectSpeedAbsTemp),
           "scrollFastSingleDirectDuration" = mean(scrollFastSingleDirectDurationTemp),
           
           "scrollControlledPosDelta" = mean(scrollControlledPosDeltaTemp),
           "scrollControlledNegDelta" = mean(scrollControlledNegDeltaTemp),
           "scrollControlledTotalDelta" = mean(scrollControlledTotalDeltaTemp),
           "scrollControlledTotalDeltaAbs" = mean(scrollControlledTotalDeltaAbsTemp),
           "scrollControlledSpeed" = mean(scrollControlledSpeedTemp),
           "scrollControlledSpeedAbs" = mean(scrollControlledSpeedAbsTemp),
           "scrollControlledDuration" = mean(scrollControlledDurationTemp),
           
           #scrollBehaviourCounters
           "controlledScrollCounter" = controlledScrollCounterTemp,
           "fastMouseScrollCycleCounter" = fastMouseScrollCycleCounterTemp,
           "fastSingleDirectionMouseScrollCounter" = fastSingleDirectionMouseScrollCounterTemp,
           
           #Mouse attributes
           "mousedownCounter" = mousedownCounterTemp,
           "rightClickCounter" = rightClickCounterTemp,
           "middleClickCounter" = middleClickCounterTemp,
           "leftClickCounter" = leftClickCounterTemp,
           "unknownClickCounter" = unknownClickCounterTemp,
           "mouseupCounter" = mouseupCounterTemp,
           
           #mousebehaviour attributes
           "mouseClickSpeedClickTime" = mean(mouseClickSpeedClickTimeTemp),
           "mouseFailToClickStreakDuration" = mean(mouseFailToClickStreakDurationTemp),
           "mouseFailToClickDistanceBetweenClicks" = mean(mouseFailToClickDistanceBetweenClicksTemp),
           "mouseFailToClickNumberOfClicks" = mean(mouseFailToClickNumberOfClicksTemp),
           "mouseIdleAfterClickTime" = mean(mouseIdleAfterClickTimeTemp),
           "mouseMeanIdleTimeDuration" = mean(mouseIdleTimeDurationListTemp),
           "mouseMedianIdleTimeDuration" = median(mouseIdleTimeDurationListTemp),
           "mouseTotalIdleTimeDuration" = sum(mouseIdleTimeDurationListTemp),
           "mouseLackOfMousePrecisionFirstMouseOverTime" = mean(mouseLackOfMousePrecisionFirstMouseOverTimeTemp),
           "mouseLackOfMousePrecisionNumberOfMouseOver" = mean(mouseLackOfMousePrecisionNumberOfMouseOverTemp),
           "mouseRepeatedClicksNumberOfClicks" = mean(mouseRepeatedClicksNumberOfClicksTemp),
           "mouseRepeatedClicksTimeBetweenClicks" = mean(mouseRepeatedClicksTimeBetweenClicksTemp),
           "mouseTimeToClickTime" = mean(mouseTimeToClickTimeTemp),
           
           #mousebehaviourCounters
           "mouseClickSpeedCounter" = mouseClickSpeedCounterTemp,
           "mouseEpisodeDurationCounter" = mouseEpisodeDurationCounterTemp,
           "mouseFailToClickCounter" = mouseFailToClickCounterTemp,
           "mouseHoveringOverCounter" = mouseHoveringOverCounterTemp,
           "mouseIdleAfterClickCounter" = mouseIdleAfterClickCounterTemp,
           "mouseIdleTimeCounter" = mouseIdleTimeCounterTemp,
           "mouseLackOfMousePrecisionCounter" = mouseLackOfMousePrecisionCounterTemp,
           "mouseRepeatedClicksCounter" = mouseRepeatedClicksCounterTemp,
           "mouseStatisticsCounter" = mouseStatisticsCounterTemp,
           "mouseTimeToClickCounter" = mouseTimeToClickCounterTemp,
           
           #MouseMoveBehaviours
           "mouseMoveIncorrectMouseMoveCount" = mouseMoveIncorrectMouseMoveCountTemp,
           "mouseMoveIncorrectMouseOverCount" = mouseMoveIncorrectMouseOverCountTemp,
           "mouseMoveMouseMoveCount" = mouseMoveMouseMoveCountTemp,
           "mouseMoveMouseOverCount" = mouseMoveMouseOverCountTemp,
           "mouseMoveStartTimems" = mouseMoveStartTimemsTemp,
           "mouseMoveTotalDistance" = mouseMoveTotalDistanceTemp,
           "mouseMoveEndTimems" = mouseMoveEndTimemsTemp)
  )
}

#There are two ways to create new episode rows.
#One is using the episodeObject given as argument
constructRowFromEpisodeObject <- function(episodeObject){
  #First element is sid, which will be added later
  return(c("sid" = "",
           "sessionstartms" = episodeObject$sessionstartms,
           "url" = episodeObject$url,
           "urlSessionCounter" = episodeObject$urlSessionCounter,
           "urlSinceLastSession" = episodeObject$urlSinceLastSession,
           "urlEpisodeDurationms" = episodeObject$urlEpisodeDurationms,
           "sdSessionCounter" = episodeObject$sdSessionCounter,
           "sdTimeSinceLastSession" = episodeObject$sdTimeSinceLastSession,
           "episodeDurationms" = episodeObject$episodeDurationms,
           "calculatedActiveTime" = episodeObject$calculatedActiveTime,
           "sdCalculatedActiveTime" = episodeObject$sdCalculatedActiveTime,
           
           #Scroll attributes
           "positiveScroll" = episodeObject$positiveScroll,
           "negativeScroll" = episodeObject$negativeScroll,
           "numberOfMousewheel" = episodeObject$numberOfMousewheel,
           
           #scrollBehaviour attributes
           "scrollFastScrollCyclePosDelta" = episodeObject$scrollFastScrollCyclePosDelta,
           "scrollFastScrollCycleNegDelta" = episodeObject$scrollFastScrollCycleNegDelta,
           "scrollFastScrollCycleTotalDelta" = episodeObject$scrollFastScrollCycleTotalDelta,
           "scrollFastScrollCycleTotalDeltaAbs" = episodeObject$scrollFastScrollCycleTotalDeltaAbs,
           "scrollFastScrollCycleSpeed" = episodeObject$scrollFastScrollCycleSpeed,
           "scrollFastScrollCycleSpeedAbs" = episodeObject$scrollFastScrollCycleSpeedAbs,
           "scrollFastScrollCycleDuration" = episodeObject$scrollFastScrollCycleDuration,
           
           "scrollFastSingleDirectPosDelta" = episodeObject$scrollFastSingleDirectPosDelta,
           "scrollFastSingleDirectNegDelta" = episodeObject$scrollFastSingleDirectNegDelta,
           "scrollFastSingleDirectTotalDelta" = episodeObject$scrollFastSingleDirectTotalDelta,
           "scrollFastSingleDirectTotalDeltaAbs" = episodeObject$scrollFastSingleDirectTotalDeltaAbs,
           "scrollFastSingleDirectSpeed" = episodeObject$scrollFastSingleDirectSpeed,
           "scrollFastSingleDirectSpeedAbs" = episodeObject$scrollFastSingleDirectSpeedAbs,
           "scrollFastSingleDirectDuration" = episodeObject$scrollFastSingleDirectDuration,
           
           "scrollControlledPosDelta" = episodeObject$scrollControlledPosDelta,
           "scrollControlledNegDelta" = episodeObject$scrollControlledNegDelta,
           "scrollControlledTotalDelta" = episodeObject$scrollControlledTotalDelta,
           "scrollControlledTotalDeltaAbs" = episodeObject$scrollControlledTotalDeltaAbs,
           "scrollControlledSpeed" = episodeObject$scrollControlledSpeed,
           "scrollControlledSpeedAbs" = episodeObject$scrollControlledSpeedAbs,
           "scrollControlledDuration" = episodeObject$scrollControlledDuration,
           
           #scrollBehaviourCounters
           "controlledScrollCounter" = episodeObject$controlledScrollCounter,
           "fastMouseScrollCycleCounter" = episodeObject$fastMouseScrollCycleCounter,
           "fastSingleDirectionMouseScrollCounter" = episodeObject$fastSingleDirectionMouseScrollCounter,
           
           #Mouse attributes
           "mousedownCounter" = episodeObject$mousedownCounter,
           "rightClickCounter" = episodeObject$rightClickCounter,
           "middleClickCounter" = episodeObject$middleClickCounter,
           "leftClickCounter" = episodeObject$leftClickCounter,
           "unknownClickCounter" = episodeObject$unknownClickCounter,
           "mouseupCounter" = episodeObject$mouseupCounter,
           
           #mousebehaviour attributes
           "mouseClickSpeedClickTime" = episodeObject$mouseClickSpeedClickTime,
           "mouseFailToClickStreakDuration" = episodeObject$mouseFailToClickStreakDuration,
           "mouseFailToClickDistanceBetweenClicks" = episodeObject$mouseFailToClickDistanceBetweenClicks,
           "mouseFailToClickNumberOfClicks" = episodeObject$mouseFailToClickNumberOfClicks,
           "mouseMeanIdleTimeDuration" = episodeObject$mouseMeanIdleTimeDuration,
           "mouseMedianIdleTimeDuration" = episodeObject$mouseMedianIdleTimeDuration,
           "mouseTotalIdleTimeDuration" = episodeObject$mouseTotalIdleTimeDuration,
           "mouseLackOfMousePrecisionFirstMouseOverTime" = episodeObject$mouseLackOfMousePrecisionFirstMouseOverTime,
           "mouseLackOfMousePrecisionNumberOfMouseOver" = episodeObject$mouseLackOfMousePrecisionNumberOfMouseOver,
           "mouseRepeatedClicksNumberOfClicks" = episodeObject$mouseRepeatedClicksNumberOfClicks,
           "mouseRepeatedClicksTimeBetweenClicks" = episodeObject$mouseRepeatedClicksTimeBetweenClicks,
           "mouseTimeToClickTime" = episodeObject$mouseTimeToClickTime,
           
           
           #mousebehaviourCoutners
           "mouseClickSpeedCounter" = episodeObject$mouseClickSpeedCounter,
           "mouseEpisodeDurationCounter" = episodeObject$mouseEpisodeDurationCounter,
           "mouseFailToClickCounter" = episodeObject$mouseFailToClickCounter,
           "mouseHoveringOverCounter" = episodeObject$mouseHoveringOverCounter,
           "mouseIdleAfterClickCounter" = episodeObject$mouseIdleAfterClickCounter,
           "mouseIdleTimeCounter" = episodeObject$mouseIdleTimeCounter,
           "mouseLackOfMousePrecisionCounter" = episodeObject$mouseLackOfMousePrecisionCounter,
           "mouseRepeatedClicksCounter" = episodeObject$mouseRepeatedClicksCounter,
           "mouseStatisticsCounter" = episodeObject$mouseStatisticsCounter,
           "mouseTimeToClickCounter" = episodeObject$mouseTimeToClickCounter,
           
           #MouseMoveBehaviorus
           
           "mouseMoveIncorrectMouseMoveCount" <<- episodeObject$incorrectMouseMoveCount,
           "mouseMoveIncorrectMouseOverCount" <<- episodeObject$incorrectMouseOverCount,
           "mouseMoveMouseMoveCount" <<- episodeObject$mouseMoveCount,
           "mouseMoveMouseOverCount" <<- episodeObject$mouseOverCount,
           "mouseMoveStartTimems" <<- episodeObject$startTimems,
           "mouseMoveTotalDistance" <<- episodeObject$totalDistance,
           "mouseMoveEndTimems" <<- episodeObject$endTimems)
  )
}

##This function will look for all null values among the TEMP variables and replace them by '0's
testAndReplaceNullValues <- function(){
  
  if (length(scrollFastScrollCyclePosDeltaTemp)==0){
    scrollFastScrollCyclePosDeltaTemp <<- 0
    scrollFastScrollCycleNegDeltaTemp <<- 0
    scrollFastScrollCycleTotalDeltaTemp <<- 0
    scrollFastScrollCycleTotalDeltaAbsTemp <<- 0
    scrollFastScrollCycleSpeedTemp <<- 0
    scrollFastScrollCycleSpeedAbsTemp <<- 0
    scrollFastScrollCycleDurationTemp <<- 0
  }
  
  if (length(scrollFastSingleDirectPosDeltaTemp)==0){
    scrollFastSingleDirectPosDeltaTemp <<- 0
    scrollFastSingleDirectNegDeltaTemp <<- 0
    scrollFastSingleDirectTotalDeltaTemp <<- 0
    scrollFastSingleDirectTotalDeltaAbsTemp <<- 0
    scrollFastSingleDirectSpeedTemp <<- 0
    scrollFastSingleDirectSpeedAbsTemp <<- 0
    scrollFastSingleDirectDurationTemp <<- 0
  }
  if (length(scrollControlledPosDeltaTemp)==0){
    scrollControlledPosDeltaTemp <<- 0
    scrollControlledNegDeltaTemp <<- 0
    scrollControlledTotalDeltaTemp <<- 0
    scrollControlledTotalDeltaAbsTemp <<- 0
    scrollControlledSpeedTemp <<- 0
    scrollControlledSpeedAbsTemp <<- 0
    scrollControlledDurationTemp <<- 0
  }
  
  #mousebehaviour attributes
  if (length(mouseClickSpeedClickTimeTemp)==0){
    mouseClickSpeedClickTimeTemp <<- 0
  }
  if (length(mouseFailToClickStreakDurationTemp)==0){
    mouseFailToClickStreakDurationTemp <<- 0
    mouseFailToClickDistanceBetweenClicksTemp <<- 0
    mouseFailToClickNumberOfClicksTemp <<- 0
  }
  
  if (length(mouseIdleAfterClickTimeTemp)==0){
    mouseIdleAfterClickTimeTemp <<- 0
  }
  if (length(mouseIdleTimeDurationListTemp)==0){
    mouseIdleTimeDurationListTemp <<- 0
  } 
  if (length(mouseLackOfMousePrecisionFirstMouseOverTimeTemp)==0){
    mouseLackOfMousePrecisionFirstMouseOverTimeTemp <<- 0
    mouseLackOfMousePrecisionNumberOfMouseOverTemp <<- 0
  }
  if (length(mouseRepeatedClicksNumberOfClicksTemp)==0){
    mouseRepeatedClicksNumberOfClicksTemp <<- 0
    mouseRepeatedClicksTimeBetweenClicksTemp <<- 0
  }
  if (length(mouseTimeToClickTimeTemp)==0){
    mouseTimeToClickTimeTemp <<- 0
  }
}

filterSingleUser <- function(userSid){
  #I'll start analysing the old user 'VVwNnM0yHm6k'
  singleUserId <- userSid
  #Filter that particular user and url from the data and sort it by urlEpisode
  
  scrollStatisticsDat <<- scrollStatisticsDat[scrollStatisticsDat$sid == singleUserId, ]
  scrollEpisodeDurationDat <<- scrollEpisodeDurationDat[scrollEpisodeDurationDat$sid == singleUserId, ]
  scrollControlledScrollDat <<- scrollControlledScrollDat[scrollControlledScrollDat$sid == singleUserId, ]
  scrollFastMouseScrollCycleDat <<- scrollFastMouseScrollCycleDat[scrollFastMouseScrollCycleDat$sid == singleUserId, ]
  scrollFastSingleDirectionMouseScrollDat <<- scrollFastSingleDirectionMouseScrollDat[scrollFastSingleDirectionMouseScrollDat$sid == singleUserId, ]
  
  scrollStatisticsDat <<- scrollStatisticsDat[order(scrollStatisticsDat$urlSessionCounter),]
  scrollEpisodeDurationDat <<- scrollEpisodeDurationDat[order(scrollEpisodeDurationDat$urlSessionCounter),]
  scrollControlledScrollDat <<- scrollControlledScrollDat[order(scrollControlledScrollDat$urlSessionCounter),]
  scrollFastMouseScrollCycleDat <<- scrollFastMouseScrollCycleDat[order(scrollFastMouseScrollCycleDat$urlSessionCounter),]
  scrollFastSingleDirectionMouseScrollDat <<- scrollFastSingleDirectionMouseScrollDat[order(scrollFastSingleDirectionMouseScrollDat$urlSessionCounter),]
  
  
  ##Mouse behaviours
  mouseStatisticsDat <<- mouseStatisticsDat[mouseStatisticsDat$sid == singleUserId, ]
  mouseEpisodeDurationDat <<- mouseEpisodeDurationDat[mouseEpisodeDurationDat$sid == singleUserId, ]
  mouseClickSpeedDat <<- mouseClickSpeedDat[mouseClickSpeedDat$sid == singleUserId, ]
  mouseFailToClickDat <<- mouseFailToClickDat[mouseFailToClickDat$sid == singleUserId, ]
  mouseHoveringOverDat <<- mouseHoveringOverDat[mouseHoveringOverDat$sid == singleUserId, ]
  mouseIdleAfterClickDat <<- mouseIdleAfterClickDat[mouseIdleAfterClickDat$sid == singleUserId, ]
  mouseIdleTimeDat <<- mouseIdleTimeDat[mouseIdleTimeDat$sid == singleUserId, ]
  mouseLackOfMousePrecisionDat <<- mouseLackOfMousePrecisionDat[mouseLackOfMousePrecisionDat$sid == singleUserId, ]
  mouseRepeatedClicksDat <<- mouseRepeatedClicksDat[mouseRepeatedClicksDat$sid == singleUserId, ]
  mouseTimeToClickDat <<- mouseTimeToClickDat[mouseTimeToClickDat$sid == singleUserId, ]
  
  mouseStatisticsDat <<- mouseStatisticsDat[order(mouseStatisticsDat$urlSessionCounter),]
  mouseEpisodeDurationDat <<- mouseEpisodeDurationDat[order(mouseEpisodeDurationDat$urlSessionCounter),]
  mouseClickSpeedDat <<- mouseClickSpeedDat[order(mouseClickSpeedDat$urlSessionCounter),]
  mouseFailToClickDat <<- mouseFailToClickDat[order(mouseFailToClickDat$urlSessionCounter),]
  mouseHoveringOverDat <<- mouseHoveringOverDat[order(mouseHoveringOverDat$urlSessionCounter),]
  mouseIdleAfterClickDat <<- mouseIdleAfterClickDat[order(mouseIdleAfterClickDat$urlSessionCounter),]
  mouseIdleTimeDat <<- mouseIdleTimeDat[order(mouseIdleTimeDat$urlSessionCounter),]
  mouseLackOfMousePrecisionDat <<- mouseLackOfMousePrecisionDat[order(mouseLackOfMousePrecisionDat$urlSessionCounter),]
  mouseRepeatedClicksDat <<- mouseRepeatedClicksDat[order(mouseRepeatedClicksDat$urlSessionCounter),]
  mouseTimeToClickDat <<- mouseTimeToClickDat[order(mouseTimeToClickDat$urlSessionCounter),]
  
  
  #MOUSE MOVE BEHAVIOURS
  mouseMoveStatisticsDat <<- mouseMoveStatisticsDat[mouseMoveStatisticsDat$sid == singleUserId, ]
  mouseMoveStatisticsDat <<- mouseMoveStatisticsDat[order(mouseMoveStatisticsDat$urlSessionCounter),]
  
  mouseMoveEpisodeDurationDat <<- mouseMoveEpisodeDurationDat[mouseMoveEpisodeDurationDat$sid == singleUserId, ]
  mouseMoveEpisodeDurationDat <<- mouseMoveEpisodeDurationDat[order(mouseMoveEpisodeDurationDat$urlSessionCounter),]
  
  mouseMoveBehaviourDat <<- mouseMoveBehaviourDat[mouseMoveBehaviourDat$sid == singleUserId, ]
  mouseMoveBehaviourDat <<- mouseMoveBehaviourDat[order(mouseMoveBehaviourDat$urlSessionCounter),]
  
}


filterSingleUrl <- function(urlString){
  singleUrl <- urlString
  #Filter that particular url from the data
  
  scrollStatisticsDat <<- scrollStatisticsDat[scrollStatisticsDat$url == singleUrl, ]
  scrollEpisodeDurationDat <<- scrollEpisodeDurationDat[scrollEpisodeDurationDat$url == singleUrl, ]
  scrollControlledScrollDat <<- scrollControlledScrollDat[scrollControlledScrollDat$url == singleUrl, ]
  scrollFastMouseScrollCycleDat <<- scrollFastMouseScrollCycleDat[scrollFastMouseScrollCycleDat$url == singleUrl, ]
  scrollFastSingleDirectionMouseScrollDat <<- scrollFastSingleDirectionMouseScrollDat[scrollFastSingleDirectionMouseScrollDat$url == singleUrl, ]
  
  
  ##Mouse behaviours
  mouseStatisticsDat <<- mouseStatisticsDat[mouseStatisticsDat$url == singleUrl, ]
  mouseEpisodeDurationDat <<- mouseEpisodeDurationDat[mouseEpisodeDurationDat$url == singleUrl, ]
  mouseClickSpeedDat <<- mouseClickSpeedDat[mouseClickSpeedDat$url == singleUrl, ]
  mouseFailToClickDat <<- mouseFailToClickDat[mouseFailToClickDat$url == singleUrl, ]
  mouseHoveringOverDat <<- mouseHoveringOverDat[mouseHoveringOverDat$url == singleUrl, ]
  mouseIdleAfterClickDat <<- mouseIdleAfterClickDat[mouseIdleAfterClickDat$url == singleUrl, ]
  mouseIdleTimeDat <<- mouseIdleTimeDat[mouseIdleTimeDat$url == singleUrl, ]
  mouseLackOfMousePrecisionDat <<- mouseLackOfMousePrecisionDat[mouseLackOfMousePrecisionDat$url == singleUrl, ]
  mouseRepeatedClicksDat <<- mouseRepeatedClicksDat[mouseRepeatedClicksDat$url == singleUrl, ]
  mouseTimeToClickDat <<- mouseTimeToClickDat[mouseTimeToClickDat$url == singleUrl, ]
  
  
  #MOUSE MOVE BEHAVIOURS
  mouseMoveStatisticsDat <<- mouseMoveStatisticsDat[mouseMoveStatisticsDat$url == singleUrl, ]
  
  mouseMoveEpisodeDurationDat <<- mouseMoveEpisodeDurationDat[mouseMoveEpisodeDurationDat$url == singleUrl, ]
  
  mouseMoveBehaviourDat <<- mouseMoveBehaviourDat[mouseMoveBehaviourDat$url == singleUrl, ]
  
}


##Takes all the data FROM A SINGLE USER AND URL, and quantifies each of the episodes in a single dataframe
episodeQuantification <- function(){
  episodeDF <<- NULL
  
  episodeDF <<- getNewDataFrame()
  
  ##QUICKFIX FOR NA VALUES
  if (is.na(min(scrollEpisodeDurationDat$urlSessionCounter))){
    print("NA values found! in episode quantification!!")
    return (FALSE)
  }
  
  userId = unique(c(scrollEpisodeDurationDat$sid,mouseEpisodeDurationDat$sid,mouseMoveBehaviourDat$sid))
  
  listOfEmptyEpisodes = ""
  #We get the minimum and maximum episode Count from both mouse and scroll data
  minEpisodeCounter = min(c(scrollEpisodeDurationDat$urlSessionCounter,mouseEpisodeDurationDat$urlSessionCounter,mouseMoveBehaviourDat$urlSessionCounter))
  maxEpisodeCounter = max(c(scrollEpisodeDurationDat$urlSessionCounter,mouseEpisodeDurationDat$urlSessionCounter,mouseMoveBehaviourDat$urlSessionCounter))
  
  #For each episode
  for (episodeIndex in minEpisodeCounter:maxEpisodeCounter){
    
    #It could be interesting to get both standard statistics (abs scroll, neg scroll, episode duration...)
    #as well as behaviour information (number of behaviours of each, scroll for those behaviours, duration for those behaviour)
    #If I have the scroll values for the behaviours (in an array), I could try to quantify those, in some kind of
    #regression combined with variance and mean. The problem is that they don't take place equidistantly.
    scrollStatisticsEpisodeDat <<- scrollStatisticsDat[scrollStatisticsDat$urlSessionCounter == episodeIndex, ]
    scrollEpisodeDurationEpisodeDat <<- scrollEpisodeDurationDat[scrollEpisodeDurationDat$urlSessionCounter == episodeIndex, ]
    
    #Scroll behaviours
    scrollControlledScrollEpisodeDat <<- scrollControlledScrollDat[scrollControlledScrollDat$urlSessionCounter == episodeIndex, ]
    scrollFastMouseScrollCycleEpisodeDat <<- scrollFastMouseScrollCycleDat[scrollFastMouseScrollCycleDat$urlSessionCounter == episodeIndex, ]
    scrollFastSingleDirectionMouseScrollEpisodeDat <<- scrollFastSingleDirectionMouseScrollDat[scrollFastSingleDirectionMouseScrollDat$urlSessionCounter == episodeIndex, ]
    
    ##Mouse behaviours
    mouseStatisticsEpisodeDat <<- mouseStatisticsDat[mouseStatisticsDat$urlSessionCounter == episodeIndex, ]
    mouseEpisodeDurationEpisodeDat <<- mouseEpisodeDurationDat[mouseEpisodeDurationDat$urlSessionCounter == episodeIndex, ]
    mouseClickSpeedEpisodeDat <<- mouseClickSpeedDat[mouseClickSpeedDat$urlSessionCounter == episodeIndex, ]
    mouseFailToClickEpisodeDat <<- mouseFailToClickDat[mouseFailToClickDat$urlSessionCounter == episodeIndex, ]
    mouseHoveringOverEpisodeDat <<- mouseHoveringOverDat[mouseHoveringOverDat$urlSessionCounter == episodeIndex, ]
    mouseIdleAfterClickEpisodeDat <<- mouseIdleAfterClickDat[mouseIdleAfterClickDat$urlSessionCounter == episodeIndex, ]
    mouseIdleTimeEpisodeDat <<- mouseIdleTimeDat[mouseIdleTimeDat$urlSessionCounter == episodeIndex, ]
    mouseLackOfMousePrecisionEpisodeDat <<- mouseLackOfMousePrecisionDat[mouseLackOfMousePrecisionDat$urlSessionCounter == episodeIndex, ]
    mouseRepeatedClicksEpisodeDat <<- mouseRepeatedClicksDat[mouseRepeatedClicksDat$urlSessionCounter == episodeIndex, ]
    mouseTimeToClickEpisodeDat <<- mouseTimeToClickDat[mouseTimeToClickDat$urlSessionCounter == episodeIndex, ]
    
    #MOUSE MOVE BEHAVIOURS
    mouseMoveStatisticsEpisodeDat <<- mouseMoveStatisticsDat[mouseMoveStatisticsDat$urlSessionCounter == episodeIndex, ]
    mouseMoveEpisodeDurationEpisodeDat <<- mouseMoveEpisodeDurationDat[mouseMoveEpisodeDurationDat$urlSessionCounter == episodeIndex, ]
    mouseMoveBehaviourEpisodeDat <<- mouseMoveBehaviourDat[mouseMoveBehaviourDat$urlSessionCounter == episodeIndex, ]
    
    
    #I need to compare both available episodeDurationms and sessionstartms in scroll and mouse, and take the one which is available.
    if (nrow(scrollEpisodeDurationEpisodeDat)!=0){
      sidTemp <<- scrollStatisticsEpisodeDat$sid
      sessionstartmsTemp <<- scrollStatisticsEpisodeDat$sessionstartms
      urlTemp <<- scrollEpisodeDurationEpisodeDat$url
      urlSessionCounterTemp <<- scrollEpisodeDurationEpisodeDat$urlSessionCounter
      urlSinceLastSessionTemp <<- scrollEpisodeDurationEpisodeDat$urlSinceLastSession
      urlEpisodeDurationmsTemp <<- scrollStatisticsEpisodeDat$urlEpisodeLength
      sdSessionCounterTemp <<- scrollStatisticsEpisodeDat$sdSessionCounter
      sdTimeSinceLastSessionTemp <<- scrollStatisticsEpisodeDat$sdTimeSinceLastSession
      episodeDurationmsTemp <<- scrollEpisodeDurationEpisodeDat$episodeDurationms
      calculatedActiveTimeTemp <<- scrollStatisticsEpisodeDat$calculatedActiveTime
      sdCalculatedActiveTimeTemp <<- scrollStatisticsEpisodeDat$sdCalculatedActiveTime
      
    }
    else if (nrow(mouseEpisodeDurationEpisodeDat)!=0){
      sidTemp <<- mouseStatisticsEpisodeDat$sid
      sessionstartmsTemp <<- mouseStatisticsEpisodeDat$sessionstartms
      urlTemp <<- mouseStatisticsEpisodeDat$url
      urlSessionCounterTemp <<- mouseStatisticsEpisodeDat$urlSessionCounter
      urlSinceLastSessionTemp <<- mouseEpisodeDurationEpisodeDat$urlSinceLastSession
      urlEpisodeDurationmsTemp <<- mouseStatisticsEpisodeDat$urlEpisodeLength
      sdSessionCounterTemp <<- mouseStatisticsEpisodeDat$sdSessionCounter
      sdTimeSinceLastSessionTemp <<- mouseStatisticsEpisodeDat$sdTimeSinceLastSession
      episodeDurationmsTemp <<- mouseEpisodeDurationEpisodeDat$episodeDurationms
      calculatedActiveTimeTemp <<- mouseStatisticsEpisodeDat$calculatedActiveTime
      sdCalculatedActiveTimeTemp <<- mouseStatisticsEpisodeDat$sdCalculatedActiveTime
    }
    ###This should never take place...
    else if (nrow(mouseMoveStatisticsEpisodeDat)!=0){
      print("CHECKING MOUSEMOVE INSTEAD OF MOUSEBEHAVIOUR STATISTICS!!!!!")
      
      sidTemp <<- mouseMoveStatisticsEpisodeDat$sid
      sessionstartmsTemp <<- mouseMoveStatisticsEpisodeDat$sessionstartms
      urlTemp <<- mouseMoveStatisticsEpisodeDat$url
      urlSessionCounterTemp <<- mouseMoveStatisticsEpisodeDat$urlSessionCounter
      urlSinceLastSessionTemp <<- mouseMoveEpisodeDurationDat$urlSinceLastSession
      urlEpisodeDurationmsTemp <<- mouseMoveStatisticsEpisodeDat$urlEpisodeLength
      sdSessionCounterTemp <<- mouseMoveStatisticsEpisodeDat$sdSessionCounter
      sdTimeSinceLastSessionTemp <<- mouseMoveStatisticsEpisodeDat$sdTimeSinceLastSession
      episodeDurationmsTemp <<- mouseMoveEpisodeDurationDat$episodeDurationms
      calculatedActiveTimeTemp <<- mouseMoveStatisticsEpisodeDat$calculatedActiveTime
      sdCalculatedActiveTimeTemp <<- mouseMoveStatisticsEpisodeDat$sdCalculatedActiveTime
    }
    else{
      sidTemp <<- ""
      sessionstartmsTemp <<- 0
      urlTemp <<- ""
      urlSessionCounterTemp <<- episodeIndex
      urlSinceLastSessionTemp <<- 0
      urlEpisodeDurationmsTemp <<- 0
      sdSessionCounterTemp <<- 0
      sdTimeSinceLastSessionTemp <<- 0
      episodeDurationmsTemp <<- 0
      calculatedActiveTimeTemp <<- 0
      sdCalculatedActiveTimeTemp <<- 0
      
      listOfEmptyEpisodes = paste(listOfEmptyEpisodes,", ",episodeIndex)      
    }
    
    ##Get scroll statistics and behaviours
    if (nrow(scrollEpisodeDurationEpisodeDat)!=0){
      ##Setting the scroll parameters, '0' if there were no scrolls
      positiveScrollTemp <<- scrollStatisticsEpisodeDat$positiveScroll
      negativeScrollTemp <<- scrollStatisticsEpisodeDat$negativeScroll
      numberOfMousewheelTemp <<- scrollStatisticsEpisodeDat$numberOfMousewheel
      urlSinceLastSessionTemp <<- scrollStatisticsEpisodeDat$urlSinceLastSession
      
      controlledScrollCounterTemp <<- length(scrollControlledScrollEpisodeDat$sid)
      fastMouseScrollCycleCounterTemp <<- length(scrollFastMouseScrollCycleEpisodeDat$sid)
      fastSingleDirectionMouseScrollCounterTemp <<- length(scrollFastSingleDirectionMouseScrollEpisodeDat$sid)
      
      
      scrollFastScrollCyclePosDeltaTemp <<- scrollFastMouseScrollCycleEpisodeDat$positiveDelta
      scrollFastScrollCycleNegDeltaTemp <<- scrollFastMouseScrollCycleEpisodeDat$negativeDelta
      scrollFastScrollCycleTotalDeltaTemp <<- scrollFastMouseScrollCycleEpisodeDat$totalDelta
      scrollFastScrollCycleTotalDeltaAbsTemp <<- scrollFastMouseScrollCycleEpisodeDat$totalDeltaAbs
      scrollFastScrollCycleSpeedTemp <<- scrollFastMouseScrollCycleEpisodeDat$speed
      scrollFastScrollCycleSpeedAbsTemp <<- scrollFastMouseScrollCycleEpisodeDat$speedAbs
      scrollFastScrollCycleDurationTemp <<- scrollFastMouseScrollCycleEpisodeDat$duration
      
      scrollFastSingleDirectPosDeltaTemp <<- scrollFastSingleDirectionMouseScrollEpisodeDat$positiveDelta
      scrollFastSingleDirectNegDeltaTemp <<- scrollFastSingleDirectionMouseScrollEpisodeDat$negativeDelta
      scrollFastSingleDirectTotalDeltaTemp <<- scrollFastSingleDirectionMouseScrollEpisodeDat$totalDelta
      scrollFastSingleDirectTotalDeltaAbsTemp <<- scrollFastSingleDirectionMouseScrollEpisodeDat$totalDeltaAbs
      scrollFastSingleDirectSpeedTemp <<- scrollFastSingleDirectionMouseScrollEpisodeDat$speed
      scrollFastSingleDirectSpeedAbsTemp <<- scrollFastSingleDirectionMouseScrollEpisodeDat$speedAbs
      scrollFastSingleDirectDurationTemp <<- scrollFastSingleDirectionMouseScrollEpisodeDat$duration
      
      scrollControlledPosDeltaTemp <<- scrollControlledScrollEpisodeDat$positiveDelta
      scrollControlledNegDeltaTemp <<- scrollControlledScrollEpisodeDat$negativeDelta
      scrollControlledTotalDeltaTemp <<- scrollControlledScrollEpisodeDat$totalDelta
      scrollControlledTotalDeltaAbsTemp <<- scrollControlledScrollEpisodeDat$totalDeltaAbs
      scrollControlledSpeedTemp <<- scrollControlledScrollEpisodeDat$speed
      scrollControlledSpeedAbsTemp <<- scrollControlledScrollEpisodeDat$speedAbs
      scrollControlledDurationTemp <<- scrollControlledScrollEpisodeDat$duration
      
    }
    else{
      positiveScrollTemp <<- 0
      negativeScrollTemp <<- 0
      numberOfMousewheelTemp <<- 0
      
      controlledScrollCounterTemp <<- 0
      fastMouseScrollCycleCounterTemp <<- 0
      fastSingleDirectionMouseScrollCounterTemp <<- 0
      
      scrollFastScrollCyclePosDeltaTemp <<- 0
      scrollFastScrollCycleNegDeltaTemp <<- 0
      scrollFastScrollCycleTotalDeltaTemp <<- 0
      scrollFastScrollCycleTotalDeltaAbsTemp <<- 0
      scrollFastScrollCycleSpeedTemp <<- 0
      scrollFastScrollCycleSpeedAbsTemp <<- 0
      scrollFastScrollCycleDurationTemp <<- 0
      
      scrollFastSingleDirectPosDeltaTemp <<- 0
      scrollFastSingleDirectNegDeltaTemp <<- 0
      scrollFastSingleDirectTotalDeltaTemp <<- 0
      scrollFastSingleDirectTotalDeltaAbsTemp <<- 0
      scrollFastSingleDirectSpeedTemp <<- 0
      scrollFastSingleDirectSpeedAbsTemp <<- 0
      scrollFastSingleDirectDurationTemp <<- 0
      
      scrollControlledPosDeltaTemp <<- 0
      scrollControlledNegDeltaTemp <<- 0
      scrollControlledTotalDeltaTemp <<- 0
      scrollControlledTotalDeltaAbsTemp <<- 0
      scrollControlledSpeedTemp <<- 0
      scrollControlledSpeedAbsTemp <<- 0
      scrollControlledDurationTemp <<- 0
      
    }
    
    ##Get mouse statistics and behaviours
    if (nrow(mouseEpisodeDurationEpisodeDat)!=0){
      mousedownCounterTemp <<- mouseStatisticsEpisodeDat$mousedownCounter
      rightClickCounterTemp <<- mouseStatisticsEpisodeDat$rightClickCounter
      middleClickCounterTemp <<- mouseStatisticsEpisodeDat$middleClickCounter
      leftClickCounterTemp <<- mouseStatisticsEpisodeDat$leftClickCounter
      unknownClickCounterTemp <<- mouseStatisticsEpisodeDat$unknownClickCounter
      mouseupCounterTemp <<- mouseStatisticsEpisodeDat$mouseupCounter
      
      mouseClickSpeedCounterTemp <<- length(mouseClickSpeedEpisodeDat$sid)
      mouseEpisodeDurationCounterTemp <<- length(mouseEpisodeDurationEpisodeDat$sid)
      mouseFailToClickCounterTemp <<- length(mouseFailToClickEpisodeDat$sid)
      mouseHoveringOverCounterTemp <<- length(mouseHoveringOverEpisodeDat$sid)
      mouseIdleAfterClickCounterTemp <<- length(mouseIdleAfterClickEpisodeDat$sid)
      mouseIdleTimeCounterTemp <<- length(mouseIdleTimeEpisodeDat$sid)
      mouseLackOfMousePrecisionCounterTemp <<- length(mouseLackOfMousePrecisionEpisodeDat$sid)
      mouseRepeatedClicksCounterTemp <<- length(mouseRepeatedClicksEpisodeDat$sid)
      mouseStatisticsCounterTemp <<- length(mouseStatisticsEpisodeDat$sid)
      mouseTimeToClickCounterTemp <<- length(mouseTimeToClickEpisodeDat$sid)
      
      mouseClickSpeedClickTimeTemp <<- mouseClickSpeedEpisodeDat$clickTime
      
      mouseFailToClickStreakDurationTemp <<- mouseFailToClickEpisodeDat$mouseDownStreakDuration
      mouseFailToClickDistanceBetweenClicksTemp <<- mouseFailToClickEpisodeDat$totalDistanceBetweenClicks
      mouseFailToClickNumberOfClicksTemp <<- mouseFailToClickEpisodeDat$clickCounter
      
      mouseIdleAfterClickTimeTemp <<- mouseIdleAfterClickEpisodeDat$timeAfterClick
      
      mouseIdleTimeDurationListTemp <<- mouseIdleTimeEpisodeDat$mouseIdleTime
      
      mouseLackOfMousePrecisionFirstMouseOverTimeTemp <<- mouseLackOfMousePrecisionEpisodeDat$firstMouseOverTime
      mouseLackOfMousePrecisionNumberOfMouseOverTemp <<- mouseLackOfMousePrecisionEpisodeDat$mouseOverCounter
      
      mouseRepeatedClicksNumberOfClicksTemp <<- mouseRepeatedClicksEpisodeDat$numberOfClicks
      mouseRepeatedClicksTimeBetweenClicksTemp <<- mouseRepeatedClicksEpisodeDat$totalTimeBetweenClicks
      
      mouseTimeToClickTimeTemp <<- mouseTimeToClickEpisodeDat$timeToClick
      
    }
    else{
      
      mousedownCounterTemp <<- 0
      rightClickCounterTemp <<- 0
      middleClickCounterTemp <<- 0
      leftClickCounterTemp <<- 0
      unknownClickCounterTemp <<- 0
      mouseupCounterTemp <<- 0
      
      mouseClickSpeedCounterTemp <<- 0
      mouseEpisodeDurationCounterTemp <<- 0
      mouseFailToClickCounterTemp <<- 0
      mouseHoveringOverCounterTemp <<- 0
      mouseIdleAfterClickCounterTemp <<- 0
      mouseIdleTimeCounterTemp <<- 0
      mouseLackOfMousePrecisionCounterTemp <<- 0
      mouseRepeatedClicksCounterTemp <<- 0
      mouseStatisticsCounterTemp <<- 0
      mouseTimeToClickCounterTemp <<- 0
      
      mouseClickSpeedClickTimeTemp <<- 0
      
      mouseFailToClickStreakDurationTemp <<- 0
      mouseFailToClickDistanceBetweenClicksTemp <<- 0
      mouseFailToClickNumberOfClicksTemp <<- 0
      
      mouseIdleAfterClickTimeTemp <<- 0
      
      mouseIdleTimeDurationListTemp <<- 0
      
      mouseLackOfMousePrecisionFirstMouseOverTimeTemp <<- 0
      mouseLackOfMousePrecisionNumberOfMouseOverTemp <<- 0
      
      mouseRepeatedClicksNumberOfClicksTemp <<- 0
      mouseRepeatedClicksTimeBetweenClicksTemp <<- 0
      
      mouseTimeToClickTimeTemp <<- 0
    }
    
    ##Get mouse move statistics and behaviours
    #There isn't really any relevant information apart from the mousemove behaviour.
    if (nrow(mouseMoveStatisticsEpisodeDat)!=0){
      
      mouseMoveIncorrectMouseMoveCountTemp <<- mouseMoveBehaviourEpisodeDat$incorrectMouseMoveCount
      mouseMoveIncorrectMouseOverCountTemp <<- mouseMoveBehaviourEpisodeDat$incorrectMouseOverCount
      
      mouseMoveMouseMoveCountTemp <<- mouseMoveBehaviourEpisodeDat$mouseMoveCount
      mouseMoveMouseOverCountTemp <<- mouseMoveBehaviourEpisodeDat$mouseOverCount
      mouseMoveStartTimemsTemp <<- mouseMoveBehaviourEpisodeDat$startTimems
      mouseMoveTotalDistanceTemp <<- mouseMoveBehaviourEpisodeDat$totalDistance
      mouseMoveEndTimemsTemp <<- mouseMoveBehaviourEpisodeDat$endTimems
      
      
    }
    else{
      mouseMoveIncorrectMouseMoveCountTemp <<- 0
      mouseMoveIncorrectMouseOverCountTemp <<- 0
      
      mouseMoveMouseMoveCountTemp <<- 0
      mouseMoveMouseOverCountTemp <<- 0
      mouseMoveStartTimemsTemp <<- NA
      mouseMoveTotalDistanceTemp <<- NA
      mouseMoveEndTimemsTemp <<- NA
    }
    
    
    ##    TEMPORAL FIX
    ##Until we have sdCalculatedActiveTime, we'll just set it to -1
    if (is.null(sdCalculatedActiveTimeTemp))
      sdCalculatedActiveTimeTemp <<- -1
    
    newRow <<- constructRowFromTempVars()
    
    ##AVOID rbind!! It ignores empty dataframse, so it erases all my column names...
    #episodeDF <<- rbind(episodeDF, newRow)
    #I need to add the sid and url separately...
    
    #     print(paste("TEST!!",sidTemp))
    #     print(newRow)
    episodeDF[nrow(episodeDF)+1,] <<-as.numeric(newRow)
    episodeDF$sid[nrow(episodeDF)] <<-as.character(sidTemp)
    episodeDF$url[nrow(episodeDF)] <<-as.character(urlTemp)
    #     
    #     print(paste("TEST2!!",sidTemp))
    #           print(newRow)
    #           
    
    
  }
  #print (paste("This user provided ",nrow(episodeDF)," episodes"))
  
  if (listOfEmptyEpisodes!="")
    print (paste("This user (",userId,") had 0 rows for episodes:",listOfEmptyEpisodes))
  
}

##USES the episodeDF GENERATED BY episodeQuantification
##Given the episodeListDF  for a user, it looks for episode streaks (everyday interactions for a minimum amount of days)
#and add them to the episodeStreakPool
episodeStreakPoolGenerator <- function (){
  
  #Number of episodes with weird times...
  oddTimeCounters <<- 0
  
  #The time between episodes must be less than:
  timeBetweenEpiThresh <<- 1*24*60*60*1000;
  #The total duration should be at least this number of days.
  timeWithinEpiTheshold <<- 3*24*60*60*1000;
  
  lastInEpisodeStreakTS = 0;
  firstTSinGroup = 0;
  
  episodeStreakDF <- NULL
  #TEMPORAL episode holder
  episodeStreakDF <-getNewDataFrame()
  
  #QUICKFIX FOR WHEN EPISODEDF IS EMPTY
  
  if (length(episodeDF$positiveScroll)==0){
    return (FALSE)
  }
  
  for (episodeIndex in 1:length(episodeDF$positiveScroll)){
    episodeObject = episodeDF[episodeIndex,]
    
    #If urlSinceLastSession is '0', that means there was no urlEpisode for this index, meaning there was no scroll...
    if (episodeObject$urlSinceLastSession != 0){
      
      #if current episode is within reach of the previous one
      if ((episodeObject$sessionstartms - lastInEpisodeStreakTS)<timeBetweenEpiThresh){
        #Add it to the list
        newRow <<- constructRowFromEpisodeObject(episodeObject)
        #Avoiding rbind
        #episodeStreakDF <<- rbind(episodeStreakDF, newRow)
        episodeStreakDF[nrow(episodeStreakDF)+1,] <- as.numeric(newRow)
        episodeStreakDF$sid[nrow(episodeStreakDF)] <-as.character(episodeObject$sid)
        
        lastInEpisodeStreakTS = episodeObject$sessionstartms
      }
      #If not, check current list to see if the time between first and last is big enough
      else
      {
        #We don't want to check the first episode evenr, so we add firstTSinGroup!=0 to all conditions
        if(firstTSinGroup!=0 && ((lastInEpisodeStreakTS - firstTSinGroup)>timeWithinEpiTheshold)){
          #Analyse the tendency within these episodes
          #print(paste("Found episode WAS LONG enough, it was: ",(lastInEpisodeStreakTS - firstTSinGroup), " ms long"))
          
          addEpisodeStreakToPool(episodeStreakDF)
        }
        else if (firstTSinGroup!=0){
          #print(paste("Found episode was not long enough, it was: ",(lastInEpisodeStreakTS - firstTSinGroup), " ms long"))
          
          if ((lastInEpisodeStreakTS - firstTSinGroup)<0){
            print (paste (lastInEpisodeStreakTS,",",firstTSinGroup))
            oddTimeCounters <<- oddTimeCounters +1
          }
        }
        
        #restart the group, adding current one as first
        firstTSinGroup = episodeObject$sessionstartms
        lastInEpisodeStreakTS = episodeObject$sessionstartms
        episodeStreakDF <- episodeStreakDF[FALSE, ]
        
        #Add it to the list
        newRow <<- constructRowFromEpisodeObject(episodeObject)
        #episodeStreakDF <- rbind(episodeStreakDF, newRow)
        episodeStreakDF[nrow(episodeStreakDF)+1,] <-as.numeric(newRow)
        episodeStreakDF$sid[nrow(episodeStreakDF)] <-as.character(episodeObject$sid)
        
      }
    }
  }
}

#This function will  analyse the trends within a streak of episodes taking place within certain time boundaries.
#NOT FINISHED!
analyseEpisodeStreak <- function(episodeStreakDF){
  #for each column in the DF, calculate the Linear model.
  #I'll use the sessionstartms as the timeaxis, and the column name
  #For each element in this list, get the lm with the time, as well as the lm of the object divided by the episodeDuration.
  
  valueColumnNameList = c("positiveScroll",
                          "negativeScroll",
                          "numberOfMousewheel",
                          "controlledScrollCounter",
                          "fastMouseScrollCycleCounter",
                          "fastSingleDirectionMouseScrollCounter")
  for (valueIndex in valueColumnNameList){
    #Regular attribute
    metricGradient(episodeStreakDF[[valueIndex]]~episodeStreakDF$sessionstartms)
    #Attribute divided by episode duration
    metricGradient((episodeStreakDF[[valueIndex]]/episodeStreakDF$episodeDurationms)~episodeStreakDF$sessionstartms)
    
    #fitted.values gives me the value that the linear model gives to that particular point.
    #residuals gives me the difference between the fitted value and the real one.
    #coefficients are the values of the line formula that emulates the given values (mx+y)
    #I will use the residuals to compute an "error" function.
    #I will use the concept of "standard error"
    
  }
  
}



#This function will  add a given episodeStrak to a "pool" of episodes
#It will normalise the times, so all starts of episode streaks are the same.
addEpisodeStreakToPool <- function(episodeStreakDF){
  #We need to normalise the time to the range defined to be the minimum within boundary.
  #That means that episodes which are beyond the threshold will have time values of over 1
  
  #The total duration should be at least timeWithinEpiTheshold
  timeThresholdArray = c(0,timeWithinEpiTheshold)
  
  episodeStreakDF$sessionstartms = range01FromOther(episodeStreakDF$sessionstartms,timeThresholdArray)
  
  print("ADDING EPISODE STREAK TO EPISODE POOL")
  #sessionstartms is now normalise, we can add the entire episodeStreakDF to the pool
  
  #Avoiding rbind
  episodeStreakPool <<- rbind(episodeStreakPool, episodeStreakDF)
  #episodeStreakPool[nrow(episodeStreakPool)+1,] <<-episodeStreakDF Won't work!! it's not just a row...
  
}

#This function will return a metric based on the gradient of the given subset of the dat.
#It will return two different objects, the gradient metric, and the actual gradient, so it can be later used for plotting purposes
metricGradient <- function(timeAxis, valueAxis){
  
  #The following gives me the slope of the linear model
  gradient = lm(valueAxis~timeAxis)
  slope = as.numeric(gradient$coefficient[2])
  firstPoint = valueAxis[1]
  
  gradientMetric=c()
  gradientMetric["slope"] = slope
  gradientMetric["firstPoint"] = firstPoint
  return (list("gradient" = gradient,
               "gradientMetric" = gradientMetric))
}


#For each user in the data, it will call all the functions necessary to:
# 1) Filter out data from other users
# 2) Look for "episode streaks" (continous interaction streaks for a minimum amount of days)
# 3) Creation of an episodePool with episode streaks from all users
# 4) analysis of this pool (linear model, taking into account the sessionstarttimems)
main <- function(){
  print (paste("Reloading Data at ",Sys.time()))
  resetAndReload()
  #singleUserId <- userSid #'VVwNnM0yHm6k'
  analysedUrl <- 'http://www.kupkb.org/tab0'#'http://www.cs.manchester.ac.uk/study/undergraduate/courses/'#
  ##Filtering out everything not related to our URL will speed things up
  filterSingleUrl(analysedUrl)
  
  #After loading the data, we'll keep a global copy of everything, to retrieve users after filtering
  saveCurrentDatToGlobal()
  
  
  ##GLOBAL EPISODE POOL We'll add all the episodes to this "pool", to then apply linear regression
  globalEpisodePool  <<- getNewDataFrame()
  
  ##This other "pool" will only contain "streak" episodes
  episodeStreakPool  <<- getNewDataFrame()
  
  
  
  userCounter = 1
  emptyUserCounter <<- 0
  listOfusers = (c(as.character(scrollStatisticsDat$sid),as.character(mouseStatisticsDat$sid),as.character(mouseMoveStatisticsDat$sid)))
  totalUserCounter = length(unique(listOfusers))
  
  totalUserCount = length(listOfusers)
  userCount  = 0
  lastReport = 0
  
  
  for (userIndex in unique(listOfusers)){
    
    ##Progress feedback
    userCount = userCount + 1
    if ((userCount/totalUserCount)*100 > (lastReport+10)){
      lastReport = (userCount/totalUserCount)*100
      print(paste(lastReport,"% of users done"))
    }
    
    #Filter unwanted users
    filterSingleUser(userIndex)
    
    #There is a chance that this user didn't have any interaction with that url
    if (length(scrollStatisticsDat$sid)<2){
      #print(paste("user ",userIndex," contained too few recordings for the analysedUrl"))
      emptyUserCounter <<- emptyUserCounter + 1
    }
    else{
      #print("episodeQuantification")
      #Using the accessible data for a single user and url, the following funciton creates episodeDF, where episodes are quantified
      episodeQuantification() 
      globalEpisodePool <<- rbind(globalEpisodePool, episodeDF)
      #print("episodeStreakPoolGenerator")
      #Using the episodeDF generated by episodeQuantification, it creates an episodeStrakPool with all the episode streaks
      episodeStreakPoolGenerator()
    }
    
    #Restore all users before processing the next one
    restoreDataFromGlobal()
    
  }
  print (paste(emptyUserCounter," empty users found"))
  
  
  #   valueColumnNameList = c("positiveScroll",
  #                           "negativeScroll",
  #                           "numberOfMousewheel",
  #                           "controlledScrollCounter",
  #                           "fastMouseScrollCycleCounter",
  #                           "fastSingleDirectionMouseScrollCounter")
  
}


#This fucntion will just get rid of all the variables that we don't need any more after the execution of "main"
purgeVariablesAfterMain <- function(){
  rm(episodeDF)
  rm(newRow)
  
  #SCROLLL BEHAVIOURS
  rm(scrollStatisticsDat)
  rm(scrollEpisodeDurationDat)
  rm(scrollControlledScrollDat)
  rm(scrollFastMouseScrollCycleDat)
  rm(scrollFastSingleDirectionMouseScrollDat)
  
  ###MOUSE BEHAVIOURS
  rm(mouseStatisticsDat)
  rm(mouseEpisodeDurationDat)
  rm(mouseClickSpeedDat)
  rm(mouseFailToClickDat)
  rm(mouseHoveringOverDat)
  rm(mouseIdleAfterClickDat)
  rm(mouseIdleTimeDat)
  rm(mouseLackOfMousePrecisionDat)
  rm(mouseRepeatedClicksDat)
  rm(mouseTimeToClickDat)
  
  #MOUSE MOVE BEHAVIOURS
  rm(mouseMoveStatisticsEpisodeDat)
  rm(mouseMoveEpisodeDurationDat)
  rm(mouseMoveBehaviourDat)
  
  
  #EPISODES
  #SCROLLL BEHAVIOURS
  rm(scrollStatisticsEpisodeDat)
  rm(scrollEpisodeDurationEpisodeDat)
  rm(scrollControlledScrollEpisodeDat)
  rm(scrollFastMouseScrollCycleEpisodeDat)
  rm(scrollFastSingleDirectionMouseScrollEpisodeDat)
  
  ###MOUSE BEHAVIOURS
  rm(mouseStatisticsEpisodeDat)
  rm(mouseEpisodeDurationEpisodeDat)
  rm(mouseClickSpeedEpisodeDat)
  rm(mouseFailToClickEpisodeDat)
  rm(mouseHoveringOverEpisodeDat)
  rm(mouseIdleAfterClickEpisodeDat)
  rm(mouseIdleTimeEpisodeDat)
  rm(mouseLackOfMousePrecisionEpisodeDat)
  rm(mouseRepeatedClicksEpisodeDat)
  rm(mouseTimeToClickEpisodeDat)
  
  
  rm(sessionstartmsTemp)
  rm(urlSessionCounterTemp)
  rm(urlSinceLastSessionTemp)
  rm(urlEpisodeDurationmsTemp)
  rm(episodeDurationmsTemp)
  rm(calculatedActiveTimeTemp)
  #Scroll attributes
  rm(positiveScrollTemp)
  rm(negativeScrollTemp)
  rm(numberOfMousewheelTemp)
  
  #scrollBehaviour attributes
  rm(scrollFastScrollCyclePosDeltaTemp)
  rm(scrollFastScrollCycleNegDeltaTemp)
  rm(scrollFastScrollCycleTotalDeltaTemp)
  rm(scrollFastScrollCycleTotalDeltaAbsTemp)
  rm(scrollFastScrollCycleSpeedTemp)
  rm(scrollFastScrollCycleSpeedAbsTemp)
  rm(scrollFastScrollCycleDurationTemp)
  
  rm(scrollFastSingleDirectPosDeltaTemp)
  rm(scrollFastSingleDirectNegDeltaTemp)
  rm(scrollFastSingleDirectTotalDeltaTemp)
  rm(scrollFastSingleDirectTotalDeltaAbsTemp)
  rm(scrollFastSingleDirectSpeedTemp)
  rm(scrollFastSingleDirectSpeedAbsTemp)
  rm(scrollFastSingleDirectDurationTemp)
  
  rm(scrollControlledPosDeltaTemp)
  rm(scrollControlledNegDeltaTemp)
  rm(scrollControlledTotalDeltaTemp)
  rm(scrollControlledTotalDeltaAbsTemp)
  rm(scrollControlledSpeedTemp)
  rm(scrollControlledSpeedAbsTemp)
  rm(scrollControlledDurationTemp)
  
  #scrollBehaviourCounters
  rm(controlledScrollCounterTemp)
  rm(fastMouseScrollCycleCounterTemp)
  rm(fastSingleDirectionMouseScrollCounterTemp)
  
  #Mouse attributes
  rm(mousedownCounterTemp)
  rm(rightClickCounterTemp)
  rm(middleClickCounterTemp)
  rm(leftClickCounterTemp)
  rm(unknownClickCounterTemp)
  rm(mouseupCounterTemp)
  
  #mousebehaviour attributes
  rm(mouseClickSpeedClickTimeTemp)
  rm(mouseFailToClickStreakDurationTemp)
  rm(mouseFailToClickDistanceBetweenClicksTemp)
  rm(mouseFailToClickNumberOfClicksTemp)
  rm(mouseIdleAfterClickTimeTemp)
  rm(mouseIdleTimeDurationListTemp)
  rm(mouseLackOfMousePrecisionFirstMouseOverTimeTemp)
  rm(mouseLackOfMousePrecisionNumberOfMouseOverTemp)
  rm(mouseRepeatedClicksNumberOfClicksTemp)
  rm(mouseRepeatedClicksTimeBetweenClicksTemp)
  rm(mouseTimeToClickTimeTemp)
  
  #mousebehaviourCounters
  rm(mouseClickSpeedCounterTemp)
  rm(mouseEpisodeDurationCounterTemp)
  rm(mouseFailToClickCounterTemp)
  rm(mouseHoveringOverCounterTemp)
  rm(mouseIdleAfterClickCounterTemp)
  rm(mouseIdleTimeCounterTemp)
  rm(mouseLackOfMousePrecisionCounterTemp)
  rm(mouseRepeatedClicksCounterTemp)
  rm(mouseStatisticsCounterTemp)
  rm(mouseTimeToClickCounterTemp)
  
  ##Mousemove Behaviours
  rm(mouseMoveIncorrectMouseMoveCountTemp)
  rm(mouseMoveIncorrectMouseOverCountTemp)
  rm(mouseMoveMouseMoveCountTemp)
  rm(mouseMoveMouseOverCountTemp)
  rm(mouseMoveStartTimemsTemp)
  rm(mouseMoveTotalDistanceTemp)
  rm(mouseMoveEndTimemsTemp)
}

#Load all data from all urls
#The difference with "main" is that this function needs to call episodeQuantification once for each url the user has visited
loadAllEpisodes <- function(){
  print (paste("Reloading Data at ",Sys.time()))
  resetAndReload()
  
  #After loading the data, we'll keep a global copy of everything, to retrieve users after filtering
  saveCurrentDatToGlobal()
  
  ##GLOBAL EPISODE POOL We'll add all the episodes to this "pool", to then apply linear regression
  globalEpisodePoolAllUrls  <<- getNewDataFrame()
  
  emptyUserCounter <<- 0
  listOfusers = (c(as.character(scrollStatisticsDatGlobal$sid),as.character(mouseStatisticsDatGlobal$sid),as.character(mouseMoveStatisticsDatGlobal$sid)))
  
  
  #TEST
  #listOfusers  = c("02sL4FNlb5eW")
  listOfusers = unique(listOfusers)
  
  totalUserCount = length(listOfusers)
  userCount  = 0
  lastReport = 0
  startTime = Sys.time()
  
  emptyUserUrlCounter = 0
  
  for (userIndex in listOfusers){
    
    #Restore all users and all urls
    restoreDataFromGlobal()
    
    ##Progress feedback
    userCount = userCount + 1
    if ((userCount/totalUserCount)*100 > (lastReport+10)){
      lastReport = (userCount/totalUserCount)*100
      print(paste(lastReport,"% of users done"))
    }
    
    #Filter unwanted users
    filterSingleUser(userIndex)
    
    #We make sure we have enough visits from that user, we want at least 3 episodes
    #If not, we'' just ignore it
    if (TRUE){#(!length(scrollStatisticsDat$sid)<4){
      
      listOfUrlForUser = (c(as.character(scrollStatisticsDat$url),as.character(mouseStatisticsDat$url),as.character(mouseMoveStatisticsDat$url)))
      listOfUrlForUser = unique(listOfUrlForUser)
      listOfUrlForUser =  listOfUrlForUser[listOfUrlForUser!=""]
      
      print(paste("urls for user ",userIndex," are: "))
      print(paste(listOfUrlForUser,collapse=" ,"))
      print(paste((userCount/totalUserCount)*100,"% of users done"))
      
      print("Time elapsed was:")
      print(Sys.time() - startTime)
      
      for (urlIndex in listOfUrlForUser){
        
        #       print("filter Url")
        
        #FOR EACH URL FOR THAT USER
        filterSingleUrl(urlIndex)
        
        #There is a chance that this user didn't have any interaction with that url
        if (length(scrollStatisticsDat$sid)<1 && length(mouseStatisticsDat$sid)<1){
          #print(paste("user ",userIndex," contained too few recordings for the analysedUrl"))
          emptyUserUrlCounter = emptyUserUrlCounter + 1
          #         print("empty")
        }
        else{
          #         print("episodeQuantification")
          # print (paste("analysing ",nrow(scrollStatisticsDat)," rows"))
          print(paste("Quantifying episodes of user ",userIndex," with url ",urlIndex))
          #Using the accessible data for a single user and url, the following funciton creates episodeDF, where episodes are quantified
          episodeQuantification() 
          #print (paste("Adding",nrow(episodeDF)," rows to pool"))
          
          globalEpisodePoolAllUrls <<- rbind(globalEpisodePoolAllUrls, episodeDF)
          #print(paste("globalEpisodePoolAllUrls size so far is ",nrow(globalEpisodePoolAllUrls), " rows"))
        }
        #       print("restoreData")
        
        #Restore all users and all urls
        restoreDataFromGlobal()
        
        #       print("filter User")
        
        #Filter the user again, as we have loaded it back
        filterSingleUser(userIndex)
      }
      if (emptyUserUrlCounter > 0)
        print (paste(emptyUserUrlCounter," empty urls found for this user ",userIndex))
      emptyUserUrlCounter = 0
    }
  }
  
}

#This function adds a trimmedUrl option, in which the start of the url is removed
addTrimmedUrlToDF <- function(df){
  # This regular expression finds everything before the 3rd "/"   ^.*?//*.*?/
  #   ^: start of line
  #   .*: any character
  #   ?//: first occurrence of "//"
  #   .*: any character again
  #   ?/: first occurrence of "/"
  #gsub("^.*?//.*?/","","http://www.cs.manchester.ac.uk/people/news/full-article/?articleid=559" )
  #Remove the starting part of http://domain/
  #if there are any empty values after that, replace them with HOME, as it means they were just the domain
  df$urlTrimmed <- gsub("^.*?//.*?/","",df$url)
  df$urlTrimmed[df$urlTrimmed==""] <- "HOME"
  
  #Remove everything after an interrogation mark to make all "search" urls match
  #   gsub("\\?(.*)","","http://www.cs.manchester.ac.uk/people/news/full-article/?articleid=559" )
  #   gsub("\\?(.*)","","study/postgraduate-taught/courses/acswitm/?code=02066&pg=options&courseunitcode=COMP60721" )
  #   
  df$urlTrimmed <- gsub("\\?(.*)","",df$urlTrimmed)
  
  #Extract the domain
  df$urlDomain <- str_extract(df$url,"(.*?//.*?/.*?)")
  return(df)
}

#This function will just save and load the object created by loadAllEpisodes()
saveLoadAllEpisodes <- function(){
  save(globalEpisodePoolAllUrls, file = paste(rDataWorkspacePath,"globalEpisodePoolAllUrlsObject.RData",sep=""))
}
#DOESN'T work from inside the function!!
#I need to run the line from outside
loadLoadAllEpisodes <- function(){
  load(paste(rDataWorkspacePath,"globalEpisodePoolAllUrlsObject.RData",sep=""))
  #load(paste(rDataWorkspacePath,"globalEpisodePoolAllUrlsObjectBACKUP.RData",sep=""))
  
  
  #Filter empty episodes (they should have been filtered already anyway!)
  globalEpisodePoolAllUrls = globalEpisodePoolAllUrls[globalEpisodePoolAllUrls$sessionstartms!=0,]
  globalEpisodePoolAllUrls = globalEpisodePoolAllUrls[globalEpisodePoolAllUrls$calculatedActiveTime>=0,]
  
}


###This function will return a structure of orderedUrlVisits
#I will try using TraMineR library, which has been quite used in research. If used, I'll need to cite it!!
#citation("TraMineR") gives that information
urlVisitSequenceFrameCreator <- function(){
  
  #First I need to create a complying data structure
  #In order to use seqdef, I need a data structure for each user and sdEpisode, with a url per column
  
  loadLoadAllEpisodes()
  
  #Add a trimmed url column, to avoid urls being too long
  globalEpisodePoolAllUrls <<- addTrimmedUrlToDF(globalEpisodePoolAllUrls)
  urlSequenceFrame <<- list()
  
  totalUserCount = length(unique(globalEpisodePoolAllUrls$sid))
  userCount  = 0
  lastReport = 0
  
  for (userIndex in unique(globalEpisodePoolAllUrls$sid)){
    
    ##Progress feedback
    userCount = userCount + 1
    if ((userCount/totalUserCount)*100 > (lastReport+10)){
      lastReport = (userCount/totalUserCount)*100
      print(paste(lastReport,"% of users done"))
    }
    
    userEpisodes <- globalEpisodePoolAllUrls[globalEpisodePoolAllUrls$sid==userIndex,]
    #Sort them by sessionstartms (although the order should be the same)
    userEpisodes <- userEpisodes[order(userEpisodes$sessionstartms),]
    
    for (sdEpisodeIndex in 1:max(userEpisodes$sdSessionCounter)){
      #get the urls for that sdEpisode
      urlList <- userEpisodes$urlTrimmed[userEpisodes$sdSessionCounter==sdEpisodeIndex]
      rowIndex = paste(userIndex,sdEpisodeIndex,sep="_")
      
      #       if (length(urlList)>1){
      #Add user and sdEpisode info to the row
      
      urlSequenceFrame[[rowIndex]] <<- c(userIndex,sdEpisodeIndex,length(urlList),urlList)
      #       }
    }
  }
  
  #Now I need to standardize the sequence Frame
  #I will look for the longest list, and append extra "mock" elements to the rest of the lists, representing the same
  
  #Instead of loops, we could have just access the length(urlList) inside each row, but it's not a dataframe ye
  longestList <<- 1
  longestRowIndex <<- ""
  urlSequenceLengthList <<- c()
  
  
  for (rowIndex in names(urlSequenceFrame)){
    urlSequenceLengthList <<- c(urlSequenceLengthList,length(urlSequenceFrame[[rowIndex]]))
    if (length(urlSequenceFrame[[rowIndex]])>longestList){
      longestList <<- length(urlSequenceFrame[[rowIndex]])
      longestRowIndex <<- rowIndex
    }
  }
  
  for (rowIndex in names(urlSequenceFrame)){
    if (length(urlSequenceFrame[[rowIndex]])<longestList){
      #Append extra empty episodes to make it match the longest list
      urlSequenceFrame[[rowIndex]] <<- c(urlSequenceFrame[[rowIndex]]
                                         ,rep("EMPTY",longestList-length(urlSequenceFrame[[rowIndex]])))
    }
  }
  
  #Transform the urlSequenceFrame list to a dataframe
  urlSequenceFrame <<- data.frame(matrix(unlist(urlSequenceFrame)
                                         , nrow=length(urlSequenceFrame), byrow=T),stringsAsFactors=FALSE)
  #For the shake of clarity, I will name the first three columns (userId and sd episodeIndex)
  colnames(urlSequenceFrame)[1] <<- "sid"
  colnames(urlSequenceFrame)[2] <<- "sdEpisode"
  colnames(urlSequenceFrame)[3] <<- "sequenceLength"
  
  urlSequenceLengthList <<- urlSequenceLengthList-3
  
}

#This function will just save and load the object created by loadAllEpisodes()
saveUrlVisitSequenceFrameCreator <- function(){
  save(urlSequenceFrame, file = paste(rDataWorkspacePath,"urlSequenceFrame.RData",sep=""))
  save(urlSequenceFrame, file = paste(rDataWorkspacePath,"urlSequenceFrameBIG.RData",sep=""))
  
}
#DOESN'T work from inside the function!!
#I need to run the line from outside
loadUrlVisitSequenceFrameCreator <- function(){
  load(paste(rDataWorkspacePath,"urlSequenceFrame.RData",sep=""))
  load(paste(rDataWorkspacePath,"urlSequenceFrameBIG.RData",sep=""))
  
}



##Uses the TraMineR package to find common sequences and plot the most frequent ones
urlVisitSequenceAnalysis <- function(minSequenceLength = 2, maxSequenceLength = -1){
  
  #Install TraMineR package first!!
  library(TraMineR)
  
  loadUrlVisitSequenceFrameCreator()
  
  
  urlSequenceFrame = as.data.frame(sapply(urlSequenceFrame,gsub,pattern="-",replacement="_"))
  
  ##EXAMPLE DATA AND PLOTS in http://mephisto.unige.ch/traminer/preview-main.shtml
  
  #urlSequenceLengthList, created in urlVisitSequenceFrameCreator(), contains the length of all the episodes
  #urlSequenceLengthListTemp = urlSequenceLengthList
  #Makes more sense getting this list directly from the dataframe
  urlSequenceLengthListTemp = as.numeric(as.character(urlSequenceFrame$sequenceLength))
  
  #Filter userId, episode and length
  analysisUrlSequenceFrame = urlSequenceFrame[,4:ncol(urlSequenceFrame)]
  
  #We'll filter any sequence above that threshold
  if(maxSequenceLength == -1)
    maxSequenceLength = ncol(analysisUrlSequenceFrame)#60
  
  print (paste("Filtering ", length(which(urlSequenceLengthListTemp > maxSequenceLength)), " sequences longer than ", maxSequenceLength,
               ", leaving ", length(which(urlSequenceLengthListTemp <= maxSequenceLength))," sequences left at ",Sys.time()))
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[urlSequenceLengthListTemp<=maxSequenceLength,]
  urlSequenceLengthListTemp = urlSequenceLengthListTemp[urlSequenceLengthListTemp<=maxSequenceLength]
  
  #We'll filter any sequence below that threshold
  print (paste("Filtering ", length(which(urlSequenceLengthListTemp < minSequenceLength)), " sequence shorter than ", minSequenceLength,
               ", leaving ", length(which(urlSequenceLengthListTemp >= minSequenceLength))," sequences left at ",Sys.time()))
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[urlSequenceLengthListTemp>=minSequenceLength,]
  urlSequenceLengthListTemp=urlSequenceLengthListTemp[urlSequenceLengthListTemp>=minSequenceLength]
  
  #Filter out the unwanted columns
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[,1:maxSequenceLength]
  
  #Just for this test, I will run the algorithm with a limited amount of lines
  numberOfRowsAnalysed = nrow(analysisUrlSequenceFrame)#100#
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[1:numberOfRowsAnalysed,]
  
  #I will use the most frequent top 100 sequences
  #   ind <- table(apply(urlSequenceFrame, 1, paste, collapse = "/")) 
  #   ind <- which.max(ind) 
  #   as.numeric(strsplit(names(ind), "/")[[1]]) 
  
  #We need to create the alphabet of sequences, so we loop through the sequences to use and extract the unique urls
  urlFullList <<- c()
  
  for (rowIndex in 1:nrow(analysisUrlSequenceFrame)){
    for (colIndex in 1:maxSequenceLength){
      urlTemp = analysisUrlSequenceFrame[rowIndex,colIndex]
      if (!urlTemp %in% urlFullList){
        #We update the full list of urls
        urlFullList <<- c(urlFullList,as.character(urlTemp))
      }
    }
  }
  #By ordering the urlList, the colours will make more sense
  urlFullList = sort(urlFullList)
  
  seqstatl(analysisUrlSequenceFrame[, 1:maxSequenceLength])
  
  analysisUrlSequenceFrame.alphabet <- urlFullList
  analysisUrlSequenceFrame.labels <- urlFullList
  analysisUrlSequenceFrame.scodes <- urlFullList
  analysisUrlSequenceFrame.seq <- seqdef(analysisUrlSequenceFrame, 1:maxSequenceLength
                                         , alphabet = analysisUrlSequenceFrame.alphabet
                                         , states = analysisUrlSequenceFrame.scodes, 
                                         labels =analysisUrlSequenceFrame.labels, xtstep = 6)
  
  testFrame.alphabet <<- analysisUrlSequenceFrame.alphabet
  testFrame.labels <<- analysisUrlSequenceFrame.labels
  testFrame.scodes <<- analysisUrlSequenceFrame.scodes
  testFrame.seq <<- analysisUrlSequenceFrame.seq
  
  
  #To set the colours, I will use the RcolorBrewer package
  library(RColorBrewer)
  # We want to use all the 12 colours from set3, but we also add the colorrampPalette function to create more colours by interpolating existing ones.
  getColour = colorRampPalette(brewer.pal(12,"Set3"))
  numberOfColoursReq = length(urlFullList)
  #I would then use this function by saying getColour(numberOfColoursReq)
  #I want "EMPTY" light grey and "" to be white ("" is the main page, as it was completely trimmed out)
  colourPalette = getColour(numberOfColoursReq)
  
  
  colourPalette = brewer.pal(numberOfColoursReq,"Set3") 
  colourPalette[urlFullList=="EMPTY"] = "#E7E7E7"
  colourPalette[urlFullList=="HOME"] = "#FFFFFF"
  
  cpal(analysisUrlSequenceFrame.seq) <- colourPalette
  
  par(mfrow = c(1, 1))
  #Plot first 10 sequences
  #   seqiplot(analysisUrlSequenceFrame.seq, withlegend = FALSE, border = NA)
  #   title(main="First 10 sequences")
  #Plot all sequences
  #   seqIplot(analysisUrlSequenceFrame.seq, sortv = "from.start", withlegend = FALSE)
  #   title(main="All sequences")
  
  #Plot most frequent sequences
  numberOfFrecuencies = 20
  seqfplot(analysisUrlSequenceFrame.seq, withlegend = FALSE, border = NA,tlim=1:numberOfFrecuencies)
  title(main=paste(numberOfFrecuencies," most frequent sequences (bottom up)"))
  
  print(paste("The most common ", numberOfFrecuencies," sequences were:"))
  print(seqtab(analysisUrlSequenceFrame.seq,tlim = 1:numberOfFrecuencies))
  
  
  numberOfFrecuencies = 100
  seqfplot(analysisUrlSequenceFrame.seq, withlegend = FALSE, border = NA,tlim=1:numberOfFrecuencies)
  title(main=paste(numberOfFrecuencies," most frequent sequences (bottom up)"))
  #   print(paste("The most common ", numberOfFrecuencies," sequences were:"))
  #   print(seqtab(analysisUrlSequenceFrame.seq,tlim = numberOfFrecuencies))
  
  #Plot legend
  seqlegend(analysisUrlSequenceFrame.seq,fontsize=1)
  title(main=paste("Legend with ",numberOfColoursReq," states"))
  
  #PLot options to be called after the seplot
  # axis(1, at = c(0, 5, 10, 15, 20, 25) , labels = c(15, 20, 25, 30, 35, 40))
  # axis(2, at = c(0,50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600))
  # title(main = "(a) Sequence Index Plot")
}

#Looks for FULL sequence repetitions within users.
urlVisitSequenceAnalysisWithinUsers <- function(){
  
  #We need to set the length of the urlSequence to be analysed
  #urlSequenceLengthListTemp = urlSequenceLengthList
  urlSequenceLengthListTemp = as.numeric(as.character(urlSequenceFrame$sequenceLength))
  
  
  frequencyList = list()
  
  #We filter out users who fall below this frequency limit
  minimumFrequency = 2
  
  analysisUrlSequenceFrame = urlSequenceFrame#[1:100,]
  analysisUrlSequenceFrame = data.frame(lapply(analysisUrlSequenceFrame, as.character), stringsAsFactors=FALSE)
  
  #We'll filter any sequence below that threshold
  minSequenceLength = 2
  print (paste("Filtering ", length(which(urlSequenceLengthListTemp < minSequenceLength)), " sequence shorter than ", minSequenceLength,
               ", leaving ", length(which(urlSequenceLengthListTemp >= minSequenceLength))," sequences left at ",Sys.time()))
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[urlSequenceLengthListTemp>=minSequenceLength,]
  urlSequenceLengthListTemp=urlSequenceLengthListTemp[urlSequenceLengthListTemp>=minSequenceLength]
  
  
  
  #I create an empty dataframe with the same columns
  #The command "setNames" requires a list of types, and a list of column names
  frequentSequencesFrame<<-NULL
  columnNames = c("freqCounter",names(urlSequenceFrame))
  frequentSequencesFrame <<- as.data.frame(setNames(replicate(length(columnNames),numeric(0), simplify = F),columnNames), stringsAsFactors = FALSE)
  frequentSequencesFrameNew <<- data.frame(frequentSequencesFrame, stringsAsFactors = FALSE)
  
  frequentSequencesFrame = data.frame(lapply(frequentSequencesFrame, as.character), stringsAsFactors=FALSE)
  
  
  #For each user
  for (userIndex in unique(analysisUrlSequenceFrame$sid)){
    userUrlSequence = analysisUrlSequenceFrame[analysisUrlSequenceFrame$sid==userIndex,]
    
    #Extract userId, episodeIndex and length, but leave a copy behind
    userUrlSequenceFull = userUrlSequence
    userUrlSequence = userUrlSequence[,4:ncol(userUrlSequence)]
    
    
    if (nrow(userUrlSequence) >= minimumFrequency){
      lastBigUser = userUrlSequence
      #Compare all sequencies with each other.
      userSequenceVector <- c()
      for (rowIndex in 1:nrow(userUrlSequence)){
        #To do that, I first need a list with all the vectors
        userSequenceVector <- c(userSequenceVector,paste( as.character(unlist(userUrlSequence[rowIndex,])),collapse='-->'))
      }
      #After this I can just use the "table" method to find repetitions
      #We sort it decreasingly, so the frequent sequences go first
      userSequenceFrequency = sort(table(userSequenceVector),decreasing = TRUE)
      #For each repeating frequency, store it next to the number of occurrences.
      if (length(userSequenceFrequency[userSequenceFrequency>1])>=1){
        print("frequent sequence within user found")
        for (freqIndex in 1:length(userSequenceFrequency[userSequenceFrequency>1])){
          #get the index that corresponds to the frequent sequence
          #names(userSequenceFrequency) gives me the sequences, which I will have to look into userSequenceVector
          #The index of the frequent frequency IN userSequenceVector, corresponds withe the rowIndex for userUrlSequence
          frequentSequence = names(userSequenceFrequency[freqIndex])
          sequenceRowIndex = match(frequentSequence,userSequenceVector)
          
          #We also want to have the frequency counter, I'll add it to the start
          newRow <<- c(as.numeric(userSequenceFrequency[freqIndex]),userUrlSequenceFull[sequenceRowIndex,])
          names(newRow)[1] <<- "freqCounter"
          frequentSequencesFrame <<- rbind(frequentSequencesFrame, newRow)
          frequentSequencesFrameNew[nrow(frequentSequencesFrameNew)+1,] <<- as.character(newRow)
        }
      }
    }
  }
  
  #FINDING REPEATED SEQUENCES BETWEEN USERS
  
  betweenUsersFrequentSequencesFrame<<-NULL
  
  columnNames = c("BetweenUserFreqCounter","AggregatedFreqCounter"
                  ,names(frequentSequencesFrameNew[,5:ncol(frequentSequencesFrameNew)]))
  betweenUsersFrequentSequencesFrame <<- as.data.frame(
    setNames(replicate(length(columnNames),numeric(0), simplify = F),columnNames), stringsAsFactors = FALSE)
  
  frequentSequenceVector <- c()
  
  #See if there are commonly repeated sequences BETWEEN users
  for (rowIndex in 1:nrow(frequentSequencesFrameNew)){
    #To do that, I first need a list with all the vectors
    #REMEMBER TO REMOVE THE DF CONTENT WHICH IS NOT PART OF THE URL SEQUENCE
    frequentSequenceVector <- c(frequentSequenceVector,paste(as.character(
      unlist(frequentSequencesFrameNew[rowIndex,5:ncol(frequentSequencesFrameNew)]))
      ,collapse='-->'))
  }
  #After this I can just use the "table" method to find repetitions
  #We sort it decreasingly, so the frequent sequences go first
  frequentSequenceFrequency = sort(table(frequentSequenceVector),decreasing = TRUE)
  #For each repeating frequency, store it next to the number of occurrences.
  if (length(frequentSequenceFrequency[frequentSequenceFrequency>1])>=1){
    for (freqIndex in 1:length(frequentSequenceFrequency[frequentSequenceFrequency>1])){
      print("frequent sequence Between users found")
      
      #Same as I did before within users, but now is between users
      frequentSequence = names(frequentSequenceFrequency[freqIndex])
      sequenceRowIndex = match(frequentSequence,frequentSequenceVector)
      
      #We get the aggregated freqCounter from all the frequencies of all users
      aggregatedFreqCounter = frequentSequencesFrameNew[which(frequentSequenceVector == frequentSequence),]$freqCounter
      
      #We also want to have the frequency counter, I'll add it to the start
      #As well as the aggregated freqcounter
      newRow <<- c(as.numeric(frequentSequenceFrequency[freqIndex])
                   ,sum(as.numeric(aggregatedFreqCounter))
                   ,frequentSequencesFrameNew[sequenceRowIndex,5:ncol(frequentSequencesFrameNew)])
      
      names(newRow)[1] <<- "BetweenUserFreqCounter"
      names(newRow)[2] <<- "AggregatedFreqCounter"
      
      betweenUsersFrequentSequencesFrame[nrow(betweenUsersFrequentSequencesFrame)+1,] <<- as.character(newRow)
    }
  }
  
  #write.table(betweenUsersFrequentSequencesFrame, file = "betweenUserSequencyTable.csv", sep = ",", col.names = NA,qmethod = "double")
}

#Find sequences with the same start and ending points, and report them
urlVisitSequenceStartEndAnalysis <- function(){
  
  #We need to set the length of the urlSequence to be analysed
  #  urlSequenceLengthListTemp = urlSequenceLengthList
  urlSequenceLengthListTemp = as.numeric(as.character(urlSequenceFrame$sequenceLength))
  
  #Filter userId, episode and length
  analysisUrlSequenceFrame = urlSequenceFrame[,4:ncol(urlSequenceFrame)]
  
  #We'll filter any sequence below that threshold
  lengthOfSequence = ncol(analysisUrlSequenceFrame)#60
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[urlSequenceLengthListTemp<=lengthOfSequence,]
  urlSequenceLengthListTemp = urlSequenceLengthListTemp[urlSequenceLengthListTemp<=lengthOfSequence]
  
  #We'll filter any sequence above that threshold
  minimumLengthOfSequence = 1
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[urlSequenceLengthListTemp>=minimumLengthOfSequence,]
  urlSequenceLengthListTemp=urlSequenceLengthListTemp[urlSequenceLengthListTemp>=minimumLengthOfSequence]
  
  #Filter out the unwanted columns
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[,1:lengthOfSequence]
  
  #Just for this test, I will run the algorithm with a limited amount of lines
  numberOfRowsAnalysed = nrow(analysisUrlSequenceFrame)#100#
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[1:numberOfRowsAnalysed,]
  
  urlSequenceStartEndList <<- c()
  #For each row, look at the first and last, and increase their counter
  for (rowIndex in 1:nrow(analysisUrlSequenceFrame)){
    #I need to transform the row into a character array.
    sequenceVector = as.character(unlist(analysisUrlSequenceFrame[rowIndex,]))
    
    #The last element is the one just before the first "EMPTY", or just the full number of columns
    lastColIndex = match("EMPTY",sequenceVector)-1
    if (is.na(lastColIndex)){
      lastColIndex = length(sequenceVector)
      #       print(paste("last index overwritten, last object is:",as.character(unlist(analysisUrlSequenceFrame[rowIndex,lastColIndex]))))
      #       print(analysisUrlSequenceFrame[rowIndex,])
    }
    
    label = paste(analysisUrlSequenceFrame[rowIndex,1],"-->", analysisUrlSequenceFrame[rowIndex,lastColIndex],sep="")
    
    #If the list is null (happens the first time every time)
    if (is.null(urlSequenceStartEndList[label]))
      urlSequenceStartEndList[label] <<- 1
    #OR if that position in the array is NA
    else if(is.na(urlSequenceStartEndList[label]))
      urlSequenceStartEndList[label] <<- 1
    else
      urlSequenceStartEndList[label] <<- urlSequenceStartEndList[label] +1
  }
  
  #write.table(urlSequenceStartEndList, file = "urlSequenceStartEndListTable.csv", sep = ",", col.names = NA,qmethod = "double")
}

#Given an start and end point, retrieve those user and episode indexes from the urlSequenceFrame
urlVisitSequenceStartEndExtractor <- function(){
  startPoint ="HOME"# "study/undergraduate/visitus/visitdays/"
  endPoint = "study/undergraduate/courses/computer-science/"#"study/undergraduate/visitus/visitdays/visitdaytravel/"
  
  #Look at all the first and ending points for each sequence, and report the ones that comply to our start/end
  
  
  
  #We need to set the length of the urlSequence to be analysed
  #urlSequenceLengthListTemp = urlSequenceLengthList
  urlSequenceLengthListTemp = as.numeric(as.character(urlSequenceFrame$sequenceLength))
  frequencyList = list()
  
  #We filter out users who fall below this frequency limit
  minimumFrequency = 2
  analysisUrlSequenceFrame = urlSequenceFrame#[1:100,]
  analysisUrlSequenceFrame = data.frame(lapply(analysisUrlSequenceFrame, as.character), stringsAsFactors=FALSE)
  
  #We'll filter any sequence below that threshold
  minSequenceLength = 2
  print (paste("Filtering ", length(which(urlSequenceLengthListTemp < minSequenceLength)), " sequence shorter than ", minSequenceLength,
               ", leaving ", length(which(urlSequenceLengthListTemp >= minSequenceLength))," sequences left at ",Sys.time()))
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[urlSequenceLengthListTemp>=minSequenceLength,]
  urlSequenceLengthListTemp=urlSequenceLengthListTemp[urlSequenceLengthListTemp>=minSequenceLength]  
  
  #Filter userId and episode
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[,4:ncol(urlSequenceFrame)]
  
  #Just for this test, I will run the algorithm with a limited amount of lines
  numberOfRowsAnalysed = nrow(analysisUrlSequenceFrame)#100#
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[1:numberOfRowsAnalysed,]
  
  extractedSequenceFrame <<- data.frame("userId"=as.character(),"sdEpisodeIndex"=as.character(),"sequenceLength"=as.character()
                                        ,"startUrl"=as.character(),"endUrl"=as.character()
                                        , stringsAsFactors = FALSE)
  
  startEndTestFrame <<-analysisUrlSequenceFrame
  
  for (rowIndex in 1:nrow(analysisUrlSequenceFrame)){
    #I need to transform the row into a character array.
    sequenceVector = as.character(unlist(analysisUrlSequenceFrame[rowIndex,]))
    
    #The last element is the one just before the first "EMPTY", or just the full number of columns
    lastColIndex = match("EMPTY",sequenceVector)-1
    if (is.na(lastColIndex)){
      lastColIndex = length(sequenceVector)
    }
    #     else{
    #       print(paste("lastIndex was NA for rowIndex:", rowIndex))
    #     }
    #     #Check for the first and last elements
    #     print(analysisUrlSequenceFrame[rowIndex,1])
    #     print(analysisUrlSequenceFrame[rowIndex,lastColIndex])
    if (analysisUrlSequenceFrame[rowIndex,1]==startPoint & analysisUrlSequenceFrame[rowIndex,lastColIndex]==endPoint){
      #       print (paste(as.character(urlSequenceFrame[rowIndex,1]),"--",as.character(urlSequenceFrame[rowIndex,2])
      #                    ,":",analysisUrlSequenceFrame[rowIndex,1],"-->",analysisUrlSequenceFrame[rowIndex,lastColIndex]))
      newRow = c("userId"=as.character(urlSequenceFrame[rowIndex,1])
                 ,"sdEpisodeIndex"=as.character(urlSequenceFrame[rowIndex,2])
                 ,"sequenceLength"=as.character(urlSequenceFrame[rowIndex,3])
                 ,"startUrl"=as.character(analysisUrlSequenceFrame[rowIndex,1])
                 ,"endUrl"=as.character(analysisUrlSequenceFrame[rowIndex,lastColIndex]))
      
      extractedSequenceFrame[nrow(extractedSequenceFrame)+1,] <<- newRow
      #       extractedSequenceFrame[nrow(extractedSequenceFrame)+1] = c("userId"=as.character(urlSequenceFrame[rowIndex,1])
      #                                                                  ,"sdEpisodeIndex"=as.character(urlSequenceFrame[rowIndex,2])
      #                                                                  ,"startUrl"=analysisUrlSequenceFrame[rowIndex,1]
      #                                                                  ,"endUrl"=analysisUrlSequenceFrame[rowIndex,lastColIndex])
    }
  }
  
  #Running the following gives the users who executed it more than once.
  sort(table(extractedSequenceFrame$userId))
}



#Given the initial steps of the sequence, it fills it with EMPTY elements, and looks for that sequence in the urlSequenceFrame
#WARNING!!! Make sure that the urlSequence Frame gets all its "-" replaced by "_". Otherwise it can lead to erratic results
#ALSO: this script only works with sequences which do not have any repetitions. If the sequence has a "/2", then this script will fail.
# I started with a modification that would take that into account, but it gets overly complicated if teh sequence is longer than 9...
urlVisitSequenceExactExtractor <- function(){
  
  #If the sequence has repetition steps (/2 instead of the usual /1) just copy that step several times
  seqToFind = c("undergraduate/programmes/courseunits//1-undergraduate/programmes/courseunits/choices.php/1")
  
  #Creates an array of the elements which were separated by "-"
  seqToFind = unlist(strsplit(seqToFind, "-"))
  
  urlSequenceFrame <<- as.data.frame(sapply(urlSequenceFrame,gsub,pattern="-",replacement="_"))
  
  for(stepIndex in 1:length(seqToFind)){
    
    ##STARTED WRITING FIX FOR MULTIPLE REPETITIONS
    #     #Does this step happen more than once?
    #     #get the number from the end
    #     repCount= substr(seqToFind[stepIndex],nchar(seqToFind[stepIndex])-1,nchar(seqToFind[stepIndex]))  
    #     if (substr(seqToFind[stepIndex],nchar(seqToFind[stepIndex])-1),nchar(seqToFind[stepIndex])-1))
    #     seqToFind[stepIndex] =  substr(seqToFind[stepIndex],1,nchar(seqToFind[stepIndex])-2)
    
    #We need to remove the "/1" from the end, if we are using the output from the sequence generator
    seqToFind[stepIndex] =  substr(seqToFind[stepIndex],1,nchar(seqToFind[stepIndex])-2)
  }
  #Now we need to fill in the rest of the array with "EMPTY"s
  #WARNING! We substract 5 to the length of the array, in order to account for the non-sequence related information
  for (stepIndex in (length(seqToFind)+1):(ncol(urlSequenceFrame)-3)){
    seqToFind[stepIndex]="EMPTY"
  }
  
  #   print(paste("Looking for the following sequence"))
  #   print(seqToFind)
  
  #We need to set the length of the urlSequence to be analysed
  #urlSequenceLengthListTemp = urlSequenceLengthList
  urlSequenceLengthListTemp = as.numeric(as.character(urlSequenceFrame$sequenceLength))
  frequencyList = list()
  
  #We filter out users who fall below this frequency limit
  minimumFrequency = 2
  analysisUrlSequenceFrame = urlSequenceFrame#[1:100,]
  analysisUrlSequenceFrame = data.frame(lapply(analysisUrlSequenceFrame, as.character), stringsAsFactors=FALSE)
  
  #We'll filter any sequence below that threshold
  minSequenceLength = 2
  print (paste("Filtering ", length(which(urlSequenceLengthListTemp < minSequenceLength)), " sequence shorter than ", minSequenceLength,
               ", leaving ", length(which(urlSequenceLengthListTemp >= minSequenceLength))," sequences left at ",Sys.time()))
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[urlSequenceLengthListTemp>=minSequenceLength,]
  urlSequenceLengthListTemp = urlSequenceLengthListTemp[urlSequenceLengthListTemp>=minSequenceLength]  
  
  #Filter userId and episode
  #analysisUrlSequenceFrame = analysisUrlSequenceFrame[,4:ncol(urlSequenceFrame)]
  
  #Just for this test, I will run the algorithm with a limited amount of lines
  numberOfRowsAnalysed = nrow(analysisUrlSequenceFrame)#100#
  analysisUrlSequenceFrame = analysisUrlSequenceFrame[1:numberOfRowsAnalysed,]
  
  extractedExactSequenceFrame <<- analysisUrlSequenceFrame[0,]
  
  for (rowIndex in 1:nrow(analysisUrlSequenceFrame)){
    #I need to transform the row into a character array. BUT I don't want neither the userId or the episode.
    sequenceVector = as.character(unlist(analysisUrlSequenceFrame[rowIndex,4:ncol(urlSequenceFrame)]))
    #print(paste("Comparing object of length",length(seqToFind),"with object of length",length(sequenceVector)))
    
    if (all(seqToFind==sequenceVector)){
      #       print (paste(as.character(urlSequenceFrame[rowIndex,1]),"--",as.character(urlSequenceFrame[rowIndex,2])
      #                    ,":",analysisUrlSequenceFrame[rowIndex,1],"-->",analysisUrlSequenceFrame[rowIndex,lastColIndex]))
      
      extractedExactSequenceFrame[nrow(extractedExactSequenceFrame)+1,] <<- analysisUrlSequenceFrame[rowIndex,]
      #       extractedSequenceFrame[nrow(extractedSequenceFrame)+1] = c("userId"=as.character(urlSequenceFrame[rowIndex,1])
      #                                                                  ,"sdEpisodeIndex"=as.character(urlSequenceFrame[rowIndex,2])
      #                                                                  ,"startUrl"=analysisUrlSequenceFrame[rowIndex,1]
      #                                                                  ,"endUrl"=analysisUrlSequenceFrame[rowIndex,lastColIndex])
    }
  }
  
  #Running the following gives the users who executed it more than once.
  print(paste("For the sequence:"))
  print(seqToFind)
  print(paste("This sequence took place ", nrow(extractedExactSequenceFrame), " times"))
  print(paste(length(unique(extractedExactSequenceFrame$sid)), " unique users performed this sequence"))
  print(paste(length(which(sort(table(extractedExactSequenceFrame$sid))>1)), " unique users performed this sequence MORE than once"))
  print(paste("The most frequent user performed this sequence ", as.numeric(sort(table(extractedExactSequenceFrame$sid),decreasing = TRUE)[1]), " times"))
  
}





#Before runnig this script, remember to run the code contained in "loadLoadAllEpisodes()"
processDataintoLogAndNotLog <- function(){
  
  #   urlToFilter = "http://www.cs.manchester.ac.uk/"
  #   #   
  #   print(paste("Processing CS data into logarised and non-logarised data from url: ",urlToFilter))
  #   #   
  #   filteredGlobalEpisodePool = globalEpisodePoolAllUrls[globalEpisodePoolAllUrls$url==urlToFilter,]
  
  print(paste("Processing CS data into logarised and non-logarised data from ALL urls"))
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
  
  
  
  ########################Remove all the Inf values!!!
  logarisedData <<- do.call(data.frame,lapply(logarisedData, function(x) replace(x, is.infinite(x),NA)))
  nonLogarisedData <<- do.call(data.frame,lapply(nonLogarisedData, function(x) replace(x, is.infinite(x),NA)))
}



##Code to create comparable visualisations of each of the episodes for appropriate features

###The following code analyses the data with respect to active time bins.
#It loads the data, filters it, and calls the visualisation functions
activeTimeBinGraphsAnalysis <- function(){
  print(paste("Starting activeTimeBinGraphsAnalysis at ",Sys.time()))
  
  
  #featureToUse = "urlEpisodeDurationms"
  #featureToUse = "mouseClickSpeedClickTime"
  #featureToUse = "mouseTimeToClickTime"
  #featureToUse = "mouseClickSpeedClickTime"
  # featureToUse = "scrollControlledSpeedAbs"
  #featureToUse = "mouseMedianIdleTimeDuration"
  #featureToUse = "scrollControlledDuration"
  featureToUse = "scrollControlledSpeedAbs"
  #featureToUse = "scrollFastSingleDirectSpeedAbs"
  
  urlFilter = "http://www.cs.manchester.ac.uk/"
  filterByUrl = TRUE
  #urlFilter = "http://www.kupkb.org/tab0"
  
  userLimit = 500
  activeTimeThreshold = 1 * 60 * 1000
  minActiveTimeBinNumber = 4
  activeBinTimeLimit = 20
  
  #parameters for the mixed model plot, such as axis limits and legend
  xRangeLimit = c(0,6)
  yRangeLimit =  c(4,6)
  #possible values are: "bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right" and "center"
  #This way the legend can be moved in case it affects the readability of the particular tendency
  plotLegendPosition = "topleft"
  
  
  ##PNG options. Comment code if not wanted.
  pngPlotName = "mixedModel_scrollFastScrollCycleDuration.png"
  #c(width,height)
  pngPlotSize = c(1189,652)
  
  ###CUSTOM AXIS options
  overrideXaxis = "Fast single direction scroll speed (log10)"#"Controlled scroll duration (log10)"
  overrideYaxis = "Active time (log10)"
  overrideFontSize = 2
  
  #In case an xlimit is wanted, set it to -1 otherwise
  xlimit = -1#200
  
  ###Parameters for the mixed linear model.
  logariseFeature = TRUE
  logariseActiveTime = TRUE
  plotAgainstBins = FALSE
  plotDataPoints = FALSE
  
  ####Execution options
  #By default, it will run all the code
  runDescriptiveStats = FALSE
  runMontecarloMixedLinearModel = TRUE
  runMixedLinearModel = FALSE
  runLatticePlots = FALSE
  
  ###LOADING DATA
  
  processDataintoLogAndNotLog()
  data = nonLogarisedData
  
  ###################FILTERING PROCESS############
  #Filtering by url
  #   urlFilter = "http://www.cs.manchester.ac.uk/"
  #urlFilter = "http://www.kupkb.org/tab0"
  if (filterByUrl){
    print(paste("Filtering out events for url:",urlFilter, " at ", Sys.time()))
    data = data[data$url == urlFilter,]
  }
  else{
    print("NOT Filtering out events for url, all episodes for Web site are included")
  }
  
  
  
  
  ###########CODE TO ADD CUSTOM FEATURES  
  #########USING THE FEATURE DIVIDED BY EPISODE DURATION
  #   data$mouseDistanceDivByEpisDurSec = data$mouseMoveTotalDistance / (data$urlEpisodeDurationms/1000)
  #   featureToUse = "mouseDistanceDivByEpisDurSec"
  
  
  
  print("Loading data and arranging bins")
  print("Thresholds are:")
  print(paste("featureToUse = ",featureToUse))
  print(paste("urlFilter = ",urlFilter))
  print(paste("userLimit = ",userLimit))
  print(paste("activeTimeThreshold = ",activeTimeThreshold))
  print(paste("minActiveTimeBinNumber = ",minActiveTimeBinNumber))
  print(paste("activeBinTimeLimit = ",activeBinTimeLimit))
  
  data = activeTimeloadAndFilterDataByBins(data,
                                           featureToUse,
                                           urlFilter,
                                           userLimit,
                                           activeTimeThreshold,
                                           minActiveTimeBinNumber,
                                           activeBinTimeLimit)
  
  
  if (activeBinTimeLimit > max(data$calculatedActiveTimeBins)){
    print(paste("activeBinTimeLimit was too big!!! reset to data's max number", max(data$calculatedActiveTimeBins)))
    activeBinTimeLimit =  max(data$calculatedActiveTimeBins)
  }
  
  if (userLimit > length(unique(data$sid))){
    print(paste("userLimit was too big!!! reset to data's number of users", length(unique(data$sid))))
    userLimit = length(unique(data$sid))
  }
  
  #####episodeDuration to minutes
  #If the feature to be used is episodeDuration, then I can scale it down to minutes (to increase readability, as opposed to ms)
  if (featureToUse == "urlEpisodeDurationms"){
    data$urlEpisodeDurationMin = data$urlEpisodeDurationms/60/1000
    featureToUse = "urlEpisodeDurationMin"
  }
  
  
  if(runDescriptiveStats){
    xlimit=50
    print("Plotting Density visualisations")
    activeTimeVsFeatureDensityVisualisations(data,
                                             featureToUse,
                                             urlFilter,
                                             userLimit,
                                             activeTimeThreshold,
                                             minActiveTimeBinNumber,
                                             activeBinTimeLimit,
                                             xlimit=xlimit)
    
    print("Plotting Line visualisations")
    activeTimeVsFeatureLineVisualisations(data,
                                          featureToUse,
                                          urlFilter,
                                          userLimit,
                                          activeTimeThreshold,
                                          minActiveTimeBinNumber,
                                          activeBinTimeLimit)
  }
  ####SET DATA FOR LINEAR ANALYSIS
  if (filterByUrl)
    additionalTitleInfo = paste("\n  urlFilter =",urlFilter,
                                "userLimit =", userLimit, "activeBinTimeLimit =", activeBinTimeLimit,
                                "minActiveTimeBinNumber =",minActiveTimeBinNumber)
  else
    additionalTitleInfo = paste("\n  urlFilter = NO",
                                "userLimit =", userLimit, "activeBinTimeLimit =", activeBinTimeLimit,
                                "minActiveTimeBinNumber =",minActiveTimeBinNumber)
  
  if (plotAgainstBins)
    ordinateToUse = "calculatedActiveTimeBins"
  else
    ordinateToUse = "calculatedActiveTime"
  
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
  ###########CrossFoldValidation
  
  
  if (runMontecarloMixedLinearModel)
  {
    modelUserSample = 50
    modelRepetitions = 10
    
    print(paste("Running mixed linear Model Montecarlo with ",modelRepetitions," repetitions of ",modelUserSample," users each"))
    mixedLinearModel = activeTimeVsFeatureMixedModelCrossValidation(ggplotHistData = data,
                                                                    featureToUse = featureToUse,
                                                                    ordinateToUse = ordinateToUse,
                                                                    userLimit = userLimit,
                                                                    filterByUrl = filterByUrl,
                                                                    userSample = modelUserSample,
                                                                    repetitions = modelRepetitions)
    
  }
  
  
  
  if(runMixedLinearModel){
    
    print("Plotting Mixed Linear visualisations")
    mixedLinearModel = activeTimeVsFeatureMixedModel(ggplotHistData = data,
                                                     featureToUse = featureToUse,
                                                     ordinateToUse = ordinateToUse,
                                                     userLimit = userLimit,
                                                     filterByUrl = filterByUrl,
                                                     plotDataPoints = plotDataPoints,
                                                     additionalTitleInfo = additionalTitleInfo,
                                                     xRangeLimit = xRangeLimit,
                                                     yRangeLimit =  yRangeLimit,
                                                     plotLegendPosition = plotLegendPosition,
                                                     pngPlotName = pngPlotName,
                                                     pngPlotSize = pngPlotSize,
                                                     overrideXaxis = overrideXaxis,
                                                     overrideYaxis = overrideYaxis,
                                                     overrideFontSize = overrideFontSize)
    #stop()
  }
  if(runLatticePlots){
    
    print("Plotting Linear Lattice visualisations")
    activeTimeVsFeatureLatticeLinearPlot(data=data, 
                                         additionalTitleInfo=additionalTitleInfo, 
                                         featureToUse=featureToUse)
    print("Plotting Mixed Linear Lattice visualisations")
    activeTimeVsFeatureLatticeMixedLinearPlot(data = data,
                                              additionalTitleInfo = additionalTitleInfo,
                                              linearModel = mixedLinearModel,
                                              featureToUse = featureToUse)
  }
  print(paste("Finished activeTimeBinGraphsAnalysis at ",Sys.time()))
  
}

#This function gets the data obtains from "processDataintoLogAndNotLog", and adds the 
#active time bin values. It also filters the data according to certain parameters

activeTimeloadAndFilterDataByBins <- function(ggplotHistData = nonLogarisedData,
                                              featureToUse = "urlEpisodeDurationms",
                                              urlFilter = "http://www.cs.manchester.ac.uk/",
                                              userLimit = 500,
                                              activeTimeThreshold = 0.5 * 60 * 1000,
                                              minActiveTimeBinNumber = 20,
                                              activeBinTimeLimit = 20){
  
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
  
  
  #In order to plot calculatedAcitve time in the same way as the urlEpisodes,
  #I need to set certain thresholds for the creation of bins.
  #I'll start with 10 minutes, and see where that takes me
  #   activeTimeThreshold = 0.5 * 60 * 1000
  ggplotHistData$calculatedActiveTimeBins =  round(ggplotHistData$calculatedActiveTime / activeTimeThreshold)
  
  
  ##We can also limit the analysis to the users who appear a minimum number of times
  #userLimit = length(unique(ggplotHistData$sid))#20
  #   minActiveTimeBinNumber = 20
  print(paste("Filtering out users without a minimum of ", minActiveTimeBinNumber, " at ", Sys.time()))
  for (userIndex in unique(ggplotHistData$sid)){
    #if the given user's active time bin counter is smaller than threshold, we remove it
    if (max(ggplotHistData[ggplotHistData$sid == userIndex,]$calculatedActiveTimeBins) < minActiveTimeBinNumber)
      ggplotHistData = ggplotHistData[ggplotHistData$sid != userIndex,]
  }
  
  
  #We can limit the histogram to the first "x" bins of activeTime, so it's more visible
  #   activeBinTimeLimit = 20
  ggplotHistData = ggplotHistData[ggplotHistData$calculatedActiveTimeBins <= activeBinTimeLimit,]
  
  return (ggplotHistData)
  
}

activeTimeVsFeatureDensityVisualisations <- function(ggplotHistData,
                                                     featureToUse = "urlEpisodeDurationms",
                                                     urlFilter = "http://www.cs.manchester.ac.uk/",
                                                     userLimit = 500,
                                                     activeTimeThreshold = 0.5 * 60 * 1000,
                                                     minActiveTimeBinNumber = 20,
                                                     activeBinTimeLimit = 20,
                                                     xlimit = -1){
  print(paste("activeTimeVsFeatureDensityVisualisations with xlimit=",xlimit))
  ##############AVERAGE values per activeTimeBin
  ####For this graph I will take the average/mean value for each user, to show a unique value per activity bin.
  avgGgplotHistData = data.frame(sid = character(),
                                 count =  as.numeric(character()),
                                 featureMean = as.numeric(character()),
                                 featureMedian =as.numeric(character()),
                                 calculatedActiveTimeBins =as.numeric(character()),
                                 stringsAsFactors = FALSE)
  
  print(paste("Calculating the mean and median values of ", length(unique(ggplotHistData$sid))," users", " at ", Sys.time()))
  
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
  
  print(paste("Setting the labels for the activeTime bins for ", activeBinTimeLimit," bins", " at ", Sys.time()))
  
  #I will add the amount of users for each bin (looks dirty, but it's simple to do so it appears in the legend.)
  for (binIndex in 0:activeBinTimeLimit){
    labelToSet =  paste("bin ",binIndex, " with ",nrow(ggplotHistData[ggplotHistData$calculatedActiveTimeBins == binIndex,])," users.")
    ggplotHistData$calculatedActiveTimeBins[ggplotHistData$calculatedActiveTimeBins == binIndex] = labelToSet
    
    labelToSet =  paste("bin ",binIndex, " with ",nrow(avgGgplotHistData[avgGgplotHistData$calculatedActiveTimeBins == binIndex,])," users.")
    avgGgplotHistData$calculatedActiveTimeBins[avgGgplotHistData$calculatedActiveTimeBins == binIndex] = labelToSet
    
  }
  
  
  #We factorise them for them to be used in the plot.
  ggplotHistData$calculatedActiveTimeBins =  as.factor(ggplotHistData$calculatedActiveTimeBins)
  
  print(paste("Plotting first ",activeBinTimeLimit," bins of ",activeTimeThreshold/60/1000," minutes for feature ",
              featureToUse, " at ", Sys.time()))
  
  if (xlimit==-1){
    histPlot = ggplot(data=ggplotHistData, aes_string(featureToUse, color= "calculatedActiveTimeBins"))  +
      geom_density(alpha = 0.1) + 
      ggtitle(paste(featureToUse, " distribution per active time bin for the top "
                    ,userLimit,"users,\n with a minimum of ", minActiveTimeBinNumber," active bins in bins of ",activeTimeThreshold/60/1000," minutes"))
  }
  else{
    histPlot = ggplot(data=ggplotHistData, aes_string(featureToUse, color= "calculatedActiveTimeBins"))  +
      geom_density(alpha = 0.1) + 
      xlim(0, xlimit) + 
      ggtitle(paste(featureToUse, " distribution per active time bin for the top "
                    ,userLimit,"users,\n with a minimum of ", minActiveTimeBinNumber," active bins in bins of "
                    ,activeTimeThreshold/60/1000," minutes, and xlimit ", xlimit ))
  }
  print(histPlot)
  
  ################AVERAGE AND MEDIAN PLOTS
  #We factorise them for them to be used in the plot.
  avgGgplotHistData$calculatedActiveTimeBins =  as.factor(avgGgplotHistData$calculatedActiveTimeBins)
  
  print(paste("Plotting first ",activeBinTimeLimit," bins of ",activeTimeThreshold/60/1000," minutes for feature ",
              featureToUse, " at ", Sys.time()))
  
  if (xlimit==-1){
    histPlot = ggplot(data=avgGgplotHistData, aes(featureMean, color= calculatedActiveTimeBins))  +
      geom_density(alpha = 0.1) + #xlim(0, 120000) + 
      ggtitle(paste(featureToUse, " MEAN per user distribution per episode for the top "
                    ,userLimit,"users, in bins of ",activeTimeThreshold/60/1000," minutes"))
  }
  else{
    histPlot = ggplot(data=avgGgplotHistData, aes(featureMean, color= calculatedActiveTimeBins))  +
      geom_density(alpha = 0.1)+
      xlim(0, xlimit) + 
      ggtitle(paste(featureToUse, " MEAN per user distribution per episode for the top "
                    ,userLimit,"users, in bins of ",activeTimeThreshold/60/1000," minutes, and xlimit ", xlimit ))
  }
  
  
  print(histPlot)
  
  print(paste("Plotting first ",activeBinTimeLimit," bins of ",activeTimeThreshold/60/1000," minutes for feature ",
              featureToUse, " at ", Sys.time()))
  if (xlimit==-1){
    histPlot = ggplot(data=avgGgplotHistData, aes_string("featureMedian", color= "calculatedActiveTimeBins"))  +
      geom_density(alpha = 0.1) + #xlim(0, 120000) + 
      ggtitle(paste(featureToUse, " MEDIAN per user distribution per episode for the top "
                    ,userLimit,"users, in bins of ",activeTimeThreshold/60/1000," minutes"))
  }
  else{
    histPlot = ggplot(data=avgGgplotHistData, aes_string("featureMedian", color= "calculatedActiveTimeBins"))  +
      geom_density(alpha = 0.1) +
      xlim(0, xlimit) + 
      ggtitle(paste(featureToUse, " MEDIAN per user distribution per episode for the top "
                    ,userLimit,"users, in bins of ",activeTimeThreshold/60/1000," minutes, and xlimit ", xlimit ))
  }
  
  print(histPlot)
  ##########
  
}

activeTimeVsFeatureLineVisualisations <- function(ggplotHistData,
                                                  featureToUse = "urlEpisodeDurationms",
                                                  urlFilter = "http://www.cs.manchester.ac.uk/",
                                                  userLimit = 500,
                                                  activeTimeThreshold = 0.5 * 60 * 1000,
                                                  minActiveTimeBinNumber = 20,
                                                  activeBinTimeLimit = 20){
  
  print("Calculating averages and medians")
  averageFeatureValue=c()
  medianFeatureValue = c()
  
  averageTimeSinceValue=c()
  medianTimeSinceValue = c()
  
  userNumber = c()
  
  maxActiveTimeBinIndex = activeBinTimeLimit
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
  
  multiplot(featureValuePlot, timeSinceValuePlot,userCountPlot, cols=1)
  
}

######MIXED LINEAR MODEL
#I'll plot a mixed linear model with the data I have from the users, so I get the whole picture.
activeTimeVsFeatureMixedModel <- function(ggplotHistData,
                                          featureToUse = "urlEpisodeDurationms",
                                          ordinateToUse = "calculatedActiveTime",
                                          userLimit = 500,
                                          filterByUrl = FALSE,
                                          plotDataPoints = TRUE,
                                          additionalTitleInfo,
                                          xRangeLimit = NULL,
                                          yRangeLimit =  NULL,
                                          plotLegendPosition = NULL,
                                          pngPlotName = NULL,
                                          pngPlotSize = NULL,
                                          overrideXaxis = NULL,
                                          overrideYaxis = NULL,
                                          overrideFontSize = NULL){
  
  
  if (filterByUrl){
    lme4RanEffect <- 
      lmer(get(ordinateToUse) ~ get(featureToUse)
           + (1 + get(featureToUse)|sid), data = ggplotHistData)
    summary(lme4RanEffect)
  }
  else{
    print("Data was not filtered by url, adding url as fixed effect")
    ggplotHistData = data
    ggplotHistData$url = as.character(ggplotHistData$url)
    ggplotHistData$url = as.factor(ggplotHistData$url)
    
    ggplotHistData$sid = as.character(ggplotHistData$sid)
    ggplotHistData$sid = as.factor(ggplotHistData$sid)
    
    
    ####I still need to decide which one to use....
    lme4RanEffect <- 
      lmer(get(ordinateToUse) ~ get(featureToUse) + (1 + get(featureToUse)|url)
           + (1 + get(featureToUse)|sid), data = ggplotHistData)
    
    lme4RanEffect <- 
      lmer(get(ordinateToUse) ~ get(featureToUse) + (1 + get(featureToUse)|url/sid)
           , data = ggplotHistData)
    
    summary(lme4RanEffect)
  }
  
  
  #   ##########Do we want to add "timesince"? If so use the following code
  #   ggplotHistData = data
  #   lme4RanEffect <- 
  #     lmer(get(ordinateToUse) ~ get(featureToUse) + urlSinceLastSession
  #          + (1 + get(featureToUse)|sid), data = ggplotHistData)
  #   summary(lme4RanEffect)
  #   
  #   boxplot(residuals(lme4RanEffect))
  
  plotMixedModel(linearModel=lme4RanEffect,
                 dataframe=ggplotHistData,
                 featureToUse=featureToUse,
                 ordinateToUse=ordinateToUse,
                 plotCoefficients = FALSE,
                 additionalTitleInfo = additionalTitleInfo,
                 plotDataPoints = plotDataPoints,
                 xRangeLimit = xRangeLimit,
                 yRangeLimit =  yRangeLimit,
                 plotLegendPosition = plotLegendPosition,
                 pngPlotName = pngPlotName,
                 pngPlotSize = pngPlotSize,
                 overrideXaxis = overrideXaxis,
                 overrideYaxis = overrideYaxis,
                 overrideFontSize = overrideFontSize
  )
  
  
  
  
  ####CODE TO TEST FOR URL AND SID AS NESTED FIXED EFFECTS
  #   lme4RanEffect2 <<- 
  #     lmer(get(ordinateToUse) ~ get(featureToUse) + (1 + get(featureToUse)|url/sid)
  #          , data = ggplotHistData)
  #   
  #   summary(lme4RanEffect)
  #   
  #   plotMixedModel(linearModel=lme4RanEffect,
  #                  dataframe=ggplotHistData,
  #                  abscissa=featureToUse,
  #                  ordinate=ordinateToUse,
  #                  plotCoefficients = FALSE,
  #                  additionalTitleInfo = additionalTitleInfo,
  #                  groupingFactor = "url:sid"
  #             )
  
  diagnoseResiduals(lme4RanEffect,lookForInfluentialPoins = FALSE)
  
  summary(lme4RanEffect)
  
  return (lme4RanEffect)
}


######MIXED LINEAR MODEL Cross folded
##uses crossfold validation to ensure the results are robust.
activeTimeVsFeatureMixedModelCrossValidation <- function(ggplotHistData,
                                                         featureToUse = "urlEpisodeDurationms",
                                                         ordinateToUse = "calculatedActiveTime",
                                                         userLimit = 500,
                                                         filterByUrl = FALSE,
                                                         userSample = 50,
                                                         repetitions = 10){
  
  monteCarloMixedModels <<- list()
  
  if (filterByUrl){
    #here we use montecarlo to rerun the same algorithm over different samples of data
    for (loopIndex in 1:repetitions){
      userSample = sample(unique(ggplotHistData$sid), userSample,replace = FALSE)
      
      modelData = ggplotHistData[ggplotHistData$sid %in% userSample,]
      
      #I add the additional effect size
      mixedModel = lmer(get(ordinateToUse) ~ get(featureToUse)
                        + (1 + get(featureToUse)|sid), data = modelData)
      mixedModel$effectSize = modelCorrelation(mixedModel)
      
      ##Testing parameters
      userSampleTest <<- userSample
      modelDataTest <<- modelData
      ggplotHistDataTest <<- ggplotHistData
      ordinateToUseTest <<- ordinateToUse
      featureToUseTest <<- featureToUse
      lmerTest <<- mixedModel
      
      monteCarloMixedModels[[loopIndex]] <<- mixedModel
    }
  }
  
  #report MonteCarlo results
  
}

# http://stats.stackexchange.com/questions/95054/how-to-get-the-overall-effect-for-linear-mixed-model-in-lme4-in-r
# I’ll use the following code to calculate the effect size, which looks at the correlation between the fitted and the observed values.
modelCorrelation <- function(m) {
  lmfit <- lm(model.response(model.frame(m)) ~ fitted(m))
  summary(lmfit)$r.squared }

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
                                                     nColumns = 7){
  #   activeTimeVsFeatureLatticePlot(data, mixedLinearModel, featureToUse)
  #   linearModel = mixedLinearModel
  #   maxUsers = 49
  #   featureToUse = "mouseMedianIdleTimeDuration"
  #   ordinateToUse = "calculatedActiveTime"
  #I want to add another graph that shows the tendencies of all users, before showing the overall tendency.
  
  #I got this idea from Douglas M. Bates section 3.1
  #   plotLatticeGraph():
  #ordinateToUse = "calculatedActiveTime"
  
  #I could try to have 20% more rows than columns.
  #24: 6 4
  #31: 
  #For the time being, I'll let the program decide.
  # numCol = length(unique(data$sid))/
  # numRow =
  #   data=singer
  #   
  #   
  #   #latticeLinearRegresPlot <- dotplot(get(ordinateToUse) ~ get(featureToUse) | sid, data,
  #   (latticeLinearRegresPlot <- dotplot(~ height | voice.part, data,
  #                                       #layout=c(4,6),
  #                                       scale=list(y=list(cex=.4)),
  #                                       panel = function(x, y) {
  #                                         panel.xyplot(x, y)
  #                                         panel.abline(lm(y ~ x))
  #                                       }, 
  #                                       type = c("p","r"))
  #    
  #from http://stackoverflow.com/questions/9695704/fine-tuning-a-dotplot-in-rs-lattice-package
  #    dfrm <- data.frame(algo=gl(11, 1, 11*24, labels=paste("algo", 1:11, sep="")), 
  #                       type=gl(24, 11, 11*24, labels=paste("type", 1:24, sep="")),
  #                       roc=runif(11*24))
  #    (p <- dotplot(algo ~ roc | type, dfrm, layout=c(4,6), scale=list(y=list(cex=.4))))
  #    (p <- dotplot(algo ~ roc | type, dfrm, layout=c(4,6), scale=list(y=list(cex=.4)),type = c("p","r")))
  #    
  #    
  
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
                 
                 print(paste("PANEL INDEX IS:",panelIndex))
                 print(x)
                 print(y)
                 print(paste("within user"," with ",lm(y ~ x)[[1]][1],",",lm(y ~ x)[[1]][2]))
                 print(paste("MixedModel"," with ",coefList[panelIndex,1],",",coefList[panelIndex,2]))
                 print(paste("MAIN"," with ",mainIntercept,",",mainSlope))
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
  plot(p)
  
  
  
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
                                                nColumns = 7){
  require(lattice)
  
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
  
  testData <<- data
  
  testMaxusers <<- maxUsers
  #If we have too many users, we narrow them down. We will only show a sample of them
  if (length(unique(data$sid))>maxUsers){
    sidList = unique(data$sid)[1:maxUsers]
    data = data[data$sid %in% sidList,]
  }
  
  
  plotTitle = paste(ordinateToUse,"~",featureToUse,additionalTitleInfo)
  
  colors.withinSubjectIncreasing = "green"
  colors.withinSubjectDecreasing = "darkgreen"
  
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
  plot(p)
}
