# Carga el data set
data <- read.csv("BD_Altura_Alunos.csv", sep = ";")

# Realiza el histograma con la función hist(), nativa de R
str(data)
data
# Omitiendo valores nulos
data <- na.omit(data)

hist(data$Altura, 
  breaks = 12,
  main = " Histograma de alturas",
  ylab = "Frecuencia",
  xlab = "Altura", 
  col = "blue")

# Ahora realiza el histograma con la función ggplot
ggplot(data, aes(Altura)) + 
  geom_histogram(binwidth = 4, col="black", fill = "blue") + 
  ggtitle("Histograma de Mediciones") +
  ylab("Frecuencia") +
  xlab("Alturas") + 
  theme_light()

# Reflexiona sobre el ejercicio y saca tus conclusiones sobre cuál es el método que más te convence.