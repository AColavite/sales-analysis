library(rmarkdown)
library(DBI)
library(RMySQL)
library(dplyr)

generate_report <- function() {
    render("scripts/reports/sales_report.Rmd", output_file = "reports/sales_report.html")
}

connect.db <- function() {
    dbConnect(RMySQL()),
            dbname = "sales_db",
            host = "localhost"
            user = " username"
            password = "password"
}

get_sales_data <- function(sales_data) {
    query <- "SELECT * FROM sales_data"
    dbGetQuery(con, query)
}

transform_sales_data <- function(sales_data) {
    sales_data %>%
        filter(!is.na(total_value)) %>%
        filter(total_value > 0) %>%
        mutate(date = as.Date(date, format = "%Y-%m-%d"))
}

generate_sales_sumamry <- function(transformed_data) {
    summary <- transformed_data %>%
        group_by(date) %>%
        summarise(total_sales = sum(total_value))
    return(summary)    
}

generate_report_data <- function() {
    con <- connect_db()
    sales_data <- get_sales_data(con)
    transformed_data <- transform_sales_data(sales_data)
    sales_summary <- generate_sales_sumamry(transformed_data)
    dbDisconnect(con)

    return(sales_summary)
}

generate_report_data()