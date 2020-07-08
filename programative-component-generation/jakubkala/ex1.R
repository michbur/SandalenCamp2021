library(shiny)
library(shinyhelper)
library(dplyr)

ui <- fluidPage(
  plotOutput("simple_plot") %>% helper(type = "markdown",
                                       content = "simple_plot"),
  numericInput("n_points", label = "Number of points", value = 15820))

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