# Reto 1

# leyendo el fichero desde el repositorio

netflix <-read.csv("https://raw.githubusercontent.com/ecoronadoj/Sesion_1/main/Data/netflix_titles.csv")

# dimensi?n del data frame
dim(netflix)

# Tipo de objeto
class(netflix)

# titulos que se estrenaron despues del 2015 
names(netflix)
net.2015 <- netflix[netflix$release_year > 2015, ]

# escritura del archivo
write.csv(net.2015, "res.netflix.csv")
titles <- net.2015$title
write.csv(titles, "titles2015.txt")