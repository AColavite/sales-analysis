library(shiny)
library(ggplot2)

date_time_series <- read.csv("data/processed/sales_data_time_series.csv")

ui <- fluidPage(
    titlePanel("Sales Dashboard")
sidebarLayout(
    sidebarPanel(
      sliderInput("date_range", "Select Date Range", 
                  min = as.Date(min(data_time_series$date)), 
                  max = as.Date(max(data_time_series$date)),
                  value = c(as.Date(min(data_time_series$date)), as.Date(max(data_time_series$date))), timeFormat = "%Y-%m-%d")
    ),

    mainPanel(
      plotOutput("sales_plot")
    )
  )
)

server <- function(input, output) {
  filtered_data <- reactive({
    data_time_series[data_time_series$date >= input$date_range[1] & data_time_series$date <= input$date_range[2], ]
  })
  
  output$sales_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = as.Date(date), y = total_value)) +
      geom_line() +
      labs(title = "Total Sales Over Time", x = "Date", y = "Total Sales")
  })
}

shinyApp(ui = ui, server = server)