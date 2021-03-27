library(shiny)
library(ggplot2)

create_helper_fun <- function(fun){
  
  # ta funkcja tworzy plik helpera oraz funkcję z helperem dla naszej funkcji
  
  if(is.character(fun)){
    name <- fun
    fun <- get(fun)
  }else{
    name <- deparse(substitute(fun)) 
  }

  if(!file.exists(paste0(getwd(),"/helpfiles/",name,".md"))){
    create_help_files(files = c(name), help_dir = "helpfiles")
  }
  
  
  function(id, ...){
    helper(fun(id, ...),
           icon = "question-circle",
           colour = "blue",
           type = "markdown",
           content = name)
  }
  
}

output_function_with_helper <- function(){
  
  # ta funkcja tworzy nowe funkcje z helperem dla funkcji z pakietu shiny typu Output
  # tworzy plik .md oraz funkcję _h
  
  # znalezienie wszystkich funkcji shiny typu Output
  output_function <- ls("package:shiny")[stri_detect_fixed(ls("package:shiny"), 'Output')]
  # stworzenie nazw z _h
  name_with_h <- sapply(output_function, function(name){paste0(name, "_h")})
  # stworzenie funkcji helpera
  fun_h <- lapply(output_function, create_helper_fun)
  # przypisanie funkcji do nazw
  for(i in 1:length(fun_h)){
    x <- fun_h[[i]]
    assign(as.character(name_with_h[i]), x, envir = .GlobalEnv)
  }
  
}

output_function_with_helper()

ui <- fluidPage(plotOutput_h("iris_plot", hover = "iris_plot_hover"),
                uiOutput_h("iris_plot_tooltip"),
                textOutput_h("info"),
                numericInput("n_points", label = "Number of points", value = 15),
                plotOutput_h("simple_plot", height = "350px"),
                textInput("txt", "Enter the text to display below:", "Your text"),
                verbatimTextOutput_h("verb"))

server <- function(input, output) {
  
  observe_helpers()
  
  output[["text"]] <- renderText({ input[["txt"]] })
  
  output[["verb"]] <- renderText({ input[["txt"]] })
  
  output[["iris_plot"]] <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
      geom_point()
  })
  
  output[["iris_plot_tooltip"]] <- renderUI({
    
    if(!is.null(input[["iris_plot_hover"]])) {
      
      hv <- input[["iris_plot_hover"]]
      
      tt_df <- nearPoints(iris, hv, maxpoints = 1)
      
      if(nrow(tt_df) != 0) { 
        
        tt_pos_adj <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 5,
                             "left", "right")
        
        tt_pos <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 5,
                         hv[["coords_css"]][["x"]], 
                         hv[["range"]][["right"]]/hv[["img_css_ratio"]][["x"]] - hv[["coords_css"]][["x"]])
        
        style <- paste0("position:absolute; z-index:1000; background-color: rgba(245, 245, 245, 1); pointer-events: none;",
                        tt_pos_adj, ": ", tt_pos, 
                        "px;", "top : ", hv[["coords_css"]][["y"]]-400, "px; padding: 0px;")
        
        div(
          style = style,
          p(HTML(paste0(" Species: ", tt_df[["Species"]], "<br/> Sepal lenght: ", tt_df[["Sepal.Length"]],
                        "<br/> Petal lenght: ", tt_df[["Petal.Length"]])))
        )
      }
    }})
  
  output[["info"]] <- renderText({ "Select:" })
  
  output[["simple_plot"]] <- renderPlot({
    
    plot(1L:input[["n_points"]], type = "b")
    
  })
}

shinyApp(ui = ui, server = server)