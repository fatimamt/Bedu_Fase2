
library(class)
library(dplyr)
library(stringr)

library(shiny)
install.packages("shinydashboard")
library(shinydashboard)

shinyUI(
    pageWithSidebar(
        headerPanel("Aplicacion básica con Shiny"),
        sidebarPanel(
            p("Crear plots con el DF 'auto'"), 
            selectInput("x", "Seleccione el valor de X",
                        choices = names(mtcars))
        ),
        mainPanel(
            
            
            #Agregando pestañ±as
            tabsetPanel(
                tabPanel("Plots",                   #Pestaña de Plots <---------
                         h3(textOutput("output_text")), 
                         plotOutput("output_plot"), 
                ),
                
                tabPanel("Imágenes",                #Pestaña de imágenes  <---------
                         img( src = "cor_mtcars.png", 
                              height = 450, width = 550)
                ), 
                
                tabPanel("Summary", verbatimTextOutput("summary")),     # <--------- Summary
                tabPanel("Table", tableOutput("table")),                # <--------- Table
                tabPanel("Data Table", dataTableOutput("data_table"))   # <--------- Data table
            )
        )
    )
    
)
