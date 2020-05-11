ui <- fluidPage(
    sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
    sliderInput("y", label = "and y is", min = 1, max = 50, value = 5),
    textOutput("product_text"),
    textOutput("product")
)

server <- function(input, output, session) {

    output$product_text <- renderText({
        paste0("then, ",input$x," multiplied by ",input$y)
    })

    output$product <- renderText({
        input$x * input$y
    })
}
shinyApp(ui, server)
