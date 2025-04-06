library(dplyr)
library(DBI)
library(RMySQL)
library(mailR)

connect_db <- function() {
    dbConnect(RMySQL::MySQL(),
            dbname = "sales.db",
            host = "localhost"
            user = "username"
            password = "password")
}

check_anomalies <- function(data) {
    sales_anomalies <- data %>%
    filter(total_value > 10000) %>%
    filter(total_value < 0)

return(sales_anomalies)
}

send_alert <- function(anomalies) {
    if (nrow(anomalies) > 0) {
        send.mail(from = "sender@example.com",
            to = "recipient@example.com",
            subject = "Sales Anomaly Detected"
            body = paste("Anomalies detected:\n", toString(anomalies$total_value)),
            smtp = list(host.name = "smtp.example.com", port = 25),
            authenticate = TRUE,
            send = TRUE)
    }
}

con <- connect_db()
sales_data <- read_data_from_db(con, "sales_data")
anomalies <- check_anomalies(sales_data)
send_alert(anomalies)
dbDisconnect(con)