#' Import files for the EMImR function
#'
#' @param path file that contains data csv files
#'
#' @return expression, methylation and miRNA


EMImR_import <- function(path) {

  setwd(path)
  expression <- read.csv("expression.csv")
  expression <- rename(expression, p_value = c(2))
  methylation <- read.csv("methylation.csv")
  methylation  <- rename(methylation , p_value = c(3))
  miRNA <- read.csv("miRNA.csv")
  miRNA  <- rename(miRNA , p_value = c(3))
}
