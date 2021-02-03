install.packages("mongolite")
library(mongolite)

# 1

# Conexión a la base de datos
dt <- mongo(
  collection = "match",
  db = "match_games",
  url = "mongodb+srv://fatimamt:<password>@cluster0.yxzwq.mongodb.net/test",
  verbose = F,
)


# 2

# Número de registros
(no.registros <- dt$count())


# 3

# No. de goles que metió el Real Madrid el 20 de diciembre de 2015
goals.RM <- dt$find(query = {"Date": "2015-12-20"}) # Error in "Date":"2015-12-20" : Argumento NA/NaN

# Se podria hacer alguna predicción con Series de Tiempo, regresió o clasificación
# y como ya se ha realizado alguna para el Postwork de la sesión 5,
# hice el intento de cargar la predicción en la base de datos
# pero desafortunadamente desconozco el formato y proceso que usa la función
# predict() ya que, sí pude acceder al data frame donde se almacenan los equipos
# junto con los scores, etc. pero al pasarlo a Data Frame, solo se guardan 3 datos.

# Me temo que por el tiempo no pude lograrlo pero en definitiva voy a seguir
# investigando para buscar la solución.

# Desconexión de la base de datos
dt$disconnect(gc = TRUE)
rm(dt)
