
library(shiny)
library(shinydashboard)
# install.packages("shinythemes")
library(shinythemes)

# Define UI for application that draws a histogram
ui <- 
    
    fluidPage(
        
        dashboardPage(
            
            dashboardHeader(title = "Dashboard Sesión 08"),
            
            dashboardSidebar(
                
                sidebarMenu(
                    menuItem("Gráfica de Barras", tabName = "barras", icon = icon("bar-chart")),
                    menuItem("Imágenes Postwork 03", tabName = "imag", icon = icon("file-picture-o")),
                    menuItem("Data Table de match.data.csv", tabName = "data_table", icon = icon("table")),
                    menuItem("Factores de Ganancia", tabName = "min_max", icon = icon("file-picture-o"))
                )
                
            ),
            
            dashboardBody(
                
                tabItems(
                    
                    # Gráfica de Barras
                    tabItem(
                        tabName = "barras",
                        fluidRow(
                            titlePanel(h3("Gráfica de Barras de Goles")), 
                            selectInput("x", "Seleccione el valor de X",
                                        choices = c("FTHG", "FTAG")),
                            box(plotOutput("plotbarras", height = 800, width = 1000)),
                        )
                    ),
                    
                    # Imágenes Postwork 03
                    tabItem(
                        tabName = "imag",
                        fluidRow(
                            titlePanel(h3("Probabilidad Marginal de que el equipo en casa anote x goles")),
                            img(src = "prob_marg_host.png",
                                width = 800, height = 600),
                            
                            titlePanel(h3("Probabilidad Marginal de que el equipo visitante aote y goles")),
                            img(src = "prob_marg_away.png",
                                width = 800, height = 600),
                            
                            titlePanel(h3("Probabilidad Conjunta de cantidad de goles que anotan el euqipo de casa y el equipo visitante en un partido")),
                            img(src = "heatmap_prob_conj.png",
                                width = 800, height = 600),
                        )
                        
                    ),
                    
                    # Data Table
                    tabItem(tabName = "data_table",
                            fluidRow(        
                                titlePanel(h3("Data Table")),
                                dataTableOutput ("data_table")
                            )
                    ), 
                    
                    # Imáenes de momios
                    tabItem(
                        tabName = "min_max",
                        fluidRow(
                            titlePanel(h3("Mínimo factor de ganancia")),
                            img(src = "momios_prom.png",
                                width = 800, height = 600),
                            
                            titlePanel(h3("Máximo factor de ganancia")),
                            img(src = "momios_max.png",
                                width = 800, height = 600),
                        )
                        
                    )
                )
            )
        )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {
    library(ggplot2)
    library(dplyr)
    
    fut <- read.csv("data.csv") 

    # Gráfico de Barras
    output$plotbarras <- renderPlot({
        
        x <- fut[,input$x]
        
        fut %>%
            ggplot() +
            aes(x) +
            geom_bar(stat = "bin", color = "black", fill = "darkblue") +
            facet_wrap(fut$FTAG) +
            xlab(input$x)
            
        
    })
    
    # Data Table
    output$data_table <- renderDataTable(
        {fut}, options = list(aLengthMenu = c(5,25,50),
                              iDisplayLength = 25)
                                         )
}

# Run the application 
shinyApp(ui = ui, server = server)
