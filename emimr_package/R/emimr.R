
#' Title
#'
#' @param expression
#' @param methylation
#' @param miRNA
#'
#' @return
#' @export
#'
#' @examples
#' @importFrom  rlang .data
emimr <- function(expression, methylation, miRNA) {

  ##load
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

  ##EMImRgene()
  #D.P
  DEGs<- dplyr::filter (exp, .data$p.value.gene<0.05)
  DEGs <- dplyr::select (DEGs,c(1))
  DEGs <- unique(DEGs)
  DMGs<- dplyr::filter (meth, .data$p.value.cpg<0.05)
  DMGs <- dplyr::select (DMGs, c(1))
  DMGs <- unique(DMGs)
  GDEIRs<- dplyr::filter (miR, .data$p.value.mir<0.05)
  GDEIRs <- dplyr::select (GDEIRs, c(1))
  GDEIRs <- unique(GDEIRs)
  #intersection
  iem<-merge(DEGs,DMGs, by.x = "gene", by.y = "gene")

  ieim<-merge(DEGs,GDEIRs, by.x = "gene", by.y = "gene")

  imim<-merge(DMGs,GDEIRs, by.x = "gene", by.y = "gene")

  iemim<-merge(iem,ieim, by.x = "gene", by.y = "gene")

  #Summary
  a1 <- data.frame(dplyr::rename(iemim,DEGs_vs_DMGs_vs_GDEIRs=gene))
  a1 <- unique(a1)
  a2 <- data.frame(dplyr::rename(iem,DEGs_vs_DGMs=gene))
  a2 <- unique(a2)
  a3 <- data.frame(dplyr::rename(ieim,DEGs_vs_GDEIRs=gene))
  a3 <- unique(a3)
  a4 <- data.frame(dplyr::rename(imim,DMGs_vs_GDEIR=gene))
  a4<- unique(a4)
  a5 <- dplyr::rename (DEGs, DEGs = gene)
  a6 <- dplyr::rename (DMGs, DMGs = gene)
  a7 <- dplyr::rename (GDEIRs, GDEIRs = gene)

  GDP <- dplyr::bind_rows(a5,a6,a7,a1,a2,a3,a4)


  #Export
  data_list <- list( "DEGs" = DEGs,
                     "DMGs" = DMGs,
                     "GDEIRs" = GDEIRs,
                     "DEGs_vs_DMGs_vs_GDEIRs" = iemim,
                     "DEGs_vs_DGMs" = iem,
                     "DEGs_vs_GDEIRs" =ieim,
                     "DMGs_vs_GDEIRs" = imim)
  openxlsx::write.xlsx(data_list, "Genes_Differential_Profile.xlsx")

  ##return
  print(GDP)
  return(GDP)

}
