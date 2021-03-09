library(dplyr)

url1 <- "https://www.football-data.co.uk/mmz4281/1718/D1.csv"
url2 <- "https://www.football-data.co.uk/mmz4281/1819/D1.csv"
url3 <- "https://www.football-data.co.uk/mmz4281/1920/D1.csv"

download.file(url = url1, destfile = "SP1-reto3.1.csv", mode = "wb")
download.file(url = url2, destfile = "SP1-reto3.2.csv", mode = "wb")
download.file(url = url3, destfile = "SP1-reto3.3.csv", mode = "wb")

# Importe los archivos descargados a R

data17.18 <- read.csv("SP1-reto3.1.csv")
data18.19 <- read.csv("SP1-reto3.2.csv")
data19.20 <- read.csv("SP1-reto3.3.csv")

# 2
str(data17.18)
head(data18.19)
View(data19.20)
summary(data17.18)

# 3
Sdata17.18 <- select(data17.18, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
Sdata18.19 <- select(data18.19, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
Sdata19.20 <- select(data19.20, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

# 4
fut <- do.call(rbind, list(Sdata17.18, Sdata18.19, Sdata19.20))

str(fut)
View(fut)

fut <- mutate(fut, Date = as.Date(Date, "%d/%m/%y"))

str(fut)
View(fut)

# Guardando el dataset
write.csv(fut, file = 'fut.csv')
