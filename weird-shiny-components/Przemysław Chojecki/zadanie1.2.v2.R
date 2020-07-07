source(file.path(getwd(), "zadanie1.2.v2_funkcje.R"))


ui <- fluidPage(title = "Let's do components",
                ttPlotOutput("chickwts"),
                ttPlotOutput("cars"))#,
                #theme = CSS_kod)

server <- function(input, output) {
  
  output[["df_plot_chickwts"]] <- renderPlot({
    ggplot(chickwts, aes(x = weight, y = weight, color = feed)) +
      geom_point()
  })
  
  output[["df_plot_tooltip_chickwts"]] <- renderUI({ generete_tooltip(chickwts, input[["df_plot_hover_chickwts"]], "kurczaki") })
  
  
  output[["df_plot_cars"]] <- renderPlot({
    ggplot(cars, aes(x = speed, y = dist)) +
      geom_point()
  })
  
  output[["df_plot_tooltip_cars"]] <- renderUI({ generete_tooltip(cars, input[["df_plot_hover_cars"]], "samochody") })
  
}

shinyApp(ui, server)