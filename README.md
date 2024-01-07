# The EMImR R package for Transcriptomic and Epigenomic Changes Identification

## Installation
The package could be installed in R studio using this command :

devtools::install_github("omicscodeathon/emimr/emimr_package")

library(emimr)


## Package workflow
![workflow](https://user-images.githubusercontent.com/73958439/174091995-b8f8dc44-c54f-4d68-b17a-3f6f25da2d99.png)

## Functions
The package main function is to identify theintersection between genetic and epigenetic modififcations, inclusing :

* The differentially expressed genes (DEGs), differentially methylated genes (DMGs) and genes associated to differentially expressed interfering miRNA (GDEImRs).
  
* The intersection between the three datasets. The common genes between each two datasets are then determined. 

* Calculates the genes number in all the categories from the  “emimr” function result.
  
* filters target genes data.
