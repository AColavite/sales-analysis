library(memoise)

memo_get_data <- memoise(function(con) {
    dbGetQUery(con, "SELECT * FROM sales_data")
})