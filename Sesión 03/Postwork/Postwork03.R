library(ggplot2)
library(hrbrthemes)

# Importar datos
fut <- read.csv("fut.csv")

fut <- fut[, c('FTHG', 'FTAG')]

str(fut)

# 1

# Frecuencias relativas como dataframe
th <- as.data.frame(table(fut$FTHG)) # host team
ta <- as.data.frame(table(fut$FTAG)) # away team
tha <- as.data.frame(table(fut)) # host and away teams para probabilidad conjunta

# Renombrando columnas
th <- rename(th, Goles = Var1)
ta <- rename(ta, Goles = Var1)

# No. total de partidos será el total de datos
partidos <- dim(fut)[1]

# Probabilidad marginal de que el equipo en casa anote x goles
for (i in 1:9){
  th$Prob[i] <- round(th$Freq[i]/partidos, 4)
}

# Probabilidad marginal de que el equipo visitante anote y goles
for (i in 1:7){
  ta$Prob[i] <- round(ta$Freq[i]/partidos, 4)
}

th; ta

# Probabilidad conjunta de que el equipo que juega en casa anote x goles
# y el equipo que juega como visitante anote y goles
for (i in 1:63){
  tha$Prob[i] <- round(tha$Freq[i]/partidos, 4)
}

tha

# 2

# Gráfico de barras para las probabilidades marginales

# Equipo en casa
th %>%
  ggplot() +
  aes(Goles, Prob, fill = Freq) +
  geom_bar(stat = "identity", position = position_dodge(), color = "black") +
  ggtitle("Probabilidad Marginal de que el equipo en casa anote x goles") +
  xlab("X Goles") +
  ylab("Probabilidad") +
  theme_light()

# Equipo visitante
ta %>%
  ggplot() +
  aes(Goles, Prob, fill = Freq) +
  geom_bar(stat = "identity", position = position_dodge(), color = "black") +
  ggtitle("Probabilidad Marginal de que el equipo visitanate anote y goles") +
  xlab("Y Goles") +
  ylab("Probabilidad") +
  theme_light()
  
# HeatMap para las probabilidades conjuntas
tha %>%
  ggplot() +
  aes(FTHG,FTAG, fill = Prob) +
  geom_tile() +
  scale_fill_viridis_c() +
  ggtitle("Probabilidad Conjunta de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.") +
  xlab("X Goles del equipo de casa") +
  ylab("Y Goles del equipo visitante")
