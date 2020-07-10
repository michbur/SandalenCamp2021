library(shiny)

ui <- fluidPage(
  uiOutput("ui")
)
server <- function(input, output, session){

  output[["ui"]] <- renderUI({
    tagList(
      textInput("textInput",label = "Write color in correct format (#FFB6C1)",value = 0),
      tags[["style"]](paste0("#textInput","{background-color:",backgroundColor[["color"]], ";}"))
    )
  })
  
  # #FFB6C1 for debugging
  backgroundColor <- reactiveValues("color"="#ff0000")
  observeEvent(input[["textInput"]],{ backgroundColor[["color"]] <- input[["textInput"]]})
  observe({updateTextInput(session, "textInput", value = backgroundColor[["color"]])})
  
}

shinyApp(ui, server)