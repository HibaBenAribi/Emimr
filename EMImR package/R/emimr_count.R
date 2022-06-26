
#' Count the genes
#'
#' @param emimr_result emimr function result dataframe name
#'
#' @return count table
#' @export
#'
#' @importFrom  rlang .data
emimr_count <- function(emimr_result){
  GDP <- emimr_result
  #
  DEGs <- dplyr::select (GDP,c(1))
  DMGs <- dplyr::select (GDP,c(2))
  GDEIRs <- dplyr::select (GDP,c(3))
  iemim <- dplyr::select (GDP,c(4))
  iem <- dplyr::select (GDP,c(5))
  ieim <- dplyr::select (GDP,c(6))
  imim <- dplyr::select (GDP,c(7))
  #
  number_DEGs <- nrow(DEGs)-1
  number_DMGs <- nrow(DMGs)-1
  number_GDEIRs <- nrow(GDEIRs)-1
  DEGs_vs_DMGs <- nrow(iem)
  DEGs_vs_GDEIRs <- nrow(ieim)
  DMGs_vs_GDEIRs <- nrow(imim)
  DEGs_vs_DMGs_vs_GDEIRs <- nrow(iemim)
  result <- data.frame(number_DEGs,number_DMGs,number_GDEIRs,DEGs_vs_DMGs_vs_GDEIRs,DEGs_vs_DMGs,DEGs_vs_GDEIRs,DMGs_vs_GDEIRs)
  result<- as.data.frame(t(result))
  DI<- dplyr::rename(result,Intersection=c(1))
  openxlsx::write.xlsx(DI,"EMImR_count.xlsx",rowNames=TRUE)
  return(DI)
}
