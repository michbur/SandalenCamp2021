library(stringi)
library(shinyhelper)
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
    assign(as.character(name_with_h[i]), x)
  }
  
}

ui <- fluidPage(
  plotOutput_h("plot")
)

server <- function(input, output, session) {
  
  observe_helpers()
  
  output[["plot"]] <- renderPlot({
    ggplot(cars, aes(x = speed, y = dist)) +
      geom_point()
  })
}

shinyApp(ui, server)

