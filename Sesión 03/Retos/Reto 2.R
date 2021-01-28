# Importar el data set
players <- read.csv("players_stats.csv")
View(players)
library(ggplot2)

# Histograma de los minuntos totales (MIN) de los jugadores

# Media de minutos por jugador
mplay <-mean(players$MIN)

# Opción 1
players %>%
  ggplot() +
  aes(MIN) +
  geom_histogram(binwidth = 90, col="black", fill = "blue") +
  ggtitle("Histograma de Minutos por jugador", paste("Media=", mplay)) +
  ylab("Frecuencia") +
  xlab("Minutos") +
  geom_vline(aes(xintercept = mplay, color="Mean"),
             linetype="dashed",
             size=1)

# Opción 2
ggplot(players, aes(MIN))+ 
  geom_histogram(binwidth = 90, col="black", fill = "blue") + 
  ggtitle("Histograma de Minutos por jugador", paste("Media=", mplay)) +
  geom_vline(aes(xintercept = mplay, color="Mean"),
             linetype="dashed",
             size=1) +
  ggtitle("Histograma de Minutos") +
  ylab("Frecuencia") +
  xlab("Minutos") + 
  theme_light()

# Generar un histograma de edad (Age) y agregar una línea con la media
players <- na.omit(players) 

# Media de edad entre jugadores
mage <- mean(players$Age)

# Opción 1
players %>%
  ggplot() +
  aes(Age) +
  geom_histogram(binwidth = 5, col="black", fill = "green") +
  ggtitle("Histograma de Edades entre jugadores", paste("Media=", mage)) +
  ylab("Frecuencia") +
  xlab("Edades") +
  geom_vline(aes(xintercept = mage, color="Mean"),
             linetype="dashed",
             size=1)

# Opción 2
ggplot(players, aes(Age))+ 
  geom_histogram(binwidth = 5, col="black", fill = "green") + 
  ggtitle("Histograma de Edades entre jugadores", paste("Media=", mage)) +
  geom_vline(aes(xintercept = mage, color="Mean"),
             linetype="dashed",
             size=1) +
  ggtitle("Histograma de Edades entre jugadores") +
  ylab("Frecuencia") +
  xlab("Edades") + 
  theme_light()

# Hacer un scatterplot de las variables Weight y Height y observar la correlacón
# que existe entre ambas variables (1 sola gráfica)
players %>%
  ggplot() +
  aes(Weight, Height) +
  geom_point() + 
  geom_smooth(method = "lm", se = T) +
  ylab("Height") +
  xlab("Weight") + 
  theme_light()

# Jugador más alto
tallest <- which.max(players$Height)

paste("El jugador más alto es:", players$Name[tallest], "con una altura de:", players$Height[tallest]/100, "m")

# Jugador más bajito
smallest <- which.min(players$Height)

paste("El jugador más bajito es:", players$Name[smallest], "con una altura de:", players$Height[smallest]/100, "m")

# Altura promedio
mheight <- mean(players$Height)

paste("La altura promedio es:", round(mheight, 2)/100, "m")

# Generar un scatterplot de Asistencias totales (AST.TOV) vs Puntos (PTS) por posiciones
players %>%
  ggplot() + 
  aes(AST.TOV, PTS, col = Pos) +
  geom_point() +
  labs(x = "Asistencias totales", y = "Puntos", colour = "Posición") +
  facet_wrap("Pos")
