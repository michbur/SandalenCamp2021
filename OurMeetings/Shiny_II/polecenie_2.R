library(shiny)
library(shinycssloaders)
library(shinyhelper)

#create_help_files(files = c("numericInput", "plotOutput"),
#                  help_dir = "helpfiles")

numericInput_h <- function(id, label, value,...){
  helper(numericInput(id, label, value, ...),
         icon = "question-circle",
         colour = "blue",
         type = "markdown",
         content = "numericInput")
}

plotOutput_h <- function(id, ...){
  helper(withSpinner(plotOutput(id, ...)),
         icon = "question-circle",
         colour = "blue",
         type = "markdown",
         content = "plotOutput")
}

ui <- fluidPage(plotOutput_h("simple_plot", height = "350px"),
                plotOutput_h("simpler_plot", height = "350px"),
                numericInput_h("n_points", label = "Number of points", value = 15))

server <- function(input, output) {
  
  observe_helpers()
  
  output[["simple_plot"]] <- renderPlot({
    
    plot(1L:input[["n_points"]], type = "b")
    
  })
  
  output[["simpler_plot"]] <- renderPlot({
    
    plot(1L:input[["n_points"]] * 2, type = "b")
    
  })
  
}

shinyApp(ui = ui, server = server)