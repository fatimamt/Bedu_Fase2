# install.packages("lubridate")
library(dplyr)
library(lubridate)

# Importar datos
url <- "https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-06/Postwork/match.data.csv"
download.file(url = url, destfile = "match.data.csv", mode = "wb")
dt <- read.csv("match.data.csv")

str(dt)

# 1

# Agregando columna sumagoles
dt$sumagoles <- dt$home.score + dt$away.score

str(dt)


# 2

# Promedio por mes de goles
dt <- mutate(dt, date = as.Date(date, "%Y-%m-%d"))

goles.mes <- dt %>%
                group_by(año = year(date), mes =  month(date)) %>%
                    summarise(prom.goles.mes = mean(sumagoles))

goles.mes


# 3

# Serie de tiempo
goles.prom <- ts(goles.mes$prom.goles.mes,
                 start = c(goles.mes$año[1], goles.mes$mes[1]),
                 end = c(2019, 12), freq = 12)


# 4

# Gráfico de la serie de tiempo
plot(goles.prom, main = "Promedio de goles por mes hasta diciembre 2019",
     xlab = "Year",
     ylab = "Goles promedio")

ts.dec <- decompose(goles.prom)

plot(ts.dec)
