library(shiny)
library(ggplot2)

generate_tooltip = function(df, hv) {
  if(!is.null(hv)) {
    tt_df <- nearPoints(df, hv, maxpoints = 1)
    
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
        p(HTML(paste(colnames(tt_df), ": ", t(tt_df ), c(rep("<br/>", ncol(tt_df)-1), ""))))
      )
    }
  }
}


ttPlotOutput = function(plot) {
  tagList(plotOutput(plot, hover = paste0(plot, "_hover")),
          uiOutput(paste0(plot, "_tooltip")))
}


ui <- fluidPage(ttPlotOutput("plot"))



server <- function(input, output) {
  
  output[["plot"]] <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length , y = Petal.Length, col = Species)) +
      geom_point()
  })

  output[["plot_tooltip"]] <- renderUI({generate_tooltip(iris, input[["plot_hover"]])})
}

shinyApp(ui, server)




