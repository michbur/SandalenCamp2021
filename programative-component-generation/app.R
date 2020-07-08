library(shiny)
library(shinycssloaders)
library(shinyhelper)

plotOutput_ws <- function(outputId, ...) {
  withSpinner(plotOutput(outputId, ...))
}

plotOutput_h <- function(outputId, ...) {
  helper(withSpinner(plotOutput(outputId, ...)), content = outputId, type = "markdown")
}

numericOutput_h <- function(outputId, ...) {
  helper(withSpinner(numericInput(outputId, ...)), content = outputId, type = "markdown")
}



ui <- fluidPage(numericOutput_h("n_points", label = "Number of points", value = 15820), 
                plotOutput_h("simple_plot", height = "350px"),
                verbatimTextOutput("output_debug"))


server <- function(input, output) {
  observe_helpers(session = shiny::getDefaultReactiveDomain(),
                  help_dir = "helpfiles")
  
  
  output[["simple_plot"]] <- renderPlot({
    
    plot(1L:input[["n_points"]], type = "b")
  })
  
  output[["output_debug"]] <- renderPrint({
    getwd()
    list.files()
    list.dirs()
  })
  
  
}

shinyApp(ui = ui, server = server)
