library(shiny)
library(ggplot2)
library(magrittr)
library(purrr)

generete_tooltip <- function(df, hv, klasa = NULL){
  if(!is.null(hv)) {
    tt_df <- nearPoints(df, hv, maxpoints = 1)
    
    if(nrow(tt_df) != 0) { 
      tt_pos_adj <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 0.5,
                           "left", "right")
      
      tt_pos <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 0.5,
                       hv[["coords_css"]][["x"]], 
                       hv[["range"]][["right"]]/hv[["img_css_ratio"]][["x"]] - hv[["coords_css"]][["x"]])
      
      
      # position:absolute powoduje, że jak masz 2 wykresy, to jeden z tool-tip będzie w
        # złym miejscu. Aby było dobrze to będzie position:relative.
      # Możnaby też nadać klasę <div>'owi w którym siedzi tool-tip i zmienić jego pozycję w CSS
      style <- paste0("position:relative.; z-index:1000; background-color:rgba(245, 245, 245, 1); pointer-events:none;",
                      tt_pos_adj, ":", tt_pos, 
                      "px; top:", hv[["coords_css"]][["y"]], "px; padding: 0px;")
      
      
      # generowanie napisu do wyświetlenia
      tmp <- tt_df %>% sapply(as.character)
      
      names_tmp <- names(tmp)
      names(tmp) <- NULL
      
      # połączenie informacjii w jeden napis
      html_text <- (map2(list(names_tmp), list(tmp),
                         ~paste0("<br/> ", .x, ": ", .y)))[[1]] %>%
        paste(collapse = " ")
      
      html_text <- substr(html_text, 7, nchar(html_text)) # pozbycie się pierwszego przejścia do nowej linii
      
      div(
        class = klasa, # tu można ustawić klasę i po niej zmieniać CSS, ale uwaga!
                          # CSS można nadać do fluidPage w argumencie theme, ale musi to być bootstrap CSS
                          # próbowałem to teraz zrobić, ale się nie udało :(((((
        style = style,
        p(HTML(html_text))
      )
    }
  }
}

ttPlotOutput<- function(x){
  list(plotOutput(paste("df_plot", x, sep="_"), click = paste("df_plot_hover", x, sep="_")),
       uiOutput(paste("df_plot_tooltip", x, sep="_")))
}


CSS_kod <- "
samochody{
  bottom: 400;
  border: 3px solid #73AD21;
}
"













