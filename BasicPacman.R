install.packages("pacman")
library(packman)

suppressMessages(
  
  pacman::p_load(
  
  tidyverse, tidyverts, lubridate, stringr, pacman, httr, readr, RCurl, combinat, tibbletime, #Utilities
  
  caret, forecast, gmm, e1071, MASS, lmtest, #Predictives
  
  PortfolioAnalytics, PerformanceAnalytics, xts, zoo, quantmod, Quandl, tidyquant, ROI.plugin.glpk, ROI.plugin.quadprog, ROI, alphavantager, TTR, #Finance
  
  RSQLite, DBI, sparklyr, rpart, rsparkling, h2o, hive, #DataEngineering
  
  grDevices, shiny, shinyapp, corrplot, gganimate, lattice, RColorBrewer, plotly, map_data, graphics, notifier #DataViz
  
  )
)