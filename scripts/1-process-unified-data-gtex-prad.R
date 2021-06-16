# Load packages and functions ---------------------------------------------

library(tidyverse)
library(matrixStats)

## Function to import PRAD data as medians from unified data
prad_import_median <- function(tissue.Filename) {
  # Argument is filename of unified TCGA data (Wang et al 2018)
  # Returns a tibble of gene expression medians across samples
  # matrixStats package required for rowMedians
  
  tissue.tbl <- read_tsv(tissue.Filename)
  
  tissue.Medians <-
    tissue.tbl %>%
    mutate(
      PRAD_Median = rowMedians(as.matrix(.[3:ncol(.)]))) %>%
    select(1,PRAD_Median)
  
  return(as_tibble(tissue.Medians))
}

## Function to import gtex data as medians from unified data 
gtex_import_median <- function(tissue.Filename) {
  # Argument is filename of unified GTEx data (Wang et al 2018)
  # Returns a numeric vector of gene expression medians across samples
  # matrixStats package required for rowMedians
  
  # Extract tissue name from file name and read to tibble
  tissue <- word(list.files(unified_data_path, pattern = gtex.File), 1, sep = "-")
  tissue.tbl <- read_tsv(tissue.Filename)
  
  # Calculate median expression of each gene across all samples
  # select gene symbols and median expression
  tissue.medians <- tissue.tbl %>%
    mutate(
      !!all_of(tissue) := rowMedians(as.matrix(.[3:ncol(.)]))
    ) %>%
    select(Hugo_Symbol, tissue)
  
  return(as_tibble(tissue.medians))
}


# Load Unified PRAD ---------------------------------------------------------------
# The unified data is too large to be uploaded to GitHub
# Place all data files in a folder and set path to variable below
# Data citation 3 from Wang et al (2018): https://figshare.com/articles/dataset/Data_record_3/5330593
unified_data_path <- "../_large-data-files/gtex-tcga-unified/"

# Import PRAD TCGA genes and their median expression
prad <- prad_import_median(paste(unified_data_path, "prad-rsem-fpkm-tcga.txt", sep = ""))



# Load Unified GTEx -------------------------------------------------------


# Import gene names in each GTEx tissue file to a list
{
# All GTEx filenames
gtex.Files <- sort(list.files(unified_data_path, pattern = "gtex.txt"))

# Tissue names from GTEx files
tissues <- word(gtex.Files, 1, sep = "-")

master_list <- rep(list(NULL), 15)
names(master_list) <- tissues

# master_list will have 15 elements. Each element is a tissue.
# Each element will contaian a list of genes whose expression is present in the
# unified expression file.
i = 1
for (gtex.File in gtex.Files){
  gtex.File <- paste(unified_data_path,gtex.File, sep = "")
  master_list[[i]] <- (read_tsv(gtex.File) %>% select(Hugo_Symbol))$Hugo_Symbol
  i = i + 1
}
rm(i)
}

# Limit gene set to those in common with ALL GTEx tissues & PRAD
prad_gtex_intersected_genes <- prad$Hugo_Symbol
for (tissue.genes in master_list) {
  print(length(intersect(prad_gtex_intersected_genes, tissue.genes))) # number of genes intersected
  prad_gtex_intersected_genes <- intersect(prad_gtex_intersected_genes, tissue.genes)
  }
# 18154 genes



# Dataframes of unified GTEx and PRAD data using interesected genes ---------------------
# PRAD data
prad_intersected <- prad %>%
                    filter(Hugo_Symbol %in% prad_gtex_intersected_genes)

# GTEx data
gtex_intersected <- as_tibble_col(prad_gtex_intersected_genes, "Hugo_Symbol")


# Add tissues and corresponding gene expressions.
for (gtex.File in gtex.Files) {
  gtex_intersected <- inner_join(gtex_intersected, 
                                 gtex_import_median(paste0(unified_data_path,gtex.File)), 
                                 by = "Hugo_Symbol")
}

# gtex_intersect nowis now 18154 genes by 15 tissues matrix 3 columns are
# subtissues of esophagus. The following section condenses them using max
# expression across the 3.
{
easophagus_cols = 6:8
  
max_easophagus <- rowMaxs(as.matrix(gtex_intersected[,easophagus_cols]))

gtex_intersected <-
  gtex_intersected %>%
  select(-c(easophagus_cols)) %>%
  add_column(max_easophagus)

# Clean up Environment
rm(max_easophagus)
}

write.csv(gtex_intersected, 
          file = "data/processed/gtex-unified-(gtex+prad-genes-only).csv",
          row.names = F)

write.csv(prad_intersected, 
          file = "data/processed/prad-unified-(gtex+prad-genes-only).csv",
          row.names = F)