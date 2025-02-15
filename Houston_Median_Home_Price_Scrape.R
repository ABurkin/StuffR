library(rvest)
library(tidyverse)

html <- read_html("https://www.houstoniamag.com/home-and-real-estate/2021/03/2020-houston-real-estate-neighborhoods-prices")

price_table <- html %>% 
  html_element(".tableizer-table") %>% 
  html_table()

names(price_table) <- c("Neighborhood","ZIP_Code","Median_Price","5_Year_%_Growth_Rate","1_Year_%_Growth Rate","Avg_Days_On_Market",
                        "Avg_Sq_Ft","Persons_Per_Household","Income_Per_Household","Owner_Renter_Ratio")

price_table

write_csv(price_table, file = "[My Local Directory]/median_home_values.csv")

