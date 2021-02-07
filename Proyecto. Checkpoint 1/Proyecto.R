# BEDU - DATA ANALYSIS (SANTANDER) 
# Módulo 2: Programación y estadística con R

# Equipo 8
# Miriam Mayela Alcocer Anaya
# Ana Silvia Escalante
# Fatima Martínez Torres
# Yael Isaac Ramírez Méndez

# Paquetería a usar
library(dplyr)
library(e1071)
library(ggplot2)
library(caTools)

# Importación del data set ya filtrado con columnas necesarias
dataCovid <- read.csv(file = "owid-covid-data.csv")

# Filtración para obtener registros de países que ya tengan vacunas
dataCovidFilter <- dataCovid %>% filter(total_vaccinations > 0)
dataCovidFilter <- dataCovidFilter %>% filter(location != "World")

# Date format
dataCovidFilter$date = as.Date(dataCovidFilter$date, format = "%d/%m/%Y")

# Visualización de todos los países
jpeg(filename = "vacunados_mundo.jpg", width = 1300, height = 730, quality = 100, res = 125)

dataCovidFilter %>%
  group_by(location) %>%
  ggplot(aes(x=date, y=people_vaccinated, color=location)) +
  geom_line(size=1) + 
  geom_point(size=1.5) + 
  xlab("Fecha") +
  ylab("Personas vacunadas") +
  ggtitle("Cantidad de personas vacunadas por país")

dev.off()

jpeg(filename = "casosnuevos_paises.jpg", width = 1300, height = 730, quality = 100, res = 125)

dataCovidFilter %>%
  group_by(location, date) %>%
  ggplot(aes(x=date, y=new_cases, color=location)) +
  geom_line(size=1) + 
  geom_point(size=1.5) +
  xlab("Fecha") +
  ylab("Casos Nuevos") +
  ggtitle("Cantidad de casos positivos nuevos diarios por país")

dev.off()

# Ordenación de datos para obtener el TOP 10 de países con más personas vacunadas
orderedDataCovid <- dataCovidFilter[order(dataCovidFilter$people_vaccinated, decreasing = TRUE),]
dataCovidUnique <- orderedDataCovid[match(unique(orderedDataCovid$location), orderedDataCovid$location),]
#orderedDataCovid <- dataCovidUnique[order(dataCovidUnique$people_vaccinated, decreasing = TRUE),]
topDataCovidUnique <- dataCovidUnique[1:10,]
topDataCovid <- dataCovidFilter %>% filter(location %in% topDataCovidUnique$location)

# Visualización de los datos del TOP 10 de países

jpeg(filename = "vacunados_top.jpg", width = 1300, height = 730, quality = 100, res = 125)

topDataCovid %>%
  group_by(location) %>%
  ggplot(aes(x=date, y=people_vaccinated, color=location)) +
  geom_line(size=1) + 
  geom_point(size=1.5) +
  xlab("Fecha") +
  ylab("Personas vacunadas") +
  ggtitle("Cantidad de personas vacunadas por país en el TOP 10")

dev.off()

jpeg(filename = "casosnuevos_top.jpg", width = 1300, height = 730, quality = 100, res = 125)

topDataCovid %>%
  group_by(location, date) %>%
  ggplot(aes(x=date, y=new_cases, color=location)) +
  geom_line(size=1) + 
  geom_point(size=1.5) +
  xlab("Fecha") +
  ylab("Casos Nuevos") +
  ggtitle("Cantidad de casos positivos nuevos diarios por país en el TOP 10")

dev.off()

# Porcentaje poblacional
dataCovidFilter$porcentaje_vacunado <- dataCovidFilter$people_vaccinated * 100/dataCovidFilter$population

# Visualización de todos los países

jpeg(filename = "vacunados_porcentaje_mundo.jpg", width = 1300, height = 730, quality = 100, res = 125)

dataCovidFilter %>%
  group_by(location) %>%
  ggplot(aes(x=date, y=porcentaje_vacunado, color=location)) +
  geom_line(size=1) + 
  geom_point(size=1.5) + 
  xlab("Fecha") +
  ylab("Personas vacunadas") +
  ggtitle("Porcentaje de personas vacunadas por país")

dev.off()

# Ordenación de datos para obtener el TOP 10 de países con mayor porcentaje de personas vacunadas
orderedDataCovidPorcentaje <- dataCovidFilter[order(dataCovidFilter$porcentaje_vacunado, decreasing = TRUE),]
dataCovidUniquePorcentaje <- orderedDataCovidPorcentaje[match(unique(orderedDataCovidPorcentaje$location), orderedDataCovidPorcentaje$location),]
#orderedDataCovid <- dataCovidUnique[order(dataCovidUnique$people_vaccinated, decreasing = TRUE),]
topDataCovidUniquePorcentaje <- dataCovidUniquePorcentaje[1:10,]
topDataCovidPorcentaje <- dataCovidFilter %>% filter(location %in% topDataCovidUniquePorcentaje$location)

# Visualización de los datos del TOP 10 de países

jpeg(filename = "vacunados_porcentaje_top.jpg", width = 1300, height = 730, quality = 100, res = 125)

topDataCovidPorcentaje %>%
  group_by(location) %>%
  ggplot(aes(x=date, y=porcentaje_vacunado, color=location)) +
  geom_line(size=1) + 
  geom_point(size=1.5) +
  xlab("Fecha") +
  ylab("Porcentaje de personas vacunadas") +
  ggtitle("Porcentaje de personas vacunadas por país en el TOP 10")

dev.off()



# --------Análisis de Correlación--------

# Omitir NA's
S_topDataCovid <- na.omit(topDataCovid)
write.csv(S_topDataCovid, file = "topDataCovid.csv")
attach(S_topDataCovid)

# Primera prueba de correlación entre la cantidad de personas vacunadas y los casos positivos nuevos por día
correlacion <- cor(people_vaccinated, new_cases)

# Prueba con un modelo de regresión lineal
modelo <- lm(new_cases ~ people_vaccinated)
summary(modelo) # p-value importante, pero R^2 mínima

# Visualización

jpeg(filename = "casosnuevos_vacunados_top.jpg", width = 1300, height = 730, quality = 100, res = 125)

S_topDataCovid %>%
  ggplot() +
  aes(people_vaccinated, new_cases) +
  geom_point() +
  xlab("Personas vacunadas") +
  ylab("Nuevos casos") +
  ggtitle("Comportamiento de casos positivos nuevos VS cantidad de personas vacunadas - Países TOP 10")

dev.off()

# Prueba de modelo de regresión con Vectores de Soporte (SVR)

# Dividir a datos de entrenamiento y de prueba a un 70%
split <- sample.split(S_topDataCovid$new_cases, SplitRatio = 0.7)
nltrain <- subset(S_topDataCovid, split == TRUE) # entrenamiento
nltest <- subset(S_topDataCovid, split == FALSE) # prueba

# Modelo de SVM en su tipo en reresión
set.seed(1234)
regresor_svr <- svm(new_cases ~ people_vaccinated, data = nltrain, type = "eps-regression")

# --------ENTRENAMIENTO--------

# Predicciones sobre el conjunto de entrenamiento
newcases_svr_predict <- predict(regresor_svr, nltrain)

# Prueba de correlación
cor(nltrain$new_cases, newcases_svr_predict)
summary(regresor_svr)

# Visualización

jpeg(filename = "svm_top_entrenamiento.jpg", width = 1300, height = 730, quality = 100, res = 125)

nltrain %>%
  ggplot() +
  geom_point(aes(people_vaccinated, new_cases), color = "darkblue") +
  geom_line(aes(x = people_vaccinated, y = newcases_svr_predict), color = "red") +
  xlab("Personas Vacunadas") + 
  ylab("Casos Nuevos") + 
  ggtitle("Curva de Ajuste sobre Conjunto de Entrenamiento (nltrain) - Países TOP 10")

dev.off()

# --------PRUEBA--------

# Predicciones sobre el conjunto de prueba
newcases_svr_test_predict <- predict(regresor_svr, nltest)

# Prueba de correlación
cor(nltest$new_cases, newcases_svr_test_predict)

# Visualización

jpeg(filename = "svm_top_prueba.jpg", width = 1300, height = 730, quality = 100, res = 125)

nltest %>%
  ggplot() +
  geom_point(aes(people_vaccinated, new_cases), color = "darkblue") +
  geom_line(aes(x = people_vaccinated, y = newcases_svr_test_predict),
            color = "red") +
  xlab("Personas Vacunadas") + 
  ylab("Casos Nuevos") + 
  ggtitle("Curva de Ajuste sobre Conjunto de Prueba (nltest) - Países TOP 10")

dev.off()



str(dataCovidFilter)

# Datos de todos los países para comprobar algún aumento de correlación posible

# --------Análisis de Correlación--------

# Omitir NA's
S_dataCovidFilter <- na.omit(dataCovidFilter)
# write.csv(S_dataCovidFilter, file = "topDataCovid.csv")
attach(S_dataCovidFilter)

# Primera prueba de correlación entre la cantidad de personas vacunadas y los casos positivos nuevos por día
correlacion2 <- cor(people_vaccinated, new_cases)

# Prueba con un modelo de regresión lineal
modelo2 <- lm(new_cases ~ people_vaccinated)
summary(modelo) # p-value importante, pero R^2 mínima

# Visualización

jpeg(filename = "casosnuevos_vacunados_mundo.jpg", width = 1300, height = 730, quality = 100, res = 125)

S_dataCovidFilter %>%
  ggplot() +
  aes(people_vaccinated, new_cases) +
  geom_point() +
  xlab("Personas vacunadas") +
  ylab("Nuevos casos") +
  ggtitle("Comportamiento de casos positivos nuevos VS cantidad de personas vacunadas - Mundo")

dev.off()

# Prueba de modelo de regresión con Vectores de Soporte (SVR)

# Dividir a datos de entrenamiento y de prueba a un 70%
split2 <- sample.split(S_dataCovidFilter$new_cases, SplitRatio = 0.7)
nltrain2 <- subset(S_dataCovidFilter, split == TRUE) # entrenamiento
nltest2 <- subset(S_dataCovidFilter, split == FALSE) # prueba

# Modelo de SVM en su tipo en reresión
set.seed(1234)
regresor_svr2 <- svm(new_cases ~ people_vaccinated, data = nltrain2, type = "eps-regression")

# --------ENTRENAMIENTO--------

# Predicciones sobre el conjunto de entrenamiento
newcases_svr_predict2 <- predict(regresor_svr2, nltrain2)

# Prueba de correlación
cor(nltrain2$new_cases, newcases_svr_predict2)
summary(regresor_svr2)

# Visualización

jpeg(filename = "svm_entrenamiento_mundo.jpg", width = 1300, height = 730, quality = 100, res = 125)

nltrain2 %>%
  ggplot() +
  geom_point(aes(people_vaccinated, new_cases), color = "darkblue") +
  geom_line(aes(x = people_vaccinated, y = newcases_svr_predict2), color = "red") +
  xlab("Personas Vacunadas") + 
  ylab("Casos Nuevos") + 
  ggtitle("Curva de Ajuste sobre Conjunto de Entrenamiento (nltrain) - Mundo")

dev.off()

# --------PRUEBA--------

# Predicciones sobre el conjunto de prueba
newcases_svr_test_predict2 <- predict(regresor_svr2, nltest2)

# Prueba de correlación
cor(nltest2$new_cases, newcases_svr_test_predict2)

# Visualización

jpeg(filename = "svm_prueba_mundo.jpg", width = 1300, height = 730, quality = 100, res = 125)

nltest2 %>%
  ggplot() +
  geom_point(aes(people_vaccinated, new_cases), color = "darkblue") +
  geom_line(aes(x = people_vaccinated, y = newcases_svr_test_predict2),
            color = "red") +
  xlab("Personas Vacunadas") + 
  ylab("Casos Nuevos") + 
  ggtitle("Curva de Ajuste sobre Conjunto de Entrenamiento (nltest) - Mundo")

dev.off()
