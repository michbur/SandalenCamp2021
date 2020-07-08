numericInput_h <- function(inputId, label, value, min = NA, max = NA, step = NA, width = NULL, helperID = NA){
  if(is.na(helperID)){
    helperID <- inputId
  }
  
  numericInput(inputId, label, value, min = NA, max = NA, step = NA, width = NULL) %>% 
    helper(icon = "question",
           colour = "green",
           type = "markdown",
           content = helperID)
}

plotOutput_h <- function(outputId, width = "100%", height = "400px", click = NULL,
                         dblclick = NULL, hover = NULL, hoverDelay = NULL,
                         hoverDelayType = NULL, brush = NULL, clickId = NULL,
                         hoverId = NULL, inline = FALSE, helperID = NA){
  
  if(is.na(helperID)){
    helperID <- outputId
  }
  
  plotOutput(outputId, width = "100%", height = "400px", click = NULL,
             dblclick = NULL, hover = NULL, hoverDelay = NULL,
             hoverDelayType = NULL, brush = NULL, clickId = NULL,
             hoverId = NULL, inline = FALSE) %>% 
    helper(icon = "question",
           colour = "green",
           type = "markdown",
           content = helperID)
}



#create_help_files(files = c("nr", "plt"), help_dir = "helpfiles")




# aplikacja
library(shiny)

ui <- fluidPage(
  numericInput_h("nr", "Podaj numer", value = 10),
  plotOutput_h("plt")
)

server <- function(input, output, session) {
  observe_helpers()
  
  output$plt <- renderPlot({
    plot(input$nr)
  })
}

shinyApp(ui, server)