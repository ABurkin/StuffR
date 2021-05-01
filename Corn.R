#### Load Relevant Packages ####
library(tidyquant)
library(tidyverse)
library(PortfolioAnalytics)
library(PerformanceAnalytics)
library(forecast)
library(lubridate)
library(xts)
library(zoo)

from <- "2005-01-01"

from.year <- format(as.Date(from, format="%Y"))

#### Get Data Via tidyquant ####
corn.monthly <- "PMAIZMTUSDM" %>%
  tq_get(get = "economic.data",
         from = from,
         complete_cases = TRUE)

ethanol.monthly <- "WPU06140341" %>%
  tq_get(get = "economic.data",
         from = from,
         complete_cases = TRUE)

corn.eth.monthly <- corn.monthly[,c(2,3)] %>%
  left_join(ethanol.monthly[,c(2,3)], by = "date") %>%
  rename(Date = date) %>%
  rename(Corn_Price = price.x) %>%
  rename(Ethanol_Price = price.y)

#### Monthly Time Series - Corn Prices ####
corn.plot <- corn.monthly %>%
  ggplot(aes(x = date, y = price)) +
  geom_line(size = 1.25,
            color = "#0077b5") +
  xlab("Date, Year") +
  ylab("Price, Dollar/Metric Ton, ($USD/mt)") +
  ggtitle("Corn Prices",
          subtitle =  paste("Dollar Per Metric Ton, ($USD/mt);", from.year,"- Present", sep = " ")) +
  facet_grid()
#### Monthly Time Series - Ethanol Prices ####
ethanol.plot <- ethanol.monthly %>%
  ggplot(aes(x = date, y = price)) +
  geom_line(size = 1.25,
            color = "#616C7B") +
  xlab("Date, Year") +
  ylab("Price, Dollar/Metric Ton, ($USD/mt)") +
  ggtitle("Ethanol Prices",
          subtitle =  paste("Dollar Per Metric Ton, ($USD/mt);", from.year,"- Present", sep = " ")) +
  facet_grid()

#### Model of ethanol ~ corn prices ####
corn.model <- lm(Ethanol_Price ~ Corn_Price, data = corn.eth.monthly)

ce.plot <- corn.eth.monthly %>%
  ggplot(aes(Corn_Price, Ethanol_Price)) + 
  geom_point(size = 1.5, shape = 16, color = "#0077b5") +
  geom_smooth(method = "lm", color = "#6F7276", size = 1.0) +
  ggtitle("Ethanol Price ($USD/mt) vs Corn Price ($USD/mt)",
          subtitle = "Source: United States Federal Reserve Data; https://fred.stlouisfed.org/") +
  xlab("Corn Price, $USD/mt") +
  ylab("Ethanol Price, $USD/mt") +
  annotate("text", x = 275, y = 225, label = corn.model$call) +
  annotate("text", x = 275, y = 235.5, label = "italic(R) ^ 2==0.467",
           parse = TRUE)

#### Corn Price Time-Series Forecast ####
corn.ts <- ts(corn.monthly$price, start = c(2005,6), frequency = 12)
corn.ts

fc <- forecast(corn.ts, h=24, level = c(90,95))

corn.fc <- autoplot(fc,
         PI = TRUE,
         fcol = "#92979C",
         flwd = 1.5)
plot(corn.fc)

#### Print Plots ####
print(corn.fc)
print(corn.plot)
print(ethanol.plot)
print(ce.plot)
summary(corn.model)

