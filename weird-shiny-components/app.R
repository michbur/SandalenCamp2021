library(shiny)
library(ggplot2)

ttPlotOutput <- function(x) {
  tagList(plotOutput(x, hover = paste0(x, "_hover")),
          uiOutput(paste0(x, "_tooltip")))
}


ui <- fluidPage(title = "Let's do components",
                ttPlotOutput("iris_plot"))

server <- function(input, output) {
  
  output[["iris_plot"]] <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
      geom_point()
  })
  
  output[["iris_plot_tooltip"]] <- renderUI({
    
    if(!is.null(input[["iris_plot_hover"]])) {
      hv <- input[["iris_plot_hover"]]
      
      tt_df <- nearPoints(iris, hv, maxpoints = 1)
      
      if(nrow(tt_df) != 0) { 
        
        tt_pos_adj <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 0.5,
                             "left", "right")
        
        tt_pos <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 0.5,
                         hv[["coords_css"]][["x"]], 
                         hv[["range"]][["right"]]/hv[["img_css_ratio"]][["x"]] - hv[["coords_css"]][["x"]])
        
        
        style <- paste0("position:absolute; z-index:1000; background-color: rgba(245, 245, 245, 1); pointer-events: none;",
                        tt_pos_adj, ":", tt_pos, 
                        "px; top:", hv[["coords_css"]][["y"]], "px; padding: 0px;")
        
        div(
          style = style,
          p(HTML(paste0("<br/> Species: ", tt_df[["Species"]])))
        )
      }
    }
  })
  
}

shinyApp(ui, server)