set.seed(123)
library(dplyr)
library(lubridate)

products <- c("Laptop", "Smartphone", "Monitor", "Keyboard", "Mouse")
regions <- c("South", "Southeast", "Northeast", "Midwest", "North")

sales <- data.frame(
  date = sample(seq(as.Date('2023-01-01'), as.Date('2024-12-31'), by="day"), 5000, replace=TRUE),
  product = sample(products, 5000, replace=TRUE),
  region = sample(regions, 5000, replace=TRUE),
  quantity = sample(1:10, 5000, replace=TRUE),
  unit_price = sample(200:5000, 5000, replace=TRUE)
)

sales <- sales %>%
  mutate(total_value = quantity * unit_price)

write.csv(sales, "data/sales.csv", row.names = FALSE)
