# Identifying Differentially Expressed Genes, Methylation Sites and Interfering RNAs in Human Genome in relation to pathologies : Application on Multiple Sclerosis Patients 

# The Project aim:
Creat an R  script that perform a full genomic, transcriptomic and methylation study  and filter the target gene specific data .

Several researche  have proved that the genomic, transcriptomic and the methylation profils are affected with environmental factors, which creat different prevalence area around the world,

# Different prevalence:

To solve the problem of different prevalence that can be correlated with different genomic, transcriptomic and epigenomic profiles; 
In this study, we will use data from each prevalence area.


# Workflow
![workflow](https://user-images.githubusercontent.com/73958439/163676806-83611165-1435-47a1-822c-82b354d1ad5b.jpg)


# Result 

The genetic specific data will be automatically exported in the  working directory folder as 4 txt files:

- The gene expression profile : p value and LogFC

- If the gene is : overexpressed , underexpressed or not differentially expressed.

- List of the  CpG sites that are methylated in the gene specific promoter with supplementary data mainly the B value , DMR (differential methylation or not ), and  the relation to Cpg island

- List of miRNAs that target the gene in healthy condition

- Are these miRNA expressed in disease group or not ( the user need to search for each miRNA separately ).

# Case study
In order to validate the tool developed in this work, we applied the analysis to STAT3 gene which is implicated in the pathology of MS. 

in order to identify methylated regions and miRNAs susceptible to interact with this gene.

The case study result are availbul in the manuscript.

# Suplementary data

All processed not filtered data are provided as supplementary files , so the user can define different settings.
Option 1 : Change the p value to define  Differencially expressed genes  ( the p value used is <0.05)
Option 2 : In the case study we used cpg that exist in the promoter region.
Supplementary files are provided for "gene associated cpgs " and "non gene asssociated cpgs"

More information are available in : Reproducibility guide.pdf part 1

# Workflow reproducibility

The work flow could be reproduced for other pathologies data available on GEO database.
More information are available in : Reproducibility guide.pdf part 2


# Contact for data update 
Tech leader : Hiba Ben Aribi
email : benaribi.hiba@gmail.com


## Team 
Guerbouj Souheila,Phd in Genetics and molecular biology ,UTM

Hiba Ben Aribi, Master in Neuroscience and Biotechnology , UTM

Farah Ayadi, Master in molecular biology ,UTM

Careen Naitore,Master in Bioinformatics and molecular biology, JKUAT



