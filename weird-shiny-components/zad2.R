library(shiny)
library(ggplot2)
library(shinyjs)

generate_tooltip = function(df, hv, class = 1) {
  if(!is.null(hv)) {
    tt_df <- nearPoints(df, hv, maxpoints = 1)
    
    if(nrow(tt_df) != 0) { 
      
      tt_pos_adj <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 0.5,
                           "left", "right")
      
      tt_pos <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 0.5,
                       hv[["coords_css"]][["x"]], 
                       hv[["range"]][["right"]]/hv[["img_css_ratio"]][["x"]] - hv[["coords_css"]][["x"]])
      
      
      style <- paste0("display:block; position:fixed; cursor: pointer; overflow:hidden;  z-index:1000; background-color: 
                      rgba(245, 245, 245, 1); pointer-events: none;",
                      tt_pos_adj, ":", tt_pos, 
                      "px; top:", hv[["coords_css"]][["y"]] + class*400, "px; padding: 0px;")
      
      div(
        style = style,
        p(HTML(paste(colnames(tt_df), ": ", t(tt_df ), c(rep("<br/>", ncol(tt_df)-1), ""))))
      )
    }
  }
}

ui <- fluidPage(title = "Let's do components",
                plotOutput("cars_plot", 
                           hover = "cars_plot_hover"),
                uiOutput("cars_plot_tooltip"), 
                plotOutput("chicken_plot", 
                           hover = "chicken_plot_hover"),
                uiOutput("chicken_plot_tooltip"),
                inlineCSS("
              .tt {
                position: relative;
              }")
)


server <- function(input, output) {
  
  output[["cars_plot"]] <- renderPlot({
    ggplot(cars, aes(x = speed , y = dist)) +
      geom_point()
  })
  
  output[["chicken_plot"]] <- renderPlot({
    ggplot(chickwts, aes(x = weight, y = feed)) +
      geom_point()
  })
  output[["cars_plot_tooltip"]] <- renderUI({generate_tooltip(cars, input[["cars_plot_hover"]], 0)})
  output[["chicken_plot_tooltip"]] <- renderUI({generate_tooltip(chickwts, input[["chicken_plot_hover"]], 1)})
}

shinyApp(ui, server)




