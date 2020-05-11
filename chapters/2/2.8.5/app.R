library(shiny)
library(ggplot2)

# change size according to machine compute
size = 5

datasets <- data(package = "ggplot2")$results[, "Item"]

ui <- fluidPage(
    selectInput("dataset", "Dataset", choices = datasets),
    verbatimTextOutput("summary"),
    fluidRow(plotOutput("plot"))
)

server <- function(input, output, session) {
    dataset <- reactive({
        get(input$dataset, "package:ggplot2")
    })
    output$summary <- renderPrint({
        summary(dataset())
    })
    output$plot <- renderPlot({
        plot(head(dataset(),n = size))
    })
}
shinyApp(ui, server)
