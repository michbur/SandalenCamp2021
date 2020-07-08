library(shiny)
library(shinycssloaders)
library(shinyhelper)
library(ggplot2)


create_h = function() {
  fun_Output = ls("package:shiny")[sapply(ls("package:shiny"), function(i) {
    grepl("Output", i, fixed = TRUE)
  })]
  
  for(fun in fun_Output) {
    eval(parse(text = paste0(fun, "_h <- function(outputId, ...) {helper(",
                            fun, "(outputId, ...), content = outputId)}")))
  }
}

