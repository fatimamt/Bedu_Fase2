# install.packages("fbRanks")
library(dplyr)
library(fbRanks)

# 1

# 2017/2018
url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
download.file(url = url1, destfile = "2017-2018.csv", mode = "wb")
dt17.18 <- read.csv("2017-2018.csv")
dt17.18 <- select(dt17.18, date = Date, home.team = HomeTeam, home.score = FTHG,
                  away.team = AwayTeam, away.score =FTAG)

# 2018/2019
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
download.file(url = url2, destfile = "2018-2019.csv", mode = "wb")
dt18.19 <- read.csv("2018-2019.csv")
dt18.19 <- select(dt18.19, date = Date, home.team = HomeTeam, home.score = FTHG,
                  away.team = AwayTeam, away.score =FTAG)

# 2019/2020
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
download.file(url = url3, destfile = "2019-2020.csv", mode = "wb")
dt19.20 <- read.csv("2019-2020.csv")
dt19.20 <- select(dt19.20, date = Date, home.team = HomeTeam, home.score = FTHG,
                  away.team = AwayTeam, away.score =FTAG)

# Combinig data
fut <- rbind(dt17.18, dt18.19, dt19.20)

# Guardar archivo
write.csv(fut, file = "soccer.csv", row.names = F)


# 2

# Lista de fútbol
listasoccer <- create.fbRanks.dataframes(scores.file = "soccer.csv",
                                         date.format = "%d/%m/%y")

anotacionnes <- listasoccer$scores
equipos <- listasoccer$teams


# 3

# Fechas Únicas
fecha <- unique(listasoccer$scores$date)
n <- length(fecha)

# Ranking de equipos
ranking <- rank.teams(scores = anotacionnes, teams = equipos,
                      max.date = fecha[n-1], min.date = fecha[1])


# 4

# Estimar probabilidades
predict(ranking, date = fecha[n])
