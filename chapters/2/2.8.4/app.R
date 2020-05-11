ui <- fluidPage(
    sliderInput("x", "If x is", min = 1, max = 50, value = 30),
    sliderInput("y", "and y is", min = 1, max = 50, value = 5),
    textOutput("product_text1"),
    textOutput("product_text2"),
    textOutput("product_text3"),
)

server <- function(input, output, session) {

    product <- reactive(input$x * input$y)

    output_text_reactive <- reactive(paste0(input$x," multiplied by ",input$y))

    output$product_text1 <- renderText({
        paste0("then, ",output_text_reactive()," is ",product())
    })

    output$product_text2 <- renderText({
        paste0("and, ",output_text_reactive()," plus 5 is ",product() + 5)
    })

    output$product_text3 <- renderText({
        paste0("finally, ",output_text_reactive()," plus 10 is ",product() + 10)
    })

}
shinyApp(ui, server)

