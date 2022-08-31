# Project : Transcriptomic and Epigenomic Changes in  Autoimmune Demyelinating Diseases: A Bioinformatics Analysis

## The EMImR package 
The package could be installed in R studio using this command :

devtools::install_github("omicscodeathon/emimr/EMImR_package")

library(EMImR).


## Requirement
The package requires 3 external packages : “dplyr” , “rlang” and “openxlsx”.

library(dplyr)

library(openxlsx)

library(rlang)


## Package workflow
![workflow](https://user-images.githubusercontent.com/73958439/174091995-b8f8dc44-c54f-4d68-b17a-3f6f25da2d99.png)

## Functions
The package consists of 3 functions: the “emimr” function, the “emimr_count” function, and the “GSDF” function. 

* The “emimr” function identifies differentially expressed genes (DEGs), differentially methylated genes (DMGs) and genes associated to differentially expressed interfering miRNA (GDEImRs) then performs the intersection between the three datasets. The common genes between each two datasets are then determined. 

* The “emimr_count” function calculates the genes number in all the categories from the  “emimr” function result.  The function is dependent on the “emimr” function.

To perform the analysis the user needs to define the three data frames to be used.

Genes_table <- emimr(expression = dataframe1, methylation = dataframe2, miRNA = dataframe3)
Counts <- emimr_count(emimr_result = genes_table)

* The “GSDF” function filters the specific data for a target_gene. This function is independent from the  “emimr” function. 

gene_data <- GSDF(expression = dataframe1, methylation = dataframe2, miRNA = dataframe3, target_gene = “gene symbol”)


=> Results will be summarized in a dataframe that will be automatically exported, as an excel file, in the working directory.


## Case study : Transcriptomic and Epigenomic Changes in  Autoimmune Demyelinating Diseases: MS and SLE.

After analysing the gene expression , cpg methylation in the promoter region, and interfering miRNAs data; the EMImR package was used to determine:
  - DEGs
  
  - DMGs
  
  - Genes associated to DEmR (GDEIRs)
  
  - The intersections to determine which DEGs are the result of cpgs methylation and which are affected by interfering miRNAs.

Each disease data were studied seperatly , then we compared the two diseases data.


## Contact for data update 
Hiba Ben Aribi : benaribi.hiba@gmail.com

## Acknowledgements
This project was performed during the October 2022 Omics codeathon organized in collaboration with the African Society for Bioinformatics and Computational Biology (ASBCB). The authors thank the National Institutes of Health (NIH) Office of Data Science Strategy (ODSS) and the National Center for Biotechnology Information (NCBI) for their immense support before and during the codeathon.


## Team  Members
Hiba Ben Aribi, Master in Neuroscience and Biotechnology , UTM.

Careen Naitore,Master in Bioinformatics and molecular biology, JKUAT.

Guerbouj Souheila,Phd in Genetics and molecular biology ,UTM.

Farah Ayadi, Master in molecular biology ,UTM.

Olaitan I. Awe, University of Ibadan, Oyo State, Nigeria. African Society for Bioinformatics and Computational Biology, South Africa.
