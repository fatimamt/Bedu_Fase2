# Descargue los archivos csv que corresponden a las temporadas
# 2017/2018, 2018/2019, 2019/2020 y 2020/2021 de la Bundesliga 1
# y que se encuentran en el siguiente enlace https://www.football-data.co.uk/germanym.php

url1 <- "https://www.football-data.co.uk/mmz4281/1718/D1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/D1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/D1.csv"
url4 <- "https://www.football-data.co.uk/mmz4281/2021/D1.csv"

download.file(url = url1, destfile = "SP1-reto3.1.csv", mode = "wb")
download.file(url = url2, destfile = "SP1-reto3.2.csv", mode = "wb")
download.file(url = url3, destfile = "SP1-reto3.3.csv", mode = "wb")
download.file(url = url4, destfile = "SP1-reto3.4.csv", mode = "wb")

# Importe los archivos descargados a R
data17.18 <- read.csv("SP1-reto3.1.csv")
data18.19 <- read.csv("SP1-reto3.2.csv")
data19.20 <- read.csv("SP1-reto3.3.csv")
data20.21 <- read.csv("SP1-reto3.4.csv")

# Usando la función select del paquete dplyr, seleccione únicamente las columnas:
  
# Date
# HomeTeam
# AwayTeam
# FTHG
# FTAG
# FTR

library(dplyr)

names(data17.18)

Sdata17.18 <- select(data17.18, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
Sdata18.19 <- select(data18.19, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
Sdata19.20 <- select(data19.20, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
Sdata20.21 <- select(data20.21, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
                 
# Combine cada uno de los data frames en un único data frame con ayuda de las funciones:
  
# rbind
# do.call

data <- do.call(rbind, list(Sdata17.18, Sdata18.19, Sdata19.20, Sdata20.21))

# Test
str(data)
head(data); tail(data)
