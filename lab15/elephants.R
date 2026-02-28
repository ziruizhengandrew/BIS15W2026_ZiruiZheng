library(tidyverse)
library(janitor)
library(shiny)
library(shinydashboard)
library(shiny)

elephants <- read_csv("data/elephants_data/elephants.csv") %>%
  clean_names()

ui <- dashboardPage(
  dashboardHeader(title = "Range of age and height by sex of elephants"),
  dashboardSidebar(
    selectInput("y","Select Variable",
                choices = c("age",
                            "height"),
                selected = "age")
  ),
  
  dashboardBody(
    
    plotOutput("plot", width = "600px", height = "400px")
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    
    elephants%>%
      ggplot(aes(x= sex, y=.data[[input$y]]))+
      geom_boxplot(fill = "steelblue", alpha = 0.75)+
      labs(title = "Variables by Sex")+
      theme_minimal()
    
  })
}

shinyApp(ui, server)