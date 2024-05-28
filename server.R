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
#chart1
server <- function(input, output) {
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
  
  
}


