
library(shiny)

shinyServer(function(input, output) {
    # input$x es la selección que se hizo en la UI
    output$output_text <- renderText(paste("Grafico de hp ~ ",
                                           input$x))
    
    output$output_plot <- renderPlot(plot(as.formula(paste("hp~", input$x)),
                                          data = mtcars))
})
