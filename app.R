library(shinydashboard)
library(dplyr)
library(shiny)
library(slickR)

ui <- fluidPage(
  # Add a title to the page
  titlePanel("Carousel of Images"),

  # Create the date range input widget
  dateRangeInput("date", "Select a date range"),

  # Create the carousel
  slickROutput("myCarousel", width = "100%", height = "500px"),

  # Add CSS styles
  tags$style(HTML('
.image-card {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  border: 1px solid #ccc;
  border-radius: 5px;
  box-shadow: 2px 2px 5px #ccc;
  padding: 10px;
  margin-bottom: 10px;
  text-align: center;
}

.image-card img {
  max-width: 100%;
}

.metric {
  background-color: #f5f5f5;
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 5px;
  margin-top: 5px;
  margin-bottom: 5px;
  color: #333;
  width: 100%;
}

.metric-alcance {
  background-color: #003366;
  color: #fff;
}

.metric-impresiones {
  background-color: #002147;
  color: #fff;
}

.metric-reacciones {
  background-color: #f5f5f5;
  color: #ff9900;
}

.metric-linkclicks {
  background-color: #f5f5f5;
  color: #109618;
}

.metric-comentarios {
  background-color: #f5f5f5;
  color: #990099;
}

.metric-shares {
  background-color: #f5f5f5;
  color: #0099c6;
}
  '))
)

server <- function(input, output) {
  # Filter the data based on the selected date range
  Data_Frame_Final_filtered <- reactive({
    Data_Frame_Final[as.Date(Data_Frame_Final$Fecha) >= input$date[1] & as.Date(Data_Frame_Final$Fecha) <= input$date[2], ]
  })

  # Create the carousel with images and metrics
  output$myCarousel <- renderSlickR({
    slickR(
      lapply(seq_along(Data_Frame_Final_filtered()$full_picture), function(i) {
        img_tag <- tags$img(src = Data_Frame_Final_filtered()$full_picture[i], class = "img-fluid", style = "max-height: 500px;")
        # Create the metrics for each image
        alcance <- Data_Frame_Final_filtered()$post_impressions_unique[i]
        impresiones <- Data_Frame_Final_filtered()$post_impressions[i]
        reacciones <- Data_Frame_Final_filtered()$post_reactions_by_type_total[i]
        linkclicks <- Data_Frame_Final_filtered()$link_clicks[i]
        comentarios <- Data_Frame_Final_filtered()$post_comments[i]
        shares <- Data_Frame_Final_filtered()$post_shares[i]

        metric_tag <- tags$div(
          class = "metric",
          tags$div(paste0("Alcance: ", alcance), class = "metric-alcance"),
          tags$div(paste0("Impresiones: ", impresiones), class = "metric-impresiones"),
          tags$div(paste0("Reacciones: ", reacciones), class = "metric-reacciones"),
          tags$div(paste0("Link Clicks: ", linkclicks), class = "metric-linkclicks"),
          tags$div(paste0("Comentarios: ", comentarios), class = "metric-comentarios"),
          tags$div(paste0("Shares: ", shares), class = "metric-shares")
        )

        # Combine the image and metrics into an image card
        tags$div(class = "image-card", img_tag, metric_tag)
      })
    )
  })
}

shinyApp(ui = ui, server = server)
