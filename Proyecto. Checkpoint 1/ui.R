library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Analísis de datos de datos referentes a la vacunación contra COVID-19"),
        
        sidebarLayout(
            sidebarPanel(
                selectInput("sort", "Ordenar por: ", 
                            c("Orden Alfabético", "Menor a Mayor (cantidad)", "Mayor a Menor (cantidad)")),
                
                uiOutput("checkbox"),
            ),
            
            mainPanel(
                tabsetPanel(
                    tabPanel("Personas Vacunadas",
                             h3(textOutput("Vacunadas")), 
                             plotOutput("plot_people_vaccinated"), 
                    ),
                    
                    tabPanel("Personas Nuevas Infectadas",
                             h3(textOutput("Infectadas")), 
                             plotOutput("plot_new_cases"), 
                    )
                )
            )
        )
    )
)
