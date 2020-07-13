library(shiny)
library(magrittr)
library(shinyhelper)

ui <- fluidPage(
  uiOutput("text")
)

server <- function(input, output, session) {
  observe_helpers()
  
  rv <- reactiveValues(kolor = "")
  
  observeEvent(input[["hexCol"]], {
    if(is.null(input[["hexCol"]])) {
      kolor <- ""
    } else {
      kolor <- input[["hexCol"]]
    }
    
    rv[["kolor"]] <- kolor
  })
  
  output[["text"]] <- renderUI({
    
    # sprawdzenie, czy podaje hex("d0d0d0"), czy nazwe ("red")
    czy_hex <- rv[["kolor"]] %>% stringr::str_detect("^[0-9a-fA-F]{6}$")
    kolor <- ifelse(czy_hex, "#", "") %>% paste0(rv[["kolor"]])
    CSS <- paste0("#hexCol {background-color: ", kolor, "}")
    
    column(3, wellPanel(div(id='my_textinput' ,
                          helper(textInput('hexCol', label = "Podaj kolor", value = "", width = "200px"),
                                 type = "inline",
                                 title = "Jak żyć?",
                                 content = c("Można wpisać:",
                                             "<ul>",
                                                "<li>Red</li>",
                                                "<li>d0d0d0</li>",
                                             "</ul>"))),
                      tags$style(type="text/css", CSS)))
  })
  
  observe({
    updateTextInput(session, "hexCol", value = rv[["kolor"]])
  })
}

shinyApp(ui, server)