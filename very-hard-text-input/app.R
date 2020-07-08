library(shiny)
library(shinyjs)
library(plotwidgets)
library(berryFunctions)


return_right_text = function(col_code) {
  if(is.error(eval(parse(text = paste("hsl2col(matrix(t(c(",col_code, "))))"))), tell = FALSE, force = FALSE)) {
    "0, 0, 1"
  }else {
    col_code
  }
}

ui <- shinyUI(fluidPage(useShinyjs(),
                        textInput(inputId = "text", 
                                  label = "Wpisz kolor, np. niebieski: 240, 1, 0.5", 
                                  value = NULL),
                        verbatimTextOutput("value")))

server <- shinyServer(function(input, output) {
  
  observe({
    color_code <- return_right_text(input[["text"]])
    color = paste0("solid ", eval(parse(text = paste("hsl2col(matrix(t(c(",color_code, "))))"))))
    runjs(paste0("document.getElementById('text').style.border ='", color ,"'"))

  })
  output[["value"]] <- renderText({ input[["text"]] })
  
})

shinyApp(ui,server)
