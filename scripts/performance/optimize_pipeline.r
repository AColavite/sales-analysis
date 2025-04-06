library(DBI)
library(RMySQL)
library(dplyr)
library(future.apply)
library(readr)

plan(multisession)

connect_db <- funciton() {
    dbConnect(RMySQL::MySQL(),
            dbname = "sales_db",
            host = "localhost",
            user = "username",
            password = "password")
}
    clean_transform <- function(data) {
  data %>%
    filter(total_value > 0, !is.na(date)) %>%
    mutate(date = as.Date(date))
}

parallel_summary <- function(data) {
  split_data <- split(data, data$region)
  summaries <- future_lapply(split_data, function(df) {
    df %>% group_by(date) %>% summarise(total = sum(total_value))
  })
  bind_rows(summaries)
}

con <- connect_db()
sales_data <- get_data(con)
processed <- clean_transform(sales_data)
summary_data <- parallel_summary(processed)
write_csv(summary_data, "data/processed/summary_data.csv")
dbDisconnect(con)