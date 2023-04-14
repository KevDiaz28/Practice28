library(shiny)
library(shinydashboard)
library(shinyWidgets)

library(shiny)
library(dplyr)

# UI de la aplicación
ui <- fluidPage(
  dashboardHeader(title = "Dashboard de post"),
  dashboardSidebar(),
  dashboardBody(
    tags$style(HTML("
    
.container-cards {
    display: flex;
    justify-content: center;
}
.card-body {
margin: auto;
max-width: 800px;
}
.content-wrapper {
background-color: red;
margin: 10px;
border: 1px solid black;
border-radius: 5px;
}
.message-title {
width: 100%;
text-align: center;
font-size: 24px;
font-weight: bold;
color: blue;
}
.fecha-title {
width: 100%;
text-align: center;
font-size: 18px;
font-weight: bold;
color: black;
}
.metric {
margin-top: 10px;
border: 1px solid black;
border-radius: 5px;
}
.metric-alcance {
background-color: #FFDAB9;
}
.metric-impresiones {
background-color: #ADD8E6;
}
.metric-reacciones {
background-color: #98FB98;
}
.metric-linkclicks {
background-color: #FFA07A;
}
.metric-comentarios {
background-color: #FFC0CB;
}
.metric-shares {
background-color: #F0E68C;
}
")),
    fluidRow(
      column(width = 12,
             dateRangeInput("fecha", label = "Filtrar por fecha",
                            start = min(Data_Frame_Final$Fecha),
                            end = max(Data_Frame_Final$Fecha),
                            format = "yyyy-mm-dd")
      )
    ),
    uiOutput("dashboard")
  ),
  skin = "black"
)
server <- function(input, output) {
  output$dashboard <- renderUI({
    fecha_filtrada <- Data_Frame_Final %>%
      filter(Fecha >= input$fecha[1] & Fecha <= input$fecha[2])
    lapply(1:4, function(i) {
      fluidRow(
        column(width = 4,
               # Muestra la imagen del post
               box(title = paste0("Fecha: ", fecha_filtrada$Fecha[i]), class = "fecha-title",
                   img(src = fecha_filtrada$full_picture[i], width = "100%"))
        ),
        column(width = 8,
               # Muestra las métricas del post en tarjetas
               tags$div(class = "content-wrapper",
                        box(title = paste0("", fecha_filtrada$message[i]), class = "message-title",
                            
                            tags$div(class = "container container-cards text-center",
                                     tags$div(class = "row",
                                              tags$div(class = "col",
                                                       tags$div(class = "card text-white bg-primary mb-3",
                                                                tags$div(class = "card-header",tags$h4("Alcance")),
                                                                tags$div(class = "card-body",
                                                                         tags$h2(class = "card-text", format(fecha_filtrada$post_impressions_unique[i], big.mark = ","))
                                                                ),
                                                       ),
                                                       
                                              ),
                                              
                                              tags$div(class = "col",
                                                       tags$div(class = "card text-white bg-primary mb-3",
                                                                tags$div(class = "card-header",tags$h4("Alcance")),
                                                                tags$div(class = "card-body",
                                                                         tags$h2(class = "card-text", format(fecha_filtrada$post_impressions_unique[i], big.mark = ","))
                                                                ),
                                                       ),
                                                       
                                              )
                                              
                                     )
                                     
                            ),
                            
                            
                            tags$div(class = "card text-white bg-primary mb-3",
                                     tags$div(class = "card-header",tags$h4("Alcance")),
                                     tags$div(class = "card-body",
                                        tags$h2(class = "card-text", format(fecha_filtrada$post_impressions_unique[i], big.mark = ","))
                                     ),
                            ),
                            
                            tags$div(class = "card text-white bg-primary mb-3",
                                     tags$div(class = "card-header",tags$h4("Alcance")),
                                     tags$div(class = "card-body",
                                              tags$h2(class = "card-text", format(fecha_filtrada$post_impressions_unique[i], big.mark = ","))
                                     ),
                            ),
                            
                            
                       #     tags$div(class = "card text-white bg-primary mb-3",
                      #               
                       #              tags$div(class = "card-header",tags$h4("Alcance")),
                        #             
                        #             tags$div(class = "card-body",(
                         #              tags$div(class = "card-title",tags$h4("Alcance"))
                          #             tags$h2(format(fecha_filtrada$post_impressions_unique[i], big.mark = ","))
                           #          )
                            #         )
                            #),
                            
                            tags$div(class = "row metric metric-impresiones",
                                     tags$div(class = "col-sm-4",
                                              tags$h4("Impresiones"),
                                              tags$h2(format(fecha_filtrada$post_impressions[i], big.mark = ","))
                                     )
                            ),
                            tags$div(class = "row metric metric-linkclicks",
                                     tags$div(class = "col-sm-4",tags$h4("Link Clicks"),
                                              tags$h2(format(fecha_filtrada$link_clicks[i], big.mark = ","))
                                     )
                            ),
                            tags$div(class = "row metric metric-reacciones",
                                     tags$div(class = "col-sm-4",
                                              tags$h4("Reacciones"),
                                              tags$h2(format(fecha_filtrada$Reacciones[i], big.mark = ","))
                                     )
                            ),
                            tags$div(class = "row metric metric-comentarios",
                                     tags$div(class = "col-sm-4",
                                              tags$h4("Comentarios"),
                                              tags$h2(format(fecha_filtrada$Comentarios[i], big.mark = ","))
                                     )
                            ),
                            tags$div(class = "row metric metric-shares",
                                     tags$div(class = "col-sm-4",
                                              tags$h4("Shares"),
                                              tags$h2(format(fecha_filtrada$Shares[i], big.mark = ","))
                                     )
                            )
                        )
               )
        )
      )
    })
  })
}

# Ejecutar la aplicación
shinyApp(ui = ui, server = server)
