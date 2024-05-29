library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)


#load it here
url <- "https://data.giss.nasa.gov/gistemp/tabledata_v4/GLB.Ts+dSST.csv"
data <- read.csv(url, skip = 1, stringsAsFactors = FALSE) %>%
  rename(Year = Year, Annual_Anomaly = `J.D`) %>%
  select(Year, Annual_Anomaly) %>%
  mutate(Year = as.numeric(Year),
         Annual_Anomaly = as.numeric(Annual_Anomaly))

# Define server logic required to generate and render outputs
server <- function(input, output) {
  # Chart 1: Bar chart
  output$tempPlot <- renderPlotly({
    filtered_data <- data %>%
      filter(Year >= input$yearRange[1] & Year <= input$yearRange[2])
    
    break_interval <- if ((input$yearRange[2] - input$yearRange[1]) > 50) {
      10
    } else if ((input$yearRange[2] - input$yearRange[1]) > 20) {
      5
    } else {
      1
    }
    
    p <- ggplot(filtered_data, aes(x = Year, y = Annual_Anomaly)) +
      geom_bar(stat = "identity", fill = "purple") +
      labs(title = "Global Temperature Anomalies Over Time",
           x = "Year",
           y = "Temperature Anomaly (°C)") +
      scale_x_continuous(breaks = seq(input$yearRange[1], input$yearRange[2], by = break_interval)) +
      theme_minimal()
    
    ggplotly(p)
  })
  
  # Chart 2: Pie chart
  output$pieChart <- renderPlotly({
    filtered_data <- data %>%
      filter(Year >= input$yearRange[1] & Year <= input$yearRange[2]) %>%
      filter(!is.na(Annual_Anomaly)) %>%
      mutate(Year = factor(Year)) # Convert Year to factor for better labeling
    
    pie_chart <- ggplot(filtered_data, aes(x = "", y = Annual_Anomaly, fill = Year)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      labs(title = "Global Temperature Anomalies Over Time",
           x = "",
           y = "") +
      theme_minimal() +
      theme(axis.text.x = element_blank(), # Remove x axis text
            axis.ticks = element_blank(), # Remove axis ticks
            panel.grid = element_blank()) # Remove grid lines
    
    ggplotly(pie_chart)
  })
  
}

