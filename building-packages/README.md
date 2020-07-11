1. Stwórz szkielet swojego pakietu i dodaj do niego funkcję, 
która pozwala wyliczyć średnią z każdego wektora należącego do listy x.
Zadbaj o to, zeby stworzyc dla pakietu nowy projekt RStudio.
2. Napisz dokumentację do swojego pakietu.
3. Stwórz dla swojego pakietu plik README.md.
4. Stwórz dla swojego pakietu repozytorium na githubie.
5. Używając testthat (np. poprzez usethis::use_testthat()) 
napisz testy jednostkowe do swojej funkcji.
6. Dodaj do swojego pakietu CI za pomocą usethis::use_github_actions().
Pamiętaj, że travis wymaga utworzenia konta i nadania pewnych uprawnień.
7. Dodaj do readme badge za pomocą usethis::use_github_actions_badge().
8. Dodaj do swojego pakietu badanie pokrycia kodu testami za pomocą usethis::use_coverage()
9. Dodaj sprawdzanie pisowni za pomocą usethis::use_spell_check() (pamiętaj o instalacji
pakietu spelling.
10. Dodaj ręcznie automatyczne budowanie pkgdown do pakietu: https://github.com/r-lib/actions/blob/master/examples/pkgdown.yaml
11. Dodaj vignette (.Rmd) do pakietu.