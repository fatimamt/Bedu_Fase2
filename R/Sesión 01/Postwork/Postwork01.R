# 1. Importación de datos
# With the Working Directory already setted
data <- read.csv('SP1.csv')

# 2. Extraer las columnas FTHG y FTAG
dt <- data[, c('FTHG', 'FTAG')]
head(dt)

# 3.
?table

# PROBABILIDADES MARGINALES
# Frecuencias relativas como vector para posterior presentación como dataframe
th <- as.vector(table(dt$FTHG)) # host team
ta <- as.vector(table(dt$FTAG)) # away team

# Sabiendo el resultado de la función table, defino la cantidad de goles posibles
x <- data.frame(Goals = 0:6, Freq = th)
y <- data.frame(Goals = 0:5, Freq = ta)

# No. total de partidos será el total de datos
partidos <- dim(dt)[1]

# Probabilidad de que el equipo en casa anote x goles
for (i in 1:7){
  x$Prob[i] <- round(x$Freq[i]/partidos, 4)
}

# Probabilidad de que el equipo visitante anote y goles
for (i in 1:6){
  y$Prob[i] <- round(y$Freq[i]/partidos, 4)
}

x; y

# PROBABILIDADES CONJUNTAS
# Frecuencias relativas como data frame
tha <- as.data.frame(table(dt))

# Probabilidad de que el equipo que juega en casa anote x goles
# y el equipo que juega como visitante anote y goles
for (i in 1:42){
  tha$Prob[i] <- round(tha$Freq[i]/partidos, 4)
}

tha

write.csv(x, file = 'x.csv')
write.csv(y, file = 'y.csv')
write.csv(tha, file = 'tha.csv')
