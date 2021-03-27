library(shiny)

ui <- fluidPage(sliderInput("input_slider1", "Select the number of sliders:", min=1, max=10, value=5, step=1),
                  uiOutput("sliders"))
  
server <- function(input, output, session) {

    rv <- reactiveValues(number_of_sliders = NULL)
    
    observeEvent(input[["input_slider1"]], {
      rv[["number_of_sliders"]] <- input[["input_slider1"]] - 1
    })
      
    output[["sliders"]] <- renderUI({
      if(rv[["number_of_sliders"]] >= 1){
        lapply(1L:rv[["number_of_sliders"]], function(ith_slider) {
          sliderInput(paste0("input_slider", ith_slider+1), paste0("Slider ", ith_slider+1) , min = 1, max = 10, value = 1, step = 1)
        })
      }
      })
    
    observeEvent(input[["input_slider1"]], {
      if(rv[["number_of_sliders"]] >= 1){
      lapply(1L:rv[["number_of_sliders"]], function(ith_slider) {
      updateSliderInput(session, paste0("input_slider", ith_slider+1), max = input[["input_slider1"]])})}
  })
}    
    
shinyApp(ui, server)