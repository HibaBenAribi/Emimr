#' Genes differential profil
#'
#' @return a1,a2,a3,a4
#' @export
EMImR_gene <- function( ) {
  #define DP

  options(scipen = 999)
  DEGs<- filter (expression, c(2)<0.05)
  DEGs <- select (DEGs,c(1))
  DMGs<- filter (methylation, c(3)<0.05)
  DMGs <- select (DMGs, c(1))
  GDEIRs<- filter (miRNA, c(3)<0.05)
  GDEIRs <- select (DEMR_gene, c(1))

  #intersection
  inter_DEGs_DMGs<-merge(DEGs,DMGs, by.x = "gene", by.y = "gene")

  inter_DEGs_GDEIRs<-merge(DEGs,GDEIRs, by.x = "gene", by.y = "gene")

  inter_DMGs_GDEIRs<-merge(DMGs,GDEIRs, by.x = "gene", by.y = "gene")

  inter_DEGs_DMGs_GDEIRs<-merge(inter_DEGs_DMGs,inter_DEGs_GDEIRs, by.x = "gene", by.y = "gene")


  #genes

  a1 <- data.frame(inter_DEGs_DMGs_GDEIRs)%>%
    rename (DEGs_vs_DMGs_vs_DEIMRG=gene)
  a2 <- data.frame(inter_DEGs_DMGs)%>%
    rename(DEGs_vs_DGMs=gene)
  a3 <- data.frame(inter_DEGs_GDEIRs)%>%
    rename(DEGs_vs_DEIMRG=gene)
  a4 <- data.frame(inter_DMGs_GDEIRs)%>%
    rename(DMGs_vs_DEIMRG=gene)

  Genes_Differential_Profile <-bind_rows(a1,a2,a3,a4)
}
