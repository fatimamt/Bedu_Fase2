#install.packages("scales")
library(shiny)
library(dplyr)
library(ggplot2)
library(scales)

shinyServer(
    function(input, output) {
        #dir <- dirname(rstudioapi::getSourceEditorContext()$path)
        #setwd(dir)
        
        dataCovid <- read.csv(file = "dataCovid.csv")
        dataCovid$date <- as.Date(dataCovid$date, format = "%Y-%m-%d")
        
        orderedLocations <- dataCovid[order(dataCovid$location, decreasing = FALSE),]
        orderedLocations <- orderedLocations[match(unique(orderedLocations$location), orderedLocations$location),]
        
        orderedPeopleVaccinatedAsc <- dataCovid[order(dataCovid$people_vaccinated, decreasing = TRUE),]
        orderedPeopleVaccinatedAsc <- orderedPeopleVaccinatedAsc[match(unique(orderedPeopleVaccinatedAsc$location), orderedPeopleVaccinatedAsc$location),]
        
        orderedPeopleVaccinatedDes <- dataCovid[order(dataCovid$peo, decreasing = FALSE),]
        orderedPeopleVaccinatedDes <- orderedPeopleVaccinatedDes[match(unique(orderedPeopleVaccinatedDes$location), orderedPeopleVaccinatedDes$location),]
        
        observeEvent(input$sort, {
            data = data.frame()
            if(input$sort == "Orden Alfabético") {
                data <- orderedLocations$location
            } 
            if(input$sort == "Menor a Mayor (cantidad)") {
                data <- orderedPeopleVaccinatedDes$location
            } 
            if(input$sort == "Mayor a Menor (cantidad)") {
               data <- orderedPeopleVaccinatedAsc$location
            }
            
            output$checkbox <- renderUI({
                checkboxGroupInput("variable", "Paises:",
                                   data)
            })
        })
        
        output$plot_people_vaccinated <- renderPlot({
                if(!is.null(input$variable)){
                    topDataCovid <- read.csv(file = "dataCovid.csv")
                    topDataCovid$date <- as.Date(topDataCovid$date, format = "%Y-%m-%d")
                    topDataCovid <- topDataCovid %>% filter(location %in% input$variable)
                    
                    topDataCovid %>%
                        group_by(location) %>%
                        ggplot(aes(x=date, y=people_vaccinated, color=location)) +
                        geom_line(size=1) + 
                        geom_point(size=1.5) + 
                        labs(x = "Fecha", y = "Personas Vacunadas", colour = "País") +
                        scale_y_continuous(labels = comma) 
                }
                
            })
        
        output$plot_new_cases <- renderPlot({
            if(!is.null(input$variable)){
                topDataCovid <- read.csv(file = "dataCovid.csv")
                topDataCovid$date <- as.Date(topDataCovid$date, format = "%Y-%m-%d")
                topDataCovid <- topDataCovid %>% filter(location %in% input$variable)
                
                topDataCovid %>%
                    group_by(location) %>%
                    ggplot(aes(x=date, y=new_cases, color=location)) +
                    geom_line(size=1) + 
                    geom_point(size=1.5) +
                    labs(x = "Fecha", y = "Nuevos Casos", colour = "País") +
                    scale_y_continuous(labels = comma) 
            }
            
        })
    }
)
