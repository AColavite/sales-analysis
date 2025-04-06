library(httr)
library(jsonlite)
library(readr)

google_analytics_data <- fromJSON("data/external/google_analytics_data.json")
print(google_analytics_data)

customer_feedback_data <- read_csv("data/external/customer_feedback_api.csv")
print(customer_feedback_data)

write_json(google_analytics_data, "data/external/google_analytics_data.json")
write_csv(customer_feedback_data, "data/external/customer_feedback_api.csv")

cat("External data successfully ingested and saved to the external folder.\n")