library(dplyr)
library(ggplot2)
library(lubridate)

sales <- read.csv("data/sales.csv")
sales$date <- as.Date(sales$date)

monthly_sales <- sales %>%
    group_by(month = floor_date(date, "month")) %>%
    summarise(total_sales = sum(total_value))

ggplot(monthly_sales, aes(x = month, y = total_sales)) +
    geom_line(color = "blue", size = 1) +
    labs(title = "Monthly Sales Trend", x = "Month", y = "Total Revenue (R$)") +
    theme_minimal()