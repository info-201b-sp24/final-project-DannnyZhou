#ui
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
      menuItem("Chart 2", tabName = "chart 2", icon = icon("chart-pie")),
      menuItem("Chart 3", tabName = "chart 3", icon = icon ("chart-line")),
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
                         tags$p("Question 2: How have global temperature anomalies changed over the past 140 years, and what does this suggest about the trend in global warming?"),
                         tags$p("Question 3: "),
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
                  p("This chart answers the first question"),
                  p("This chart visualizes the annual global temperature anomalies to help understand how global temperatures have fluctuated over the years relative to a historical average. It aims to highlight trends in warming or cooling over different periods and can be used to infer potential causes of these anomalies such as industrial activities or natural events.")),
                  mainPanel(
                    plotlyOutput("tempPlot")
                  )
                )
              )),
      tabItem(tabName = "chart2",
              fluidPage(
                titlePanel("Chart 2: Global Temperature Anomalies Over Time"),
                sidebarLayout(
                  sidebarPanel(
                    sliderInput("yearRange", "Select Year Range", min = 1880, max = 2020, value = c(1880, 2020),step = 1),
                    hr(),
                    h4("About this chart"),
                    p("This chart answers the second question"),
                    p("This chart shows that over the past 140 years, global temperature anomalies have exhibited a significant upward trend, particularly in recent decades. Early years display relatively small temperature anomalies, while the late 20th and early 21st centuries show a marked increase in these values. This indicates that the trend of global warming is accelerating, demonstrating the significant impact of human activities, such as greenhouse gas emissions, on the climate. Such data helps in understanding the long-term trend of global warming and its potential environmental and societal impacts, emphasizing the importance and urgency of addressing climate change.")
                  ),
                  mainPanel(
                    plotlyOutput("pieChart")
                  )
                )
              )),
      tabItem(tabName = "Chart 3",
              fluidPage(
                titlePanel("Chart 3"),
                #Add
              )),
      tabItem(tabName = "Conclusion",
              fluidPage(
                titlePanel("Conclusion"),
                # Summary and insights
              ))
    )
  )
)
