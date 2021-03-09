# Ejemplo 6. Lectura de JSON y XML

# Para comenzar necesimos instalar los paquetes `rjson`, y `XML`, por ejemplo, utilizando la función
# install.packages. Una vez que hemos instalado los paquetes, podemos cargarlos en `R` mediante la instrucción
install.packages("rjson")
install.packages("XML")
library(rjson)
library(XML)

#### Lectura de JSON

# Podemos leer un archivo json de la siguiente manera

URL1 <- "https://tools.learningcontainer.com/sample-json-file.json" 
#URL1 <- "http://www.ipab.org.mx/ipab/datosabiertos?od=02-21"
JsonData <- fromJSON(file = URL1)
class(JsonData)
length(JsonData)
str(JsonData)

#### Lectura de XML

URL2 <- "http://www-db.deis.unibo.it/courses/TW/DOCS/w3schools/xml/cd_catalog.xml"
#URL2 <- "http://www.ipab.org.mx/ipab/datosabiertos?od=03-21"
xmlfile <- xmlTreeParse(URL2) # Parse the XML file. Analizando el XML
topxml <- xmlSApply(xmlfile, function(x) xmlSApply(x, xmlValue)) # Mostrando los datos de una forma amigable
xml_df <- data.frame(t(topxml), row.names= NULL) # Colocandolos en un Data Frame
str(xml_df) # Observar la naturaleza de las variables del DF
head(xml_df)


# Más fácil

url3 <- URL2 # cargue el URL del XML
data_df <- xmlToDataFrame(url3)
head(data_df)

# https://datos.gob.mx/busca/dataset/saldo-de-bonos-de-proteccion-al-ahorro-bpas



# --------- EJEMPLO 7 ---------



# Ejemplo 7. Funciones `na.omit` y `complete.cases`

# Ahora vamos a considerar el conjunto de datos `airquality`, observamos primero
# algunas de sus filas

head(airquality)
library(dplyr)

# El tipo de objeto que es y el tipo de variables que contiene

str(airquality)

# observamos la dimensión

dim(airquality)

# Con la función `complete.cases` podemos averiguar cuales son aquellas filas
# que no contienen ningún valor perdido (NA) y cuales son aquellas filas
# que tienen al menos un valor perdido.

bien <- complete.cases(airquality)

# La variable bien, es un vector lógico con `TRUE` en las posiciones que 
# representan filas de `airquality` en donde no hay NA's y con `FALSE`
# en las posiciones que representan aquellas filas de `airquality` en donde
# se encontraron NA's

# Por tanto, podemos contar el número de filas en donde no hay NA´s de la 
# siguiente manera

sum(bien)

# Podemos filtrar aquellas filas sin NA's de la siguiente manera

airquality[bien,]

data <- select(airquality, Ozone:Temp)
apply(data, 2, mean)
apply(data, 2, mean, na.rm = T)

# `na.omit` devuelve el objeto con casos incompletos eliminados

(m1 <- apply(na.omit(data), 2, mean))

b <- complete.cases(data)

(m2 <- apply(data[b,], 2, mean))

identical(m1, m2)
