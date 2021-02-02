# Importación del data set
dt <- read.csv("datoslineal.csv", header = TRUE)

attach(dt)

# 1. Gráfico de dispersión
plot(x, y, xlab = 'x', ylab = 'y')

# 2. Modelo de regresión lineal simple

# Correlación
cor(dt)

# Modelo de regresión lineal simple
m2 <- lm(y~x)

# Linea ajustada
abline(lsfit(x, y))

# Resumen del modelo ajustado
summary(m2)

# 3. Gráficas de diagnóstico

# Gráfico
plot(m2)

# Análisis de Varianza
anova(m2)
