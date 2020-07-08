zamieniacz <- function(fun, helperID){
  if(is.character(fun)){
    fun <- as.expression(fun)
  }
  
  function(...){
    fun(...) %>% 
      helper(icon = "question",
             colour = "green",
             type = "markdown",
             content = helperID)
  }
}




# aplikacja
library(shiny)

ui <- fluidPage(
  zamieniacz(numericInput, "nr")("Podaj numer", value = 10),
  zamieniacz(plotOutput, "plt")("plt")
)

server <- function(input, output, session) {
  observe_helpers()
  
  output$plt <- renderPlot({
    plot(input$nr)
  })
}

shinyApp(ui, server)



# wszystkie funkcje
pakiety <- ls("package:shiny")
pakietyIO <- pakiety[pakiety %>% stringr::str_detect(pattern = "(Input)|(Output)")]

lapply(pakietyIO, zamieniacz)



