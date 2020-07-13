library(shiny)
library(ggplot2)

generate_tooltip <- function(df, hv){
  
  if(!is.null(hv)) {
    
    tt_df <- nearPoints(df, hv, maxpoints = 1)

    if(nrow(tt_df) != 0) { 
      
      tt_pos_adj <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 5,
                           "left", "right")
      
      tt_pos <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 5,
                       hv[["coords_css"]][["x"]], 
                       hv[["range"]][["right"]]/hv[["img_css_ratio"]][["x"]] - hv[["coords_css"]][["x"]])
      
      #głupie rozwiązanie polegające na przesunięciu o 400, wtedy trzeba wpisać "top: tt_pos" w style
      tt_pos2 <- ifelse(hv[["domain"]][["bottom"]] < 0,
                       hv[["coords_css"]][["y"]], 
                       hv[["coords_css"]][["y"]]+400)
      
      ### rozwiązanie mądre polega na zmianie w przeglądarce pozycji i klasy naszych div
      
      style <- paste0("position:absolute; z-index:1000; background-color: rgba(245, 245, 245, 1); pointer-events: none;",
                      tt_pos_adj, ": ", tt_pos, 
                      "px;", "top : ", tt_pos2, "px; padding: 0px;")

      div(
        class = "tooltip_div",
        style = style,
        p(HTML(paste("<br/>", colnames(tt_df), ": ", t(tt_df))))
      )
    }
    
  }
}


ui <- fluidPage(title = "Let's do components",
                plotOutput("plot", hover = "plot_hover"),
                uiOutput("plot_tooltip"),
                plotOutput("plot_2", hover = "plot_hover_2"),
                uiOutput("plot_tooltip_2"))

server <- function(input, output) {

  df <- cars
  
  output[["plot"]] <- renderPlot({
    ggplot(df, aes(x = speed, y = dist)) +
      geom_point()
  })
  
  output[["plot_tooltip"]] <- renderUI({generate_tooltip(df, input[["plot_hover"]])})
  
  df2 <- chickwts
  
  output[["plot_2"]] <- renderPlot({
    ggplot(df2, aes(x = weight, y = feed)) +
      geom_point()
  })
  
  output[["plot_tooltip_2"]] <- renderUI({generate_tooltip(df2, input[["plot_hover_2"]])})
  
}

shinyApp(ui, server)