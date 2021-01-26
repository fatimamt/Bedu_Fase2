# Considere el data frame mtcars de R y utilice las funciones:
  
str(mtcars)
summary(mtcars)
head(mtcars)
View(mtcars)

# para observar las características del objeto y tener una mayor comprensión de este.

# Crea una función que calcule la mediana de un conjunto de valores, sin utilizar
# la función median
function.median <- function(valores) {
  valores <- sort(valores, decreasing = F)
  mediana <- 0
  if (length(valores) %% 2 == 0) {
    i <- length(valores) / 2
    mediana <- (valores[i] + valores[i+1]) / 2
  }
  else{
    i <- ceiling(length(valores) / 2)
    mediana <- valores[i]
  }
  returnValue(mediana)
}

# Par
function.median(c(5000, 4000, 3500, 50000))
# Impar
function.median(c(5000, 4000, 3500, 50000, 100))
