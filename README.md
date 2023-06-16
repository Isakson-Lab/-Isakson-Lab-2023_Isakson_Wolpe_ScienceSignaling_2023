#Isakson-Lab_Wolpe_ScienceSignaling_2023
---
title: "Wolpe_ScienceSignaling_2023"
author: "Skylar Loeb"
date: "2023-06-15"
output: html_document
---
#Installing packages
```{r}
install.packages("BiocManager")
install.packages("Seurat")
install.packages("dplyr")
install.packages("rlang")
install.packages("colorspace")
install.packages("tidyverse")
install.packages("gridExtra")
install.packages("ggplot2")
install.packages("enrichR")
install.packages("scales")
install.packages("ggrepel")
install.packages("viridis")
install.packages("gplots")
install.packages("ComplexHeatmap")
```
#Loading packages
```{r}
library(BiocManager)
library(dplyr)
library(tidyverse)
library(gridExtra)
library(Seurat)
library(ggplot2)
library(enrichR)
library(scales)
library(ggrepel)
library(viridis)
library(gplots)
library(ComplexHeatmap)
```
#Subsetting data from the population of interest (endothelial cells from subjects with BMI ranges 20-30 or 30-40)
```{r}
#Reading the data file
AdiposeVACs <- readRDS(file = "human_vascular.rds")
#Creating a subset containing only vascular endothelial cells (ECs)
Idents(AdiposeVACs) <- "cell_type"
hEndo <- subset(AdiposeVACs, idents = c("hEndoA1", "hEndoA2", "hEndoS1", "hEndoS2", "hEndoS3", "hEndoV"))
#Creating a subset of vascular ECs that come from subjects with BMIs between 20-30 and 30-40
Idents(hEndo) <- "bmi.range"
BMI_ECs <- subset(hEndo, idents = c("20-30", "30-40"))
```
#PANX3 expression in human vascular ECs (BMI ranges: 20-30, 30-40)
```{r}
DotPlot(BMI_ECs, features = "PANX3", group.by = "bmi.range", col.max = 30) +
labs(title="White Adipose Tissue Endothelium") +
  scale_y_discrete(limits = c("30-40", "20-30")) +
    ylab(label = "BMI") +
  theme(plot.title = element_text(hjust = 0.25, size = 10),
        text = element_text(size = 8),
        axis.text.x = element_text(size = 7, angle = 0, hjust = 0.5),
        axis.text.y = element_text(size = 7),
        axis.title.x = element_text(color = "white"),
        axis.title.y = element_text(color = "black"),
        legend.text = element_text(size = 7),
        legend.key.height = unit(.1, "in"),
        legend.key.width = unit(.2, "in")) +
        guides(size= guide_legend(title = "Percent Expressed", order = 1), color = guide_colorbar(title="Average Expression", order=2)) +
        scale_color_viridis()
```
#BCL6 expression in human vascular ECs (BMI ranges: 20-30, 30-40)
```{r}
DotPlot(BMI_ECs, features = "BCL6", group.by = "bmi.range", col.max = 30) +
labs(title="White Adipose Tissue Endothelium") +
  scale_y_discrete(limits = c("30-40", "20-30")) +
    ylab(label = "BMI") +
  theme(plot.title = element_text(hjust = 0.25, size = 10),
        text = element_text(size = 8),
        axis.text.x = element_text(size = 7, angle = 0, hjust = 0.5),
        axis.text.y = element_text(size = 7),
        axis.title.x = element_text(color = "white"),
        axis.title.y = element_text(color = "black"),
        legend.text = element_text(size = 7),
        legend.key.height = unit(.1, "in"),
        legend.key.width = unit(.2, "in")) +
        guides(size= guide_legend(title = "Percent Expressed", order = 1), color = guide_colorbar(title="Average Expression", order=2)) +
        scale_color_viridis()
```
#NOX1/2/4/5 expression in human vascular ECs (BMI ranges: 20-30, 30-40)
```{r}
DotPlot(BMI_ECs, features = c("NOX1", "CYBB", "NOX4", "NOX5"), group.by = "bmi.range", col.max = 30) +
labs(title="White Adipose Tissue Endothelium") +
  scale_y_discrete(limits = c("30-40", "20-30")) +
    ylab(label = "BMI") +
  theme(plot.title = element_text(hjust = 0.25, size = 10),
        text = element_text(size = 8),
        axis.text.x = element_text(size = 7, angle = 0, hjust = 0.5),
        axis.text.y = element_text(size = 7),
        axis.title.x = element_text(color = "white"),
        axis.title.y = element_text(color = "black"),
        legend.text = element_text(size = 7),
        legend.key.height = unit(.1, "in"),
        legend.key.width = unit(.2, "in")) +
        guides(size= guide_legend(title = "Percent Expressed", order = 1), color = guide_colorbar(title="Average Expression", order=2)) +
        scale_color_viridis()
```

