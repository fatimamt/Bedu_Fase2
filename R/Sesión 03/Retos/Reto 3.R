# Importación de datos
# Directorio ya establecido
datos <- read.csv('cbe.csv')
str(datos)

# Serie de tiempo mensual de producción de electricidad a partir del año 1958
elec <- ts(datos[, 3], start = 1958, frequency = 12)
str(elec)

# Descomposición multiplicativa
elecd <- decompose(elec, type = "multiplicative")

plot(elecd)

# Grafica de tendencia x estacionalidad superpuestas
tendency <- elecd$trend
seasonality <- elecd$seasonal

lines(tendency , col = "purple", lwd = 2)
lines(seasonality * tendency, col = "red", lty = 2, lwd = 2 )
legend(1958, 800,
       c('Serie de tiempo original', 'Tendencia', 'Tendencia x Estacionalidad'),
       col = c('black', 'purple', 'red'), text.col = "green4", lty = c(1, 1, 2), lwd = c(1, 2, 2),
       merge = TRUE, bg = 'gray90')
