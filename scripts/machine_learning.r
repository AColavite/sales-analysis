library(caret)

data <- read.csv("data/processed/sales_data_cleaned.csv")

model <- lm(total_value ~ quantity + unit_price + year, month, data = data)
summary(model)

new_data <- data.frame(
    quantity = c(10, 15, 20)
    unit_price = c(50, 60, 70)
    yaer = c(2023, 2024, 2025)
    month = c(4, 5, 6)
)

predicted_sales <- predict(model, new_data)
print(predicted_sales)