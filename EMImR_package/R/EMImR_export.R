#' Export EMImR function results
#'
#' @return excel table
#' @export

export_gene <- function( ) {

  ##export data
  #genes

  data_list <- list("DEGs_vs_DMGs_vs_DEIMRG" = inter_DEGs_DMGs_GDEIRs,
                    "DEGs_vs_DGMs" = inter_DEGs_DMGs,
                    "DEGs_vs_DEIMRG" =inter_DEGs_GDEIRs,
                    "DMGs_vs_DEIMRG" = inter_DMGs_GDEIRs)
  write.xlsx(data_list, "EMImR_genes.xlsx")

  write.csv(DEGs, "DEGs.csv")
  write.csv(DMGs, "DMGs.csv")
  write.csv(GDEIRs, "GDEIRs.csv")
  # count
  write.csv(Data_Intersection,"EMImR_count.csv")
}
