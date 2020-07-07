1. Rozwinąć tooltip w aplikacji, aby pokazywał (oprócz gatunku) sepal length i petal length.
2. Napisać funkcję generate_tooltip, która przyjmuje dwa argumenty: hover i ramkę danych, a zwraca tooltip.

```r
output[["plot_tooltip"]] <- renderUI({generate_tooltip(df, hv))
```

Działającą funkcję umieść w aplikacji Shiny i za jej pomocą wygeneruj tooltip do dwóch nowych obrazków opartych na zbiorach chickwts, cars. Oba obrazki umieść na tej samej stronie w Shiny.

3. Napisać w Shiny nowy komponent ttPlotOutput, który będzie od razu generował plot z tooltipem.

```r
ui <- fluidPage(ttPlotOutput("iris_plot"))
```
