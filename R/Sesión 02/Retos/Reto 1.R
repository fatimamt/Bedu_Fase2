# Considere el siguiente vector

set.seed(134)
x <- round(rnorm(1000, 175, 6), 1)

# Calcule, la media, mediana y moda de los valores en x

mean(x)
median(x)
library(DescTools)
Mode(x)

# Obtenga los deciles de los números en x
quantile(x, seq(0.1,0.9, by = 0.1))

# Encuentre la rango intercuartílico, la desviación estándar y varianza muestral de las mediciones en x
IQR(x)
sd(x)
var(x)
