library(shiny)
library(shinyhelper)
library(dplyr)
library(stringr)

createHelpers <- function(){
  possibleOutputs <- ls("package:shiny")[grep("Output", ls("package:shiny"))]
  path <- "helpers_mds"

  for(i in 1:length(possibleOutputs)){
    if(!file.exists(paste0(path,"/",possibleOutputs[i]))){
      create_help_files(files = possibleOutputs[i],
                        help_dir = path)
    }
    function_name <- possibleOutputs[i]
    function_name_h <- paste0(possibleOutputs[i], "_h")
    func <- get(function_name)
    function_with_helper <- function(outputId, ...){
      helper(func(outputId, ...), type="markdown", content = function_name)
    }
    assign(function_name_h, function_with_helper, envir = .GlobalEnv)
  }
}

createHelpers()



numericInput_h <- function(inputId, ...) {
  numericInput(inputId, ...) %>% helper(type="markdown", content = inputId)
}

ui <- fluidPage(
  plotOutput_h("simple_plot"),
  numericInput_h("n_points", label = "Number of points", value = 158))

server <- function(input, output, session) {
  
  observe_helpers(help_dir = "helpers_mds")
  
  output[["simple_plot"]] <- renderPlot({
    
    plot(1L:input[["n_points"]], type = "b")
    
  })
}

shinyApp(ui = ui, server = server)
