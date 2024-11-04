# Metadatos del Dataset de Caquexia

## Origen del Dataset
Este dataset fue obtenido como parte de un estudio sobre el diagnóstico de caquexia en pacientes con cáncer mediante perfiles metabolómicos urinarios.

## Descripción General
Cada muestra en el dataset representa a un paciente. Las filas contienen las observaciones de cada paciente, mientras que las columnas corresponden a las concentraciones de diferentes metabolitos en orina.

## Variables Principales
- **Muscle.loss**: Clasificación de los pacientes en dos grupos:
  - `cachexic`: Pacientes con pérdida muscular (caquexia).
  - `control`: Pacientes sin pérdida muscular.
  
- **Metabolitos**: Incluye concentraciones de 63 metabolitos diferentes, tales como:
  - `Alanine`: Concentración de alanina.
  - `Glucose`: Concentración de glucosa.
  - `Creatinine`: Concentración de creatinina.
  - Otros aminoácidos y compuestos metabólicos.

## Objetivo del Dataset
El dataset está destinado al análisis de patrones de metabolitos asociados con la pérdida muscular en pacientes con cáncer. Este análisis permite investigar los perfiles de metabolitos que se asocian a la caquexia, con el fin de desarrollar herramientas diagnósticas no invasivas.

## Preprocesamiento Realizado
- Los datos fueron transpuestos y escalados antes de aplicar el Análisis de Componentes Principales (PCA).

## Notas Adicionales
Este dataset forma parte de un estudio de aprendizaje automático que explora la relación entre metabolitos y la pérdida muscular en pacientes con cáncer.