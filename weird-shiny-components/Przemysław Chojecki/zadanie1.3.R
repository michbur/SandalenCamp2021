source(file.path(getwd(), "zadanie1.3_funkcje.R"))


ui <- fluidPage(title = "Let's do components",
                ttPlotOutput("dupa"))

server <- function(input, output) {
  
  output[["df_plot_dupa"]] <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
      geom_point()
  })
  
  output[["df_plot_tooltip_dupa"]] <- renderUI({ generete_tooltip(iris, input[["df_plot_hover_dupa"]]) })
  
}

shinyApp(ui, server)