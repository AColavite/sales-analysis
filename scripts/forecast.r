library(prophet)
library(dplyr)
library(lubridate)

sales <- read.csv("data/sales.csv")
sales$date <- as.Date(sales$date)

daily_sales <- sales %>%
    group_by(date) %>%
    summarise(y = sum(total_value)) %>%
    rename(ds = date)

model <- prophet(daily_sales)
future <- make_future_dataframe(model, periods = 90)
forecast <- predict(model, future)

plot(model, forecast) +
    ggtitle("Sales Forecast for the next 3 Months")