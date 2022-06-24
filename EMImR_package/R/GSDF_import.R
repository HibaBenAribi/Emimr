#' import files for GSDF function
#'
#' @param path file that contains the data csv files
#'
#' @return expression, methylation,  miRNA, DEGs , DMGs and GDEIRs


GSDF_import <- function(path) {
  setwd(path)
  expression <- read.csv("expression.csv")
  methylation <- read.csv("methylation.csv")
  miRNA <- read.csv("miRNA.csv")
  DEGs <- read.csv("DEGs.csv")
  DMGs <- read.csv("DMGs.csv")
  GDEIRs <- read.csv("GDEIRs.csv")
}
