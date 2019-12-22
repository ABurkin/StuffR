# Get packages
suppressMessages(library(quantmod))
suppressMessages(library(PerformanceAnalytics))
suppressMessages(library(PortfolioAnalytics))

# Set dates
fromdate = '2018-01-01'
enddate = Sys.Date()

# Vector stock symbols
stocks <- c('^GSPC','^DJI','^IXIC','GE','AMD','BAC','T','AAPL','MSFT')

# Call quantmod data
etf_env <- new.env()

getSymbols(Symbols = stocks,
           from = fromdate, 
           to = enddate, 
           env = etf_env)

# Merge closing
close_data <- do.call(merge, eapply(etf_env, Ad))
close_data <- round(close_data, 0)
rets_data <- do.call(merge, lapply(close_data, Return.calculate))
rets_data <- rets_data[-1,]

# Abridge field names
rnames <- gsub('.Adjusted', '', colnames(close_data), ignore.case = FALSE)
colnames(close_data) <- rnames