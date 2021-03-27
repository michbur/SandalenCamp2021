library(shiny)
library(shinyhelper)
library(shinyjs)

#create_help_files(files = c("Color"),
#                  help_dir = "helpfiles")

js_code <- 'shinyjs.background_color = function(params) {
            var defaultParams = {
            id : null,
            color : "white"
            };
            params = shinyjs.getParams(params, defaultParams);
            var el = $("#" + params.id);
            el.css("background-color", params.color);
            }'

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(text = js_code),
  titlePanel("Prosta apka"),
  sidebarPanel(
  helper(textInput("color",label = "Wybierz swój kolor!"),
         icon = "question-circle",
         colour = "blue",
         type = "markdown",
         buttonLabel = "Zakończ",
         content = "Color"),
  tags$div(class="header", checked=NA, tags$p("Pamiętaj, że zawsze możesz skorzystać z podpowiedzi klikając w znak zapytania ;)")),
  width = 5)
)

server <- function(input, output, session) {

  observe_helpers()
  
  observeEvent(input[["color"]], {
    color <- input[["color"]]
    if (color == "")  {
      js$background_color("color","#ffffff")
    } else {
      js$background_color("color", paste0("#", color))
    }
  })
  
}


shinyApp(ui = ui, server = server)


