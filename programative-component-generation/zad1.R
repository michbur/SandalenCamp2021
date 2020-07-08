library(shiny)
library(shinycssloaders)
library(shinyhelper)
library(ggplot2)

plotOutput_ws <- function(outputId, ...) {
  withSpinner(plotOutput(outputId, ...))
}


ui <- fluidPage(helper(numericInput("n_points", label = "Number of points", value = 1000), 
                       content = "n_points"), 
                helper(plotOutput("simple_plot", height = "350px"),
                       content = "simple_plot"),
                verbatimTextOutput("output_debug"))


server <- function(input, output) {
  observe_helpers(session = shiny::getDefaultReactiveDomain(),
                  help_dir = "helpfiles")
  
  set.seed(17)
  output[["simple_plot"]] <- renderPlot({
    ggplot(data.frame(x = rnorm(input[["n_points"]]), y = rnorm(input[["n_points"]])), 
                      aes(x = x, y = y))+
      geom_point()
  })
  
  output[["output_debug"]] <- renderPrint({
    getwd()
    list.files()
    list.dirs()
  })
  
  
}

shinyApp(ui = ui, server = server)
