#' Calculate differencial genes
#'
#' @return table
#' @export

EMImR_count <- function() {
  number_DEGs <- nrow(DEGs)-1
  number_DMGs <- nrow(DMGs)-1
  number_DEIMR_G <- nrow(GDEIRs)-1
  DEGs_vs_DMGs <- nrow(inter_DEGs_DMGs)
  DEGs_vs_GDEIRs <- nrow(inter_DEGs_GDEIRs)
  DMGs_vs_GDEIRs <- nrow(inter_DMGs_GDEIRs)
  DEGs_vs_DMGs_vs_GDEIRs <- nrow(inter_DEGs_DMGs_GDEIRs)
  #summary
  #numbers
  result <- data.frame(number_DEGs,number_DMGs,number_GDEIRs,DEGs_vs_DMGs_vs_GDEIRs,DEGs_vs_DMGs,DEGs_vs_GDEIRs,DMGs_vs_GDEIRs)
  result<- as.data.frame(t(result))
  Data_Intersection<-rename(result,Intersection=c(1))

}
