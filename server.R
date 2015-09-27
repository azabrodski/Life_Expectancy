library(shiny)
library(ggplot2)
dp <- read.csv("death_tables.csv")
dpf <- dp[dp$gender == "Female",]
dpm <- dp[dp$gender == "Male",]

shinyServer(function(input, output) {
    
     dataset <- reactive({
        dp
    })
    
   
    
    output$plot <- renderPlot({
        y = input$age
        plot <- ggplot(dataset(), aes(x = age, y = prob_death, col = gender)) + geom_line() + ggtitle("US Social Security Acutarial Data") + xlab("Age") + ylab("Probability of Dying in the Next Year")
        
        if (input$gender == "Male"){
            prob = dpm$prob_death[y]
            plot = plot + geom_point(aes_string(x = input$age, y = prob))}
            
        if (input$gender == "Female")
            prob = dpf$prob_death[y]
            plot = plot + geom_point(aes_string(x = input$age, y = prob))
            
            
        print(plot)
        
        formulaText <- reactive({
        if (input$gender == "Male"){
            remain = dpm$years_remain[y]
            paste("On average, you have ", remain," years of life remaining" )}
        
        if (input$gender == "Female")
            remain = dpf$years_remain[y]
            paste("On average, you have ", remain," years of life remaining" )
        })
        
        # Return the formula text for printing as a caption
        output$caption <- renderText({
            formulaText()
        })   
        
    }, height=400)
    
})