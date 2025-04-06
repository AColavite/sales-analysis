library(DBI)
library(RMySQL)
library(dplyr)

connect_db <- function() {
  dbConnect(RMySQL::MySQL(), 
            dbname = "sales_db", 
            host = "localhost", 
            user = "username", 
            password = "password")
}

read_data_from_db <- function(con, table_name) {
  query <- paste0("SELECT * FROM ", table_name)
  dbGetQuery(con, query)
}

write_data_to_db <- function(con, data, table_name) {
  dbWriteTable(con, table_name, data, append = TRUE, row.names = FALSE)
}

con <- connect_db()
sales_data <- read_data_from_db(con, "sales_data")
cleaned_sales_data <- clean_data(sales_data)
write_data_to_db(con, cleaned_sales_data, "cleaned_sales_data")
dbDisconnect(con)
