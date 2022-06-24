
#' Get gene specific data
#'
#' @param gene target gene symbole
#'
#' @return GSD
#' @export

GSDF <- function(gene) {
  target_gene <- gene
  ##Differential profile
  x <-  any(DEGs ==target_gene)
  if (x==TRUE){
    DEG <- "yes"
  } else {
    DEG <-"no"
  }

  y <-  any(DMGs ==target_gene)
  if (y==TRUE){
    DMG <-  "yes"
  } else {
    DMG <- "no"
  }
  #miRNA
  z <-  any(GDEIRs ==target_gene)
  if (z==TRUE){
    DEIMR <- "yes"
  } else {
    DEIMR <-"no"
  }
  #
  #expression
  gene_expression <- filter(expression, str_starts(gene,target_gene))
  gene_expression=select(gene_expression,-1)
  if (nrow(gene_expression)==0){
    gene_expression <- "no data"
    gene_expression<-data.frame(gene_expression)
  }

  #methylation
  cpg_methylation <- filter(methylation, str_starts(gene,target_gene))
  cpg_methylation=select(cpg_methylation,-1)
  if (nrow(cpg_methylation)==0){
    cpg_methylation <- "no data"
    cpg_methylation<-data.frame(cpg_methylation)
  }

  #miRNA
  miRNA_expression <- filter(miRNA , str_starts(gene,target_gene))
  miRNA_expression=select(miRNA_expression,-1)

  if (nrow(miRNA_expression)==0){
    miRNA_expression <- "no data"
    miRNA_expression <- data.frame(miRNA_expression)
  }
  #
  result <- data.frame(target_gene,DEG,DMG,DEIMR)
  GSD<-bind_rows(result,gene_expression,cpg_methylation,miRNA_expression)
  #export
  write.table(GSD, "GSD.txt", sep = ",")

}
