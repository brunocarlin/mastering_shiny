library(shiny)
library(shinydashboard)
library(lubridate)

animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")

header <- dashboardHeader(title = "Chapter 3")


sidebar <- dashboardSidebar(sidebarMenu(
    menuItem(tabName = "322",text = "3.2.2 Free text"),
    menuItem(tabName = "323",text = "3.2.3 Numeric inputs"),
    menuItem(tabName = "324",text = "3.2.4 Dates"),
    menuItem(tabName = "325",text = "3.2.5 Limited choices"),
    menuItem(tabName = "326",text = "3.2.6 File Uploads"),
    menuItem(tabName = "327",text = "3.2.7 Action Buttons"),
    menuItem("3.2.8 Exercises",
             menuSubItem("1",tabName = "3281"),
             menuSubItem("2",tabName = "3282"),
             menuSubItem("3",tabName = "3283"),
             menuSubItem("4",tabName = "3284"),
             menuSubItem("5",tabName = "3285")),
    menuItem(tabName = "331",text = "3.3.1 Text"),
    menuItem(tabName = "332",text = "3.3.2 Tables"),
    menuItem(tabName = "333",text = "3.3.3 Plots"),
    menuItem(text = "3.3.5 Exercises",
             menuSubItem("1,2",tabName = "3351"),
             menuSubItem("3",tabName = "3353"))
    )
)

body <- dashboardBody(
    tabItems(

# 3.2.2 -----------------------------------------------------------------------------------------------------------

        tabItem(tabName = "322",
                fluidPage(
                    textInput("name", "What's your name?"),
                    passwordInput("password", "What's your password?"),
                    textAreaInput("story", "Tell me about yourself", rows = 3)
                )),

# 3.2.3 -----------------------------------------------------------------------------------------------------------

        tabItem(tabName = "323",
                fluidPage(
                    numericInput("num", "Number one", value = 0, min = 0, max = 100),
                    sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
                    sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100)
                )),

# 3.2.4 -------------------------------------------------------------------------------------------------------------

        tabItem(tabName = "324",
                fluidPage(
                    dateInput("dob", "When were you born?"),
                    dateRangeInput("holiday", "When do you want to go on vacation next?")
                )),

# 3.2.5 -----------------------------------------------------------------------------------------------------------

        tabItem(tabName = "325",
                fluidPage(
                    selectInput("state", "What's your favourite state?", state.name),
                    radioButtons("animal", "What's your favourite animal?", animals)
                ),

                fluidPage(
                    radioButtons("rb", "Choose one:",
                                 choiceNames = list(
                                     icon("angry"),
                                     icon("smile"),
                                     icon("sad-tear")
                                 ),
                                 choiceValues = list("angry", "happy", "sad")
                    )
                ),
                fluidPage(
                    selectInput(
                        "state", "What's your favourite state?", state.name,
                        multiple = TRUE
                    )
                ),
                fluidPage(
                    checkboxGroupInput("animal", "What animals do you like?", animals)
                )

                ),

# 3.2.6 -----------------------------------------------------------------------------------------------------------

        tabItem("326",
                fluidPage(
                    fileInput("upload", NULL)
                )),

# 3.2.6 -----------------------------------------------------------------------------------------------------------

        tabItem("327",
                fluidPage(
                    actionButton("click", "Click me!"),
                    actionButton("drink", "Drink me!", icon = icon("cocktail"))
                )),

# 3.2.8 -----------------------------------------------------------------------------------------------------------

        tabItem("3281",
                fluidPage(textInput(inputId = "name",label = NULL,placeholder = "Your name"))
                ),

        tabItem("3282",
                fluidPage(sliderInput(inputId = "dateslider",
                                      label = "When we should deliver",
                                      min = ymd("2019-08-09"),
                                      max = ymd("2019-08-16"),
                                      value = ymd("2019-08-10"))
                          )
                ),

        tabItem("3283",
                fluidPage(
                    selectInput("state", "Choose a state:",
                                list(`East Coast` = list("NY", "NJ", "CT"),
                                     `West Coast` = list("WA", "OR", "CA"),
                                     `Midwest` = list("MN", "WI", "IA"))
                                )
                    )
                ),

        tabItem("3284",
                fluidPage(
                    sliderInput(inputId = "slide_glide",
                                label = "Slider animation",
                                min = 0,
                                max = 100,
                                value = 0,
                                step = 5,
                                animate = animationOptions(interval = 100,loop = TRUE))
                )),

        tabItem("3285",
                fluidPage(
                    numericInput("number", "Select a value", value = 150, min = 0, max = 1000, step = 50)
                )),

# 3.3.1 ------------------------------------------------------------------------------------------------------------

        tabItem("331",
                fluidPage(textOutput("text331"),
                          verbatimTextOutput("code331")
                )),

# 3.3.2 -----------------------------------------------------------------------------------------------------------

        tabItem("332",
                fluidPage(
                    tableOutput("static332"),
                    dataTableOutput("dynamic332")
                )),

# 3.3.3 -----------------------------------------------------------------------------------------------------------

        tabItem("333",
                fluidPage(
                    plotOutput("plot333", width = "400px")
                )),


# 3.3.5 -----------------------------------------------------------------------------------------------------------

        tabItem("3351",
                fluidPage(
                    fluidRow(column(plotOutput("plot3351",height = "300px"),width = 6),
                             column(plotOutput("plot3352",height = "300px"),width = 6)
                ))),

        tabItem("3353",
                fluidPage(
                    dataTableOutput("table3353")

                ))

    )





)






ui <- dashboardPage(header = header,
                    sidebar = sidebar,
                    body = body)


server <- function(input, output) {

    output$text331 <- renderText("Hello friend!")
    output$code331 <- renderPrint(summary(1:10))

    output$static332 <- renderTable(head(mtcars))
    output$dynamic332 <- renderDataTable(mtcars, options = list(pageLength = 5))

    output$plot333 <- renderPlot(plot(1:5), res = 96)

    output$plot3351 <- renderPlot(plot(1:5), res = 96)
    output$plot3352 <- renderPlot(plot(1:5), res = 96)


    output$table3353 <- renderDataTable(mtcars, options = list(ordering = FALSE,
                                                               searching = FALSE,
                                                               filtering = FALSE,
                                                               lengthChange = FALSE,
                                                               paging = FALSE))


}

shinyApp(ui, server)
