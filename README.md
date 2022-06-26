# Transcriptomic and Epigenomic Changes in  Autoimmune Demyelinating Diseases: A Bioinformatics Analysis

# STEP 1: EMImR package creation
To download the package :
devtools::install_github("omicscodeathon/ms_epigenomics/EMImR_package")
library(EMImR)

Import also the following packages:
library(dplyr) 
library(openxlsx)
library(rlang)


# Pipeline workflow
![workflow](https://user-images.githubusercontent.com/73958439/174091995-b8f8dc44-c54f-4d68-b17a-3f6f25da2d99.png)


# STEP2 : Pipeline validation
# The study aim:
The developed package was used to study Transcriptomic and Epigenomic Changes in  Autoimmune Demyelinating Diseases: MS and SLE.

After analysing the gene expression , cpg methylation in the promoter region, and interfering miRNAs data; the EMImR package was used to determine:
- DEGs
- DMGs
- genes associated to DEmR (GDEIRs)
- the intersections to determine which DEGs are the result of cpgs methylation and which are affected by interfering miRNAs.
Each disease data were studied seperatly , then we compared the two diseases data.
The study result are published in the following article: Transcriptomic and Epigenomic Changes in  Autoimmune Demyelinating Diseases: A Bioinformatics Analysis.
# Contact for data update 
Hiba Ben Aribi : benaribi.hiba@gmail.com

## Team  Members
Hiba Ben Aribi, Master in Neuroscience and Biotechnology , UTM.

Careen Naitore,Master in Bioinformatics and molecular biology, JKUAT.

Guerbouj Souheila,Phd in Genetics and molecular biology ,UTM.

Farah Ayadi, Master in molecular biology ,UTM.
