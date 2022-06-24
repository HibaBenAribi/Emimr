#' Genes differential profil
#'
#' @return a1,a2,a3,a4
#' @export
EMImR_gene <- function( ) {
  #define DP

  options(scipen = 999)
  DEGs<- dplyr::filter (expression, c(2)<0.05)
  DEGs <- select (DEGs,c(1))
  DMGs<- dplyr::filter (methylation, c(3)<0.05)
  DMGs <- select (DMGs, c(1))
  GDEIRs<- dplyr::filter (miRNA, c(3)<0.05)
  GDEIRs <- select (GDEIRs, c(1))

  #intersection
  inter_DEGs_DMGs<-merge(DEGs,DMGs, by.x = "gene", by.y = "gene")

  inter_DEGs_GDEIRs<-merge(DEGs,GDEIRs, by.x = "gene", by.y = "gene")

  inter_DMGs_GDEIRs<-merge(DMGs,GDEIRs, by.x = "gene", by.y = "gene")

  inter_DEGs_DMGs_GDEIRs<-merge(inter_DEGs_DMGs,inter_DEGs_GDEIRs, by.x = "gene", by.y = "gene")


  #genes

  a1 <- data.frame(inter_DEGs_DMGs_GDEIRs)
  a2 <- data.frame(inter_DEGs_DMGs)
  a3 <- data.frame(inter_DEGs_GDEIRs)
  a4 <- data.frame(inter_DMGs_GDEIRs)

  Genes_Differential_Profile <-bind_rows(a1,a2,a3,a4)
}
