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
#chart2
  data_decadal <- data %>%
    mutate(Decade = floor(Year / 10) *10) %>%
    group_by(Decade) %>%
    summarise(Total_Anomaly = sum(Annual_Anomaly, na.rm = TRUE)) %>%
    arrange(Decade)%>%
    mutate(Decade = as.factor(Decade))
  
  # Generate the dot plot based on the slider input
  
  output$dotPlot <- renderPlotly({
    # Depending on the selected aggregation method, use the corresponding function
    agg_func <- if (input$aggregationMethod == "sum") sum else mean
    
    # Prepare the data based on user selections
    filtered_data <- data %>%
      mutate(Decade = floor(Year / 10) * 10) %>%
      group_by(Decade) %>%
      summarise(Total_Anomaly = agg_func(Annual_Anomaly, na.rm = TRUE)) %>%
      filter(Decade >= input$decadeRange[1] & Decade <= input$decadeRange[2]) %>%
      arrange(Decade)
    
    # Generate the dot plot using Plotly
    plot_ly(data = filtered_data, x = ~Decade, y = ~Total_Anomaly,
            type = 'scatter', mode = 'markers+lines',
            marker = list(size = 10, color = 'blue')) %>%
      layout(title = "Temperature Anomalies by Decade",
             xaxis = list(title = "Decade"),
             yaxis = list(title = "Total Anomaly"),
             hovermode = 'closest')
  })

}


