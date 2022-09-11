
#' Title
#'
#' @param expression
#' @param methylation
#' @param miRNA
#' @param target_gene
#'
#' @return
#' @export
#'
#' @examples
#' @importFrom  rlang .data
gsdf <- function(expression, methylation, miRNA, target_gene) {
  #load
  exp <- expression
  exp <- dplyr::rename(exp, gene = c(1))
  exp <- dplyr::rename(exp, p.value.gene = c(2))
  exp <- dplyr::rename(exp, LogFC.gene = c(3))


  meth <- methylation
  meth  <- dplyr::rename(meth ,gene = c(1))
  meth  <- dplyr::rename(meth ,p.value.cpg = c(3))
  meth  <- dplyr::rename(meth ,LogFc.cpg = c(4))

  miR <- miRNA
  miR  <- dplyr::rename(miR ,gene = c(1))
  miR  <- dplyr::rename(miR ,p.value.mir = c(3))
  miR  <- dplyr::rename(miR ,LogFC.mir = c(4))

  #D.P
  DEGs<- dplyr::filter (exp, .data$p.value.gene<0.05)
  DEGs <- dplyr::select (DEGs,c(1))
  unique(DEGs)
  DMGs<- dplyr::filter (meth, .data$p.value.cpg<0.05)
  DMGs <- dplyr::select (DMGs, c(1))
  unique(DMGs)
  GDEIRs<- dplyr::filter (miR, .data$p.value.mir<0.05)
  GDEIRs <- dplyr::select (GDEIRs, c(1))
  unique(GDEIRs)

  #Filter
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
  gene_expression <- dplyr::filter(exp, gene ==target_gene)
  gene_expression= dplyr::select(gene_expression,-1)
  if (nrow(gene_expression)==0){
    gene_expression <- "no data"
    gene_expression<-data.frame(gene_expression)
  }

  #methylation
  cpg_methylation <- dplyr::filter(meth, gene ==target_gene)
  cpg_methylation= dplyr::select(cpg_methylation,-1)
  if (nrow(cpg_methylation)==0){
    cpg_methylation <- "no data"
    cpg_methylation<-data.frame(cpg_methylation)
  }

  #miRNA
  miRNA_expression <- dplyr::filter(miR , gene ==target_gene)
  miRNA_expression= dplyr::select(miRNA_expression,-1)

  if (nrow(miRNA_expression)==0){
    miRNA_expression <- "no data"
    miRNA_expression <- data.frame(miRNA_expression)
  }
  #
  result <- data.frame(target_gene,DEG,DMG,DEIMR)
  GSD<- dplyr::bind_rows(result,gene_expression,cpg_methylation,miRNA_expression)
  #export
  openxlsx::write.xlsx(GSD, "Gene_specific_data.xlsx")
  #return
  print(GSD)
  return(GSD)
}
