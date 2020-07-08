library(shiny)
library(shinycssloaders)
library(shinyhelper)
library(ggplot2)


plotOutput_h <- function(outputId, ...) {
  helper(plotOutput(outputId, ...), content = outputId, type = "markdown")
}

numericInput_h <- function(inputId, ...) {
  helper(numericInput(inputId, ...), content = inputId, type = "markdown")
}


ui <- fluidPage(numericInput_h(inputId = "n_points", 
                               label = "Number of points", 
                               value = 1000), 
                plotOutput_h(outputId = "simple_plot", height = "350px"))


server <- function(input, output) {
  observe_helpers(session = shiny::getDefaultReactiveDomain(),
                  help_dir = "helpfiles")
  
  set.seed(17)
  output[["simple_plot"]] <- renderPlot({
    ggplot(data.frame(x = rnorm(input[["n_points"]]), y = rnorm(input[["n_points"]])), 
           aes(x = x, y = y))+
      geom_point()
  })
}

shinyApp(ui = ui, server = server)
