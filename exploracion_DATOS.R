# Cargar las librerías necesarias
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("SummarizedExperiment")

library(SummarizedExperiment)
library(ggplot2)
library(pheatmap)

# Cargar los datos desde archivo CSV
file_ruta <-"C:/Users/Hp/OneDrive/Documentos/Máster en Bioinformática/Asignaturas/III Semestre/Análisis de datos ómicos/PEC 1/metaboData-main/metaboData-main/Datasets/2024-Cachexia/human_cachexia.csv"
cachexia_data <- read.csv(file_ruta, row.names = 1)

# Separación de los datos de metabolitos y los metadatos
metabolite_data <- cachexia_data[, -1]  # Excluir la columna "Muscle.loss"
muscle_info <- data.frame(MuscleLoss = cachexia_data$Muscle.loss)

# Transponer la matriz para que los metabolitos estén en filas y las muestras en columnas
metabolite_data <- t(metabolite_data)

# Crear el objeto SummarizedExperiment
metab_contenedor <- SummarizedExperiment(assays = list(counts = metabolite_data), 
                                         colData = muscle_info)
# Guardar el objeto en formato .Rda
save(metab_contenedor, file = "contenedor.Rda")

# Exploración de los datos
head(metab_contenedor)
apply(assay(metab_contenedor), 1, summary)

# Comprobar valores ausentes
sum(is.na(assay(metab_contenedor)))

# Visualización de datos: Boxplot para cada metabolito
boxplot(t(assay(metab_contenedor)), main = "Distribución de Metabolitos", 
        xlab = "Metabolitos", ylab = "Concentración", outline = FALSE, las = 2)

# Visualización de datos: Heatmap de los metabolitos
pheatmap(assay(metab_contenedor), scale = "row", main = "Heatmap de Metabolitos en Muestras", 
         cluster_rows = TRUE, cluster_cols = TRUE)

# Crear anotación de diagnóstico para el heatmap
annotation_col <- data.frame(MuscleLoss = colData(metab_contenedor)$MuscleLoss)
rownames(annotation_col) <- colnames(assay(metab_contenedor))

# Generar el heatmap con anotación de MuscleLoss
pheatmap(assay(metab_contenedor), scale = "row", main = "Heatmap de Metabolitos Dividido por Diagnóstico", 
         cluster_rows = TRUE, cluster_cols = TRUE, annotation_col = annotation_col)

# Reducción de dimensionalidad con PCA
metabolite_matrix <- t(assay(metab_contenedor))  # Muestras en filas
scaled_data <- scale(metabolite_matrix)  # Escalar los datos
pca_result <- prcomp(scaled_data, center = TRUE, scale. = TRUE)
summary(pca_result)

# Visualización del PCA
pca_df <- as.data.frame(pca_result$x)
pca_df$MuscleLoss <- colData(metab_contenedor)$MuscleLoss
ggplot(pca_df, aes(x = PC1, y = PC2, color = MuscleLoss)) +
  geom_point(size = 3) +
  labs(title = "PCA de Datos de Caquexia", x = "Componente Principal 1", y = "Componente Principal 2") +
  theme_minimal()

# Análisis estadístico de PC1 entre grupos
t.test(pca_result$x[, "PC1"] ~ colData(metab_contenedor)$MuscleLoss)
manova_result <- manova(pca_result$x[, 1:5] ~ colData(metab_contenedor)$MuscleLoss)
summary(manova_result)

# Determinar los metabolitos que más contribuyen a PC1
loadings <- pca_result$rotation
loadings_PC1 <- loadings[, "PC1"]
loadings_PC1_sorted <- sort(loadings_PC1, decreasing = TRUE)
top_metabolites_PC1 <- names(loadings_PC1_sorted)[1:30]  # Los 30 metabolitos con mayor carga en PC1

# Visualización de las cargas de los metabolitos en PC1
barplot(loadings_PC1_sorted[1:30], las = 2, main = "Metabolitos con Mayor Carga en PC1", 
        ylab = "Carga", xlab = "Metabolitos")
