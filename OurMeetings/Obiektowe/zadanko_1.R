set.seed(1410)
x <- factor(sample(letters[1L:4], 2000, replace = TRUE))

# Napisz: 
# - funkcję almost_summary(x), która wyświetla podsumowanie obiektu x 
# (ile elementów a, b, c, d jest w obiekcie) 
# - funkcję almost_print(x, n = 10), która wyświetla pierwsze n 
# elementow z obiektu x

almost_summmary <- function(x){
  
  # table(x)
  
  elem <- sort(unique(x))
  sum <- numeric(length(elem))
  
  for(i in 1:length(elem)){
    for(x_i in x){
      if(x_i == elem[i]){
        sum[i] = sum[i] + 1
      }
    }
  }
  results <- data.frame(value = elem, sum = sum)
  results
  
}


almost_print <- function(x, n = 10){
  
  x[1:n]
  
}