library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
    
    headerPanel("Life Expectancy"),
    
    sidebarPanel(
        
        h6("Select your gender and age to see your probability of death in the next year and probable years remaining in your life based on 2011 data from US Social Security."),
        selectInput('gender', 'Gender', c("Male", "Female")),
        sliderInput('age', 'Age', value = 30, min = 1, max = 119, step = 1),
        h5(textOutput("caption"))
    ),
    
    mainPanel(
        plotOutput('plot')
    )
))