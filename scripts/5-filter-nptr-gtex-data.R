# Load packages, function and data --------------------------------------------------
library(tidyverse)
library(matrixStats)

gtex_unified <- read_csv("data/processed/gtex-unified-(gtex+prad-genes-only).csv")
load("data/objects/642_nptr_genes.RData")

# Function:
# Calculate min, Q1, median, mean, Q3 and max for each row
# Input: matrix over which stats are to be calculated
# Output: vector of summary stats
# Bind to df by cbind(df, t(apply(df, 1, summary.by.row)))
summary.by.row <- function(x) 
  {
    Min <- min(x, na.rm = TRUE)
    Quantile.1 <- quantile(x, na.rm = TRUE)[['25%']]
    Median <- median(x, na.rm = TRUE)
    Quantile.3 <- quantile(x, na.rm = TRUE)[['75%']]
    Max <- max(x, na.rm = TRUE)
    return(c(Min = Min, Quantile.1 = Quantile.1, Median = Median, Quantile.3 = Quantile.3, Max = Max))
}

# Filter unified data to nptr and perform summary calculations ------------

gtex_unified_nptr <- filter(gtex_unified, Hugo_Symbol %in% nptr_genes_642)
gtex_unified_nptr <- cbind(gtex_unified_nptr, t(apply(gtex_unified_nptr[2:14], 1, summary.by.row)))
write.csv(gtex_unified_nptr, file = "data/processed/642_nptr_genes_unified_dataset.csv")
# 642 NPTR genes so far

summary(gtex_unified_nptr[15:ncol(gtex_unified_nptr)])
# Median of Q3 = 1.505
# Median of Max = 1246.7
# Filter further using genes with Q3 > 1 and Max > 1000

# Further filter of NPTR genes --------------------------------------------
# 301 NPTR genes here
gtex_unified_nptr_filtered <- 
  gtex_unified_nptr %>% filter(Quantile.3 > 1 & Max > 1000)

write.csv(gtex_unified_nptr_filtered, file = "data/processed/301_nptr_genes_unified_dataset.csv")

nptr_genes_301 <- gtex_unified_nptr_filtered$Hugo_Symbol
save(nptr_genes_301, file = "data/objects/301_nptr_genes.RData")