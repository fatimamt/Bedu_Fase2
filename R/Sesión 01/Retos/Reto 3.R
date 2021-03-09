# Reto 2

# generando vector de 44 entradas aleatorio

ran <- rnorm(44)

# creando el loop que eleva al cubo y suma 12 a cada posici?n 
vec <- vector()
for (i in 1:15) {
  vec[i] <- (ran[i]^3) + 12
}

# Se almacenan los valores en un data frame
df.al <- data.frame(ran = ran[1:15], 
                    resultado = vec)
df.al

# pseudoc?digo 

# ran <- {se genera el vetor con rnorm de 44 entradas}
# 
# vec <- {se inicializa un vector donde se almacenará el resultado}
# 
# for (contador desde 1 hasta 15 ){
#   vec[contador] <- operación aritmética
# }