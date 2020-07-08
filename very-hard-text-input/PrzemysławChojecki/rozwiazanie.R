library(shiny)

ui <- fluidPage(
  uiOutput("text")
)

server <- function(input, output, session) {
  rv <- reactiveValues(kolor = "")
  
  observeEvent(input[["hexCol"]], {
    if(is.null(input[["hexCol"]])) {
      kolor <- ""
    } else {
      kolor <- input[["hexCol"]]
    }
    
    rv[["kolor"]] <- kolor
  })
  
  output[["text"]] <- renderUI({column(3, wellPanel(div(id='my_textinput' ,
                          textInput ('hexCol', label = "Podaj kolor", value = "", width = "200px")),
                      tags$style(type="text/css",
                                 paste0("#hexCol {background-color: #", rv[["kolor"]], "}"))))
  })
  
  observe({
    updateTextInput(session, "hexCol", value = rv[["kolor"]])
  })
}

shinyApp(ui, server)