library(shiny)
library(ggplot2)
library(magrittr)
library(purrr)

generete_tooltip <- function(df, hv){
  if(!is.null(hv)) {
    tt_df <- nearPoints(df, hv, maxpoints = 1)
    
    if(nrow(tt_df) != 0) { 
      
      tt_pos_adj <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 0.5,
                           "left", "right")
      
      tt_pos <- ifelse(hv[["coords_img"]][["x"]]/hv[["range"]][["right"]] < 0.5,
                       hv[["coords_css"]][["x"]], 
                       hv[["range"]][["right"]]/hv[["img_css_ratio"]][["x"]] - hv[["coords_css"]][["x"]])
      
      
      style <- paste0("position:absolute; z-index:1000; background-color:rgba(245, 245, 245, 1); pointer-events:none;",
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
        style = style,
        p(HTML(html_text))
      )
    }
  }
}
