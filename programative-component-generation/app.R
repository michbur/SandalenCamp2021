library(shiny)
library(shinycssloaders)

plotOutput_ws <- function(outputId, ...) {
  withSpinner(plotOutput(outputId, ...))
}

ui <- fluidPage(plotOutput_ws("simple_plot", height = "350px"),
                plotOutput_ws("simpler_plot", height = "350px"),
                numericInput("n_points", label = "Number of points", value = 15820))

server <- function(input, output) {
  
  output[["simple_plot"]] <- renderPlot({
    
    plot(1L:input[["n_points"]], type = "b")
    
  })
  
  output[["simpler_plot"]] <- renderPlot({
    
    plot(1L:input[["n_points"]] * 2, type = "b")
    
  })
  
}

shinyApp(ui = ui, server = server)
