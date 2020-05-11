library(shiny)
ui <- fluidPage(
    textInput("your_name",label = "What is your name"),
    textOutput("text_out")
)
server <- function(input, output, session) {
    output$text_out <- renderText({
        paste0("Hello ", input$your_name)
        })
}
shinyApp(ui, server)
