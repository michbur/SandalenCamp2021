library(shiny)

ui <- fluidPage(verbatimTextOutput("slider_debug"),
                uiOutput("sliders"))

server <- function(input, output, session) {
  
  rv <- reactiveValues(number_of_sliders = 1)
  
  observeEvent(input[["input_slider1"]], {
    if(is.null(input[["input_slider1"]])) {
      number_of_sliders <- 1
    } else {
      number_of_sliders <- input[["input_slider1"]]
    }
    
    rv[["number_of_sliders"]] <- number_of_sliders
  })
  
  
  output[["sliders"]] <- renderUI({
    lapply(1L:rv[["number_of_sliders"]], function(ith_slider) {
      sliderInput(inputId = paste0("input_slider", ith_slider),
                  label = "Select the number of sliders", 
                  min = 1, max = 10, value = ifelse(ith_slider == 1, 
                                                    rv[["number_of_sliders"]],
                                                    1), 
                  step = 1)
    })
  })
  
  output[["slider_debug"]] <- renderPrint({
    rv[["number_of_sliders"]]
  })

  
}

# Napisz aplikację, która robi to same z wykorzystaniem funkcji 
# updateSliderInput(). Powodzonka!

shinyApp(ui, server)
