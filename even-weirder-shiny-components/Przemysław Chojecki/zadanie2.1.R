library(shiny)
library(shinyhelper) # devtools::install_github("cwthom/shinyhelper")

ui <- fluidPage(
  helper(textInput("dupa", "Podaj cokolwiek:"),
         icon = "question",
         colour = "green",
         type = "markdown",
         content = "Columns")
)

server <- function(input, output, session) {
  observe_helpers()
}

shinyApp(ui, server)

# shinyhelper_demo()

#create_help_files(files = c("Columns"), help_dir = "helpfiles")
