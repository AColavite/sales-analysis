library(DBI)
library(RMySQL)

connect_db <- function() {
  dbConnect(RMySQL::MySQL(),
            dbname = "sales_db",
            host = "localhost",
            user = "username",
            password = "password")
}
