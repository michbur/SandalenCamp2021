library(shiny)
library(ggplot2)

ttPlotOutput <- function(x) {
  tagList(plotOutput(x, hover = paste0(x, "_hover")),
          uiOutput(paste0(x, "_tooltip")))
}

ui <- fluidPage(title = "Let's do components",
                ttPlotOutput("iris_plot"),
                ttPlotOutput("cars_plot"),
                ttPlotOutput("chickwts_plot"))

server <- function(input, output) {
  
  output[["iris_plot"]] <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
      geom_point()
  })
  
  output[["cars_plot"]] <- renderPlot({
    ggplot(cars, aes(x=speed, y=dist)) + geom_point()
  })
  
  output[["chickwts_plot"]] <- renderPlot({
    ggplot(chickwts, aes(x=weight, y=feed)) + geom_point()
  })
  
  generate_tooltip <- function(df, hv){
    if(!is.null(hv)){
      
      if(nrow(df) != 0) { 
        tt_pos_adj <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 0.5,
                             "left", "right")
        
        tt_pos <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 0.5,
                         hv[["coords_css"]][["x"]], 
                         hv[["range"]][["right"]]/hv[["img_css_ratio"]][["x"]] - hv[["coords_css"]][["x"]])
        
        
        # style <- paste0("position:relative; z-index:1000; background-color: rgba(245, 245, 245, 1); pointer-events: none;",
        #                 tt_pos_adj, ":", tt_pos, 
        #                 "px; top:", hv[["coords_css"]][["y"]], "px; padding: 0px;")
        style <- paste0("display:block;
                        position:relative;
                        z-index:1000;
                        background-color: rgba(245, 245, 245, 1);
                        pointer-events: none;",
                        tt_pos_adj, ":", tt_pos, "px;
                        top:", hv[["coords_css"]][["y"]], "px;
                        padding: 0px;")
        
        div(
          class = paste0(hv$mapping$x, hv$mapping$y),
          style = style,
          p(HTML(paste0(colnames(df)," : " , df, collapse="<br>")))
        )
      }
    }
  }
  
  
  output[["iris_plot_tooltip"]] <- renderUI({generate_tooltip(nearPoints(iris, input[["iris_plot_hover"]], maxpoints = 1),
                                                              input[["iris_plot_hover"]])})  
  output[["cars_plot_tooltip"]] <- renderUI({generate_tooltip(nearPoints(cars, input[["cars_plot_hover"]], maxpoints = 1),
                                                              input[["cars_plot_hover"]])})  
  output[["chickwts_plot_tooltip"]] <- renderUI({generate_tooltip(nearPoints(chickwts, input[["chickwts_plot_hover"]], maxpoints = 1),
                                                              input[["chickwts_plot_hover"]])})  
  
  
}

shinyApp(ui, server)