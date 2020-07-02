set.seed(1410)
x <- factor(sample(letters[1L:4], 2000, replace = TRUE))

# Napisz: 
# - funkcję almost_summary(x), która wyświetla podsumowanie obiektu x 
# (ile elementów a, b, c, djest w obiekcie) 
# - funkcję almost_print(x, n = 10), która wyświetla pierwsze n 
# elementow z obiektu x

almost_print <- function(x, n = 10) 
  x[1L:min(length(x), n)]

almost_print(x, 5000)

class(x)

attr(x, "class")

attr(x, "levels")

levels(x)

attr(x, "class") <- "niemampojecia"

class(x)

print(x)

attr(x, "class") <- c("factor", "niemampojecia")

print(x)
class(x)

attr(x, "class") <- c("niemampojecia", "factor")
print(x)

attr(x, "class") <- "niemampojecia"

print.niemampojecia <- almost_print

print(x)

attr(x, "class") <- c("niemampojecia", "factor")
print(x)

debug(print.niemampojecia)
isdebugged(print.niemampojecia)
print(x)

print.niemampojecia <- function(x, n = 10) {
  class(x) <- "factor"
  x[1L:min(length(x), n)]
}

print(x)

attr(x, "class") <- c("niemampojeciatymbardziej", "factor")
y <- x
attr(y, "class") <- c("niemampojecia", "factor")
identical(x, y)
all(x == y)

class(x)
class(y)
x
y
print(x)
print(y)
