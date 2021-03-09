library(ggplot2)

# Distribución binomial

# Consideremos un experimento binomial con n = 35 pruebas idénticas e
# independientes, en donde la probabilidad de éxito en cada prueba es p = 0.51.
# Encuentre lo siguiente:
  
# La probabilidad de observar exactamente 10 éxitos
dbinom(x = 10, size = 35, prob = 0.51)

# La probabilidad de observar 10 o más exitos
pbinom(q = 9, size = 35, prob = 0.51, lower.tail = FALSE)

# El cuantil de orden 0.5
qbinom(p = 0.5, size = 35, prob = 0.51)

# Genere una muestra aleatoria de tamaño 1000 de esta distribución, construya una
# tabla de frecuencias relativas con los resultados y realice el gráfico de barras
# de los resultados que muestre las frecuencias relativas.
set.seed(4857)
ma <- rbinom(n = 1000, size = 35, prob = 0.51)
madf <- as.data.frame(table(ma)/length(ma))
tail(madf)

p <- ggplot(madf, aes(x = ma, y = Freq)) + geom_bar (stat="identity")
p

# Distribución normal

# Considere una variable aleatoria normal con media 110 y desviación estándar 7.
# Realice lo siguiente:
  
# Grafique la función de densidad de probabilidad
x <- seq(80, 140, 0.1)
y <- dnorm(x = x, mean = 110, sd = 7)
data <- data.frame(x, y)
tail(data)
p <- ggplot(data, aes(x, y)) + geom_line()
p

# Encuentre la probabilidad de que la v.a. sea mayor o igual a 140
pnorm(140, mean = 110, sd = 7, lower.tail = FALSE)

# Encuentre el cuantil de orden 0.95
qnorm(0.95, mean = 110, sd = 7)

# Genere una muestra aleatoria de tamaño 1000 y realice el histograma de frecuencias
# relativas para esta muestra
set.seed(19)
ma <- rnorm(1000, mean = 110, sd = 7) 
madf <- as.data.frame(ma)
tail(madf)

p <- ggplot(madf, aes(ma)) + 
  geom_histogram(colour = 'red', 
                 fill = 'blue',
                 alpha = 0.8, # Intensidad del color fill
                 binwidth = 3.5) + 
  geom_density(aes(y = 3.5*..count..))+
  geom_vline(xintercept = mean(ma), 
             linetype="dashed", color = "black") + 
  ggtitle('Histograma para la muestra normal') + 
  labs(x = 'Valores obtenidos', y = 'Frecuencia')+
  theme_dark() +
  theme(plot.title = element_text(hjust = 0.5, size = 16))
p
