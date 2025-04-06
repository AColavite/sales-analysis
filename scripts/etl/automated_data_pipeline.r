library(DBI)
library(RMySQL)
library(dplyr)
library(mailR)

connect_db <- function() {
  dbConnect(RMySQL::MySQL(),
            dbname = "sales_db",
            host = "localhost",
            user = "username",
            password = "password")
}

get_sales_data <- function(con) {
  query <- "SELECT * FROM sales_data"
  dbGetQuery(con, query)
}

transform_sales_data <- function(sales_data) {
  sales_data %>%
    filter(!is.na(total_value)) %>%
    filter(total_value > 0) %>%
    mutate(date = as.Date(date, format = "%Y-%m-%d"))
}

save_to_csv <- function(sales_data) {
  write.csv(sales_data, "data/raw/sales.csv", row.names = FALSE)
}

send_alert <- function(message) {
  send.mail(from = "sender@example.com", 
            to = "recipient@example.com", 
            subject = "Data Pipeline Alert", 
            body = message,
            smtp = list(host.name = "smtp.example.com", port = 25),
            authenticate = TRUE, 
            send = TRUE)
}

run_pipeline <- function() {
  con <- tryCatch({
    connect_db()
  }, error = function(e) {
    send_alert("Error: Failed to connect to the database.")
    stop("Connection failed.")
  })
  
  sales_data <- tryCatch({
    get_sales_data(con)
  }, error = function(e) {
    send_alert("Error: Failed to extract sales data.")
    stop("Data extraction failed.")
  })
  
  transformed_data <- tryCatch({
    transform_sales_data(sales_data)
  }, error = function(e) {
    send_alert("Error: Failed to transform sales data.")
    stop("Data transformation failed.")
  })
  
  tryCatch({
    save_to_csv(transformed_data)
  }, error = function(e) {
    send_alert("Error: Failed to save sales data to CSV.")
    stop("Saving data to CSV failed.")
  })
  
  dbDisconnect(con)
}

run_pipeline()
