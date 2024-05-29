library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Climate Chronicles: Decoding the Impact of Industrialization on Global Weather Patterns"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction", tabName = "introduction", icon = icon("dashboard")),
      menuItem("Chart 1", tabName = "chart1", icon = icon("chart-line")),
      menuItem("Chart 2", tabName = "chart2", icon = icon("chart-line")),
      menuItem("Chart 3", tabName = "chart3", icon = icon("chart-line")),
      menuItem("Conclusion", tabName = "conclusion", icon = icon("file"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "introduction",
              fluidPage(
                titlePanel("Introduction"),
                # Additional content
                fluidRow(
                  column(12,
                         tags$h3("Project Overview"),
                         tags$p("The dataset can be found at: ", tags$a(href = "https://data.world/data-society/global-climate-change-data", "https://data.giss.nasa.gov/gistemp/tabledata_v4/GLB.Ts+dSST.csv")),
                         tags$p("Climate change is a global crisis that influences virtually every aspect of the Earth's weather systems, from average temperature fluctuations to extreme weather occurrences and long-term patterns in precipitation. Our project delves deeply into these phenomena, focusing specifically on how changes in global temperatures and precipitation patterns have corresponded with the rise in industrial activities over the past century."),
                         tags$p("Although the dataset is extensive, there may be gaps in geographic or temporal coverage. Some areas, especially remote or underdeveloped regions, may have fewer data collection points, which can lead to less reliable temperature and precipitation records. The lack of comprehensive coverage can distort our understanding of global patterns and trends. Additionally, changes in measurement technologies and techniques over time could affect the accuracy of historical data. Older records might not have been collected with the same precision or under the same standards as more recent data. Furthermore, the use of different methodologies by various data sources can make it challenging to create a consistent dataset that accurately reflects global conditions. Researchers often use interpolation methods to estimate values for missing data. However, these techniques largely depend on assumptions about the data and its distribution. Misestimations can lead to incorrect conclusions, especially in under-represented areas. Depending on the frequency of data recordings, the dataset may not effectively capture short-term fluctuations or extreme events. This limitation can affect analyses related to abrupt climate changes or anomalies, which are crucial for understanding climate variability and extremes. The relevance of the dataset depends on its currency. If data collection stopped several years ago, it might not reflect recent trends or sudden climatic shifts, which are crucial for current and future climate modeling and analysis."),
                         tags$p("When we work with Global Climate Change Data from Data World, we face several challenges that could impact the effectiveness of our project. First, there's the issue of data quality and consistency. Data collected from different sources often varies in quality and can be inconsistent, which might skew our analysis. The granularity of the data also poses a problem; while we can get global-scale data, local details necessary for targeted analyses are often lacking. Further, the data’s temporal coverage can be limiting, as climate change requires long-term data to discern meaningful trends. Another significant challenge is dealing with data gaps and missing information, which are not uncommon in large datasets. These gaps can complicate trend analysis and make it difficult to create accurate models or forecasts, further complicating our efforts to address climate change effectively. There is one limitation, since we're new to the R language, our limited experience could hinder our ability to efficiently manipulate and analyze the data. This might be a limitation as mastering R is essential for effectively handling the complex data involved in our climate change project."),
                         tags$h3("Importance of Research"),
                         tags$p("The importance of these questions is underscored by the increasing frequency and severity of extreme weather events, which have profound implications for ecosystems, human health, agriculture, and economies worldwide. Recent reports of extraordinary weather events, such as unprecedented heavy rainfall, massive hail storms, inland tornadoes, and the sky that turns dark prematurely, highlight the urgent need to understand and mitigate climate change."),
                         tags$h3("Goals of the Analysis"),
                         tags$p("This analysis aims to aid in preparation and adaptation strategies by providing a robust analysis of how climate change affects extreme weather patterns and their subsequent impacts on our world."),
                         tags$h3("Main questions"),
                         tags$p("Question 1: How have global temperature anomalies evolved over the years, and what does this suggest about the pace and scale of global warming?"),
                         tags$p("Question 2: How do temperature anomalies compare across different decades, and what can these comparisons tell us about the trends in global warming and its acceleration over time?"),
                         tags$p("Question 3: How do the annual average land temperature changes over the years, and what does this intigates about the trends of global warming?"),
                         tags$img(src="https://t3.ftcdn.net/jpg/03/50/31/58/240_F_350315847_eo74yoI3NoaV9NFVSHj5DItIxwh6VUG0.jpg", height = "200px", width = "350px")
                  )
                )
              )),
      tabItem(tabName = "chart1",
              fluidPage(
                titlePanel("Chart 1: Global Temperature Anomalies"),
                sidebarLayout(
                  sidebarPanel(
                    sliderInput("yearRange", "Select Year Range", min = 1880, max = 2020, value = c(1880, 2020),step = 1),
                    hr(),
                    h4("About this chart"),
                    p("This chart answers the first question."),
                    p("This chart visualizes the annual global temperature anomalies to help understand how global temperatures have fluctuated over the years relative to a historical average. It aims to highlight trends in warming or cooling over different periods and can be used to infer potential causes of these anomalies such as industrial activities or natural events.")),
                  mainPanel(
                    plotlyOutput("tempPlot")
                  )
                )
              )),
      tabItem(tabName = "chart2",
              fluidPage(
                titlePanel("Chart 2: Climate Data Visualization - Dot Plot"),
                sidebarLayout(
                  sidebarPanel(
                    helpText("Interactive visualization of temperature anomalies by decade."),
                    sliderInput("decadeRange", "Select Decade Range:",
                                min = 1880,  
                                max = 2020, 
                                value = c(1880, 2020),  
                                step = 10, 
                                ticks = TRUE),
                    
                    selectInput("aggregationMethod", "Choose Aggregation Method:",
                                choices = list("Sum" = "sum", "Average" = "mean"),
                                selected = "sum"),
                    hr(),
                    h4("About this chart"),
                    p("This chart answers the second question."),
                    p("This dot plot visualizes global temperature anomalies by decade, highlighting the fluctuations and trends in climate change over time. Each dot represents the cumulative or average temperature anomaly for a decade, depending on user selection."),
                    p("Users can adjust the time range and aggregation method to explore specific periods and observe how global temperatures have shifted. This visualization aims to provide a straightforward overview of historical climate patterns, aiding in the understanding of long-term climate trends.")
                  ),
                  mainPanel(
                    plotlyOutput("dotPlot")
                  )
                )#tabsetPanel
              )),
      tabItem(tabName = "chart3",
              fluidPage(
                titlePanel("Chart 3: Annual Average Land Temperature"),
                sidebarLayout(
                  sidebarPanel(
                    sliderInput("yearRange3", "Select Year Range", min = 1750, max = 2015, value = c(1750, 2015), step = 1),
                    hr(),
                    h4("About this chart"),
                    p("This chart answers the third question."),
                    p("This line chart visualizes the annual average land temperature over time. It aims to provide a clear picture of the trends in land temperature, which is a critical component of global climate patterns."),
                    p("Users can adjust the time range to explore specific periods and observe how land temperatures have shifted. This visualization aims to provide a straightforward overview of historical climate patterns, aiding in the understanding of long-term climate trends of land temperature.") 
                  ),
                  mainPanel(
                    plotlyOutput("avgTempPlot")
                  )
                )
              )),
      tabItem(tabName = "conclusion",
              fluidPage(
                titlePanel("Conclusion"),
                fluidRow(
                  column(12,
                         tags$h3("Major Takeaways"), 
                         tags$p("1. The analysis of global temperature anomalies over time has revealed a consistent and alarming trend of global warming. This finding is crucial for technologists and researchers who can use this data to innovate solutions to mitigate the effects of climate change. For instance, developing more efficient renewable energy sources or advanced climate monitoring systems can help track and address these changes more effectively."),
                         tags$p("2. The comparison of temperature anomalies across different decades highlighted the accelerating pace of global warming. This insight is particularly relevant for policymakers. By understanding how quickly the climate is changing, they can establish targeted regulatory frameworks and climate policies. These policies might include stricter emissions regulations, incentives for green technologies, and international agreements aimed at reducing greenhouse gas emissions."),
                         tags$p("3. The examination of annual average land temperatures provided clear evidence of the increasing frequency and severity of extreme weather events. This information is valuable for infrastructure designers. It emphasizes the need for creating sustainable and resilient infrastructure that can withstand such conditions. Incorporating climate resilience into urban planning and development will be critical for ensuring the long-term sustainability of cities."),
                         tags$h3("Summary"),
                         tags$p("The results of our analysis of global climate change data have important implications for technologists, designers, and policymakers. Researchers and technologists can use this data to innovate solutions to mitigate the effects of climate change, such as developing more efficient renewable energy sources or advanced climate monitoring systems. Infrastructure designers can use this data to create sustainable and resilient infrastructure that can withstand extreme weather conditions, contributing to the long-term sustainability of cities. Policymakers, especially those involved in environmental law, can use this research to identify the most vulnerable areas and establish targeted regulatory frameworks. This will help shape effective climate policies and international agreements to reduce greenhouse gas emissions, enhance climate resilience, and promote sustainable development."),
                         tags$p("The challenges we face in this project are multifaceted. Data quality and consistency are important issues, as the quality of data from different sources varies greatly, leading to the possibility that our analysis may not be accurate. Granularity of the data is another issue; while data on a global scale is available, the lack of local details can hinder targeted analysis. There are also limits to the time coverage of the data, as climate change trends require long-term data to identify meaningful patterns. In addition, dealing with data gaps and missing information is a common challenge with large data sets, complicating trend analysis and model accuracy."),
                         tags$p("Analysis of the dataset revealed several key statistics about global land and ocean temperatures. Our graph shows the continuous increase in Temperature over time, including Temperature Anomalies and Annual Average Land Temperature, showing the increasing environmental and climate problems."),
                         tags$p("Together, our study highlights the need for coordinated sectoral efforts to address the challenges posed by climate change. By harnessing data-driven insights, we can develop innovative solutions and implement effective policies that collectively contribute to a more sustainable future.")
                  )
                )
              ))
    )
  )
)
