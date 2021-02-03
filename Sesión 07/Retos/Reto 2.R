library(rvest)

# Extraer tabla de HTML
url <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(url)

tables <- html_nodes(file, "table")
table1 <- html_table(tables[1], fill = TRUE)

# Quitar NA's
salarios <- na.omit(as.data.frame(table1))
class(salarios)

# Quitar caracteres no necesarios en Sueldo
salarios$Sueldo <- gsub("\\D", "", salarios$Sueldo)

# Columna tipo numérico
salarios$Sueldo <- as.numeric(salarios$Sueldo)
str(salarios)

# ¿Cuál es la empresa que más paga y la que menos paga?

# Opción 1
salarios <- arrange(salarios, Sueldo)

paste("La empresa que más paga es:", salarios$Cargo[20], "con $",  salarios$Sueldo[20])
paste("La empresa que menos paga es:", salarios$Cargo[1], "con $",  salarios$Sueldo[1])

# Opción 2
Smax <- which.max(salarios$Sueldo)
Smin <- which.min(salarios$Sueldo)

paste("La empresa que más paga es:", salarios$Cargo[Smax], "con $",  salarios$Sueldo[Smax])
paste("La empresa que menos paga es:", salarios$Cargo[Smin], "con $",  salarios$Sueldo[Smin])
