##### Run line  3:7
# set directory
setwd("C:/Users/LENOVO/Desktop/Script")
#cal libraries 
library(survival)
library(tidyverse)
library(readxl)
#to analyze the gene data for all the prevalence area change the gene symbol to your target gene symbol, select all and run the code 

#################################################################################
# Gene expression in High prevalence countries  ----------------------------------------------------
expression_high <- read_excel("expression_high.xlsx")

e<- expression_high %>%
     filter(Gene.symbol== "STAT3")
e
write.table(e,"expression_profile_high.txt")

#################################################################################
#  Is the Gene Differencially expressed in high prevalence countries ? --------

#up_gene mean over_expressed genes
#down_gene mean _ genes
#select and Run lines

down_gene <- read_csv("down_exp_high.csv")
up_gene  <- read_csv("up_exp_high.csv")

#Filter gene of interest // replace "APOOL" by the gene symbol
#select and Run lines

x <- any(up_gene =="STAT3") 
y <-  any(down_gene =="STAT3") 
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
write.table(exp_high,"DEG_high.txt")

#################################################################################
# Gene promoter methylation in high prevalence countries ------------------

#methylation profile study
#replace the  gene symbole and Run
promoter_methylation_high <- read_excel("promoter_methylation_high.xlsx")
cpg_met <- promoter_methylation_high %>%
  filter(gene =="STAT3")
#result
cpg_met
#export result
write.table( cpg_met , "cpg_methylation_high.txt" , row.names=F , sep = ",")

#################################################################################

# Gene expression in medium to high prevalence ----------------------------------------------------------
expression_medium_to_high <- read_excel("expression_medium_to_high.xlsx")

e2<- expression_medium_to_high  %>%
  filter(Gene.symbol== "STAT3")
e2
write.table(e,"expression_profile_medium_to_high.txt")





#################################################################################

# Is Gene Deferentially expressed in medium to high prevalence countries ?  --------

#up_gene mean over_expressed genes
#down_gene mean under_expressed genes


down_gene2 <- read_csv("down_exp_medium_to_high.csv")
up_gene2  <- read_csv("up_exp_medium_to_high.csv")

# replace  the gene symbol


z <- any(up_gene2 =="STAT3") 
t <-  any(down_gene2 =="STAT3") 
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
write.table(exp_medium_to_high,"DEG_medium_to_high.txt")

#################################################################################

# Is gene promoter methylated in medium to high prevalence countries --------



#methylation profile study
#replace the gene symbol and Run lines
promoter_methylation_medium_to_high<- read_excel("promoter_methylation_medium_to_high.xlsx")
cpg_met2 <- promoter_methylation_medium_to_high %>%
  filter(gene =="STAT3")
#result
cpg_met2
#export result
write.table( cpg_met2 , "cpg_methylation_medium_to_high.txt" , row.names=F , sep = ",")

#################################################################################
# Genetic expression in Medium prevalence countries  -------------------------------------------------------

expression_medium <- read_excel("expression_medium.xlsx")

e3<- expression_medium  %>%
  filter(gene== "STAT3")
e3
write.table(e,"expression_profile_medium.txt")




#################################################################################

# Is the gene differentially expressed in medium prevalence countries ?--------


#up_gene mean over_expressed genes
#down_gene mean under_expressed genes


down_gene3 <- read_csv("down_exp_medium.csv")
up_gene3  <- read_csv("up_exp-medium.csv")

#replace the gene symbol


v <- any(up_gene3 =="STAT3") 
r <-  any(down_gene3 =="STAT3") 
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
write.table(exp_medium,"DEG_medium.txt")

#################################################################################

# Is the gene promoter methylated in medium prevalence countries ? --------


#methylation profile 
#replace the "UXS1"by your gene symbol and Run
promoter_methylation_medium<- read_excel("promoter_methylation_medium.xlsx")
cpg_met3 <- promoter_methylation_medium %>%
  filter(gene =="STAT5A")
#result
cpg_met3
#export result
write.table( cpg_met3 , "cpg_methylation_medium.txt" , row.names=F , sep = ",")


#################################################################################

# Genetic expression in Low prevalence countries  ----------------------------------------------------------

expression_low <- read_excel("exp_low.xlsx")

e2<- expression_low  %>%
  filter(gene== "STAT3")
e2
write.table(e,"expression_profile_low.txt")



#################################################################################

# Is the gene differentially expressed in low prevalence countries ?--------


#up_gene mean over_expressed genes
#down_gene mean under_expressed genes
#select and Run lines

down_gene4 <- read_csv("low_exp_medium.csv")
up_gene4  <- read_csv("low-medium.csv")

#Filter gene of interest // replace "APOOL" by the gene symbol
#select and Run lines

o <- any(up_gene4 =="STAT3") 
u <-  any(down_gene4 =="STAT3") 
if (o==TRUE){
  exp_low <- "The gene is overexpressed"
} else if (u==TRUE) {
  exp_low <-"the gene is underexpressed"
} else {
  exp_low <-"The gene is not differencially expressed"
}
exp_low

#export the result
write.table(exp_medium,"DEG_low.txt")


#################################################################################

# Is the gene promoter methylated in low prevalence countries ? -----------

#methylation profile study
#replace the  gene symbol and Rune lines
promoter_methylation_low<- read_excel("promoter_methylation_low.xlsx")
cpg_met4 <- promoter_methylation_low %>%
  filter(gene =="STAT3")
#result
cpg_met4
#export result
write.table( cpg_met4 , "cpg_methylation_low.txt" , row.names=F , sep = ",")


#################################################################################

# The miRNA regulating the gene -------------------------------------------
miRNA_gene <- read_excel("miRNA-gene.xlsx")

miRNA <- miRNA_gene %>%
  filter(gene =="STAT3")
miRNA
#export result
write.table( miRNA , "miRNA_gene.txt" , row.names=F , sep = ",")



#################################################################################

# Is the miRNAs  expressed in MS in high prevalence countries  ? -------------------------


miRNA_high <- read_excel("miRNA_high.xlsx")


miRNA_ms1 <- miRNA_high %>%
  filter(miRNA_ID =="hsa-miR-130a-3p")
miRNA_ms1
#export result
write.table( miRNA_ms1 , "miRNA__expressed.txt" , row.names=F , sep = ",")



# Is the miRNAs  expressed in MS in medium to high prevalence countries  ? -------------------------------------------------------------------------

miRNA_m_h <- read_excel("miRNA_medium_to_high.xlsx")
#replace the  gene symbol and Run

miRNA_ms2 <- miRNA_m_h %>%
  filter(miRNA_ID =="hsa-miR-130a-3p")
miRNA_ms2
#export result
write.table( miRNAms2 , "miRNA__expressed.txt" , row.names=F , sep = ",")








