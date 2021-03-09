th <- read.csv('x.csv')
ta <- read.csv('y.csv')
tha <- read.csv('tha.csv')

install.packages('tidyverse')
install.packages('caret')

library(tidyverse)
library(caret)
library(dplyr)
library(ggplot2)

th <- th[,-1]
ta <- ta[,-1]
tha <- tha[,-1]

str(th)

# 1
# Tabla de cocientes
prob.h <- 0
prob.a <- 1
cocientes <- c(1:42)

for (i in 1:42){
  prob.h <- th$Prob[tha$FTHG[i] + 1]
  prob.a <- ta$Prob[tha$FTAG[i] + 1]
  
  cocientes[i] <- tha$Prob[i]/(prob.h * prob.a)
}

tabla <- data.frame(cocientes)

# 2

bootstrap <- replicate(n = 7000, sample(cocientes, replace = T))

media <- apply(bootstrap, MARGIN = 2, FUN = mean)

mc <- mean(cocientes)

ggplot() + geom_histogram(aes(x = media)) + geom_vline(xintercept = mc)

sqrt(sum((media-0.8801)^2)/ncol(bootstrap))

filter(as.(bootstrap), as.vector(bootstrap) == 0.8801)
str(bootstrap)
