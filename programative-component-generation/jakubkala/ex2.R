library(shiny)
library(shinyhelper)
library(dplyr)

plotOutput_h <- function(outputId, ...) {
  plotOutput(outputId, ...) %>% helper(type="markdown", content = outputId)
}
numericInput_h <- function(inputId, ...) {
  numericInput(inputId, ...) %>% helper(type="markdown", content = inputId)
}

ui <- fluidPage(
  plotOutput_h("simple_plot"),
  numericInput_h("n_points", label = "Number of points", value = 15820))

server <- function(input, output) {
  
  observe_helpers(help_dir = "helpers_mds")
  
  output[["simple_plot"]] <- renderPlot({
    
    plot(1L:input[["n_points"]], type = "b")
    
  })
  
  output[["simpler_plot"]] <- renderPlot({
    
    plot(1L:input[["n_points"]] * 2, type = "b")
    
  })
  
}

shinyApp(ui = ui, server = server)