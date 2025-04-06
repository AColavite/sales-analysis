library(dplyr)

validate_data <- function(data) {
  missing_values <- colSums(is.na(data))
  
  invalid_sales <- data %>%
    filter(total_value < 0)
  
  invalid_dates <- data %>%
    filter(is.na(as.Date(date, format="%Y-%m-%d")))
  
  # Return validation results
  return(list(
    missing_values = missing_values,
    invalid_sales = invalid_sales,
    invalid_dates = invalid_dates
  ))
}

clean_data <- function(data) {
  data %>%
    filter(total_value >= 0) %>%
    mutate(date = as.Date(date, format="%Y-%m-%d")) %>%
    na.omit()
}

data <- read.csv("data/raw/sales_data.csv")
validation_results <- validate_data(data)
cleaned_data <- clean_data(data)

print(validation_results)
