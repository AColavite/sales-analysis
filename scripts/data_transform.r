library(dplyr)
library(lubridate)

data <- read.csv("data/raw/sales_raw_data.csv")

data <- data %>%
  mutate(total_spent = ifelse(is.na(total_spent), mean(total_spent, na.rm = TRUE), total_spent))

data <- data %>%
  mutate(total_value = quantity * unit_price, year = year(date), month = month(date))

aggregated_data <- data %>%
  group_by(product) %>%
  summarise(total_sales = sum(total_value), avg_price = mean(unit_price), total_quantity = sum(quantity))

customer_data <- read.csv("data/external/customer_data.csv")
merged_data <- left_join(data, customer_data, by = "customer_id")

data_time_series <- data %>%
  arrange(date) %>%
  mutate(lagged_sales = lag(total_value, n = 1, order_by = date))

Q1 <- quantile(data$total_value, 0.25)
Q3 <- quantile(data$total_value, 0.75)
IQR <- Q3 - Q1

data_no_outliers <- data %>%
  filter(total_value > (Q1 - 1.5 * IQR) & total_value < (Q3 + 1.5 * IQR))

data_scaled <- data %>%
  mutate(
    scaled_quantity = (quantity - min(quantity)) / (max(quantity) - min(quantity)),
    scaled_total_value = (total_value - min(total_value)) / (max(total_value) - min(total_value))
  )

write.csv(data_no_outliers, "data/processed/sales_data_cleaned.csv", row.names = FALSE)
write.csv(aggregated_data, "data/processed/sales_data_aggregated.csv", row.names = FALSE)
write.csv(merged_data, "data/processed/sales_customer_data.csv", row.names = FALSE)
write.csv(data_time_series, "data/processed/sales_data_time_series.csv", row.names = FALSE)
write.csv(data_scaled, "data/processed/sales_data_scaled.csv", row.names = FALSE)

cat("✅ Data transformations applied and saved to the processed folder.\n")
