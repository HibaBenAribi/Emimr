##### Run line  3:7
# set directory
setwd("C:/Users/LENOVO/Desktop/Script")
#cal libraries 
library(survival)
library(tidyverse)
library(readxl)
#to analyze the gene data for all the prevalence area change the gene symbol to your target gene symbol, select all and run the code 


# High prevalence data ----------------------------------------------------

#up_gene mean over_expressed genes
#down_gene mean _ genes
#select and Run lines

down_gene <- read_csv("down_exp_high.csv")
up_gene  <- read_csv("up_exp_high.csv")

#Filter gene of interest // replace "APOOL" by the gene symbol
#select and Run lines

x <- any(up_gene =="XRCC4") 
y <-  any(down_gene =="XRCC4") 
if (x==TRUE){
  exp_high <- "The gene is overexpressed"
} else if (y==TRUE) {
  exp_high <-"the gene is underexpressed"
} else {
  exp_high <-"The gene is not differencially expressed"
}
exp_high

#export the result
#run line  to download the result
write.table(exp_high,"expression_profile_high.txt")

#methylation profile study
#replace the "XRCC4"by your gene symbole and Run
promoter_methylation_high <- read_excel("promoter_methylation_high.xlsx")
cpg_met <- promoter_methylation_high %>%
  filter(gene =="XRCC4")
#result
cpg_met
#export result
write.table( cpg_met , "cpg_methylation_high.txt" , row.names=F , sep = ",")

#microRNA data
#replace the "UXS1"by your gene symbol and Run
miRNA_high <- read.csv("miRNA_high.csv")
miRNA <- miRNA_high %>%
  filter(gene =="UXS1")
miRNA
#export result
write.table( miRNA , "miRNA_high.txt" , row.names=F , sep = ",")

# medium to high prevalence ----------------------------------------------------------

#up_gene mean over_expressed genes
#down_gene mean under_expressed genes
#select and Run line 16 and line 17

down_gene2 <- read_csv("down_exp_medium_to_high.csv")
up_gene2  <- read_csv("up_exp_medium_to_high.csv")

#Filter gene of interest // replace "APOOL" by the gene symbol
#select and Run line 22:31

z <- any(up_gene2 =="HDAC4") 
t <-  any(down_gene2 =="HDAC4") 
if (z==TRUE){
  exp_medium_to_high <- "The gene is overexpressed"
} else if (t==TRUE) {
  exp_medium_to_high <-"the gene is underexpressed"
} else {
  exp_medium_to_high <-"The gene is not differencially expressed"
}
exp_medium_to_high

#export the result
#run line 34 to download the result
write.table(exp_medium_to_high,"expression_profile_medium_to_high.txt")

#methylation profile study
#replace the "HDAC4"by your gene symbol and Run lines
promoter_methylation_medium_to_high<- read_excel("promoter_methylation_medium_to_high.xlsx")
cpg_met2 <- promoter_methylation_medium_to_high %>%
  filter(gene =="HDAC4")
#result
cpg_met2
#export result
write.table( cpg_met2 , "cpg_methylation_medium_to_high.txt" , row.names=F , sep = ",")

#microRNA data
#replace the "UXS1"by your gene symbol and Run
miRNA_medium_to_high <- read.csv("miRNA_medium_to_high.csv")
miRNA2 <- miRNA_medium_to_high %>%
  filter(gene =="UXS1")
miRNA2
#export result
write.table( miRNA2 , "miRNA_medium_to_high.txt" , row.names=F , sep = ",")

# Medium prevalence -------------------------------------------------------


#up_gene mean over_expressed genes
#down_gene mean under_expressed genes
#select and Run line 16 and line 17

down_gene3 <- read_csv("down_exp_medium.csv")
up_gene3  <- read_csv("up_exp-medium.csv")

#Filter gene of interest // replace "APOOL" by the gene symbol
#select and Run lines

v <- any(up_gene3 =="UXS1") 
r <-  any(down_gene3 =="UXS1") 
if (v==TRUE){
  exp_medium <- "The gene is overexpressed"
} else if (r==TRUE) {
  exp_medium <-"the gene is underexpressed"
} else {
  exp_medium <-"The gene is not differencially expressed"
}
exp_medium

#export the result
#run line 34 to download the result
write.table(exp_medium,"expression_profile_medium.txt")

#methylation profile 
#replace the "UXS1"by your gene symbol and Run
promoter_methylation_medium<- read_excel("promoter_methylation_medium.xlsx")
cpg_met3 <- promoter_methylation_medium %>%
  filter(gene =="UXS1")
#result
cpg_met3
#export result
write.table( cpg_met3 , "cpg_methylation_medium.txt" , row.names=F , sep = ",")


#microRNA data
#replace the "UXS1"by your gene symbol and Run
miRNA_medium <- read.csv("miRNA_medium.csv")
miRNA3 <- miRNA_medium %>%
  filter(gene =="UXS1")
miRNA3
#export result
write.table( miRNA3 , "miRNA_medium.txt" , row.names=F , sep = ",")



# Low prevalence ----------------------------------------------------------

#No expression data available



#methylation profile study
#replace the "LY6G5C"by your gene symbole and Rune line 39:41
promoter_methylation_low<- read_excel("promoter_methylation_low.xlsx")
cpg_met4 <- promoter_methylation_low %>%
  filter(gene =="UXS1")
#result
cpg_met4
#export result
write.table( cpg_met4 , "cpg_methylation_low.txt" , row.names=F , sep = ",")


