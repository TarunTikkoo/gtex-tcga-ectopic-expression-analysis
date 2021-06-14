# Load and condense GTEx Median gene-level TPM by tissue file
# https://www.gtexportal.org/home/datasets
# https://storage.googleapis.com/gtex_analysis_v8/rna_seq_data/GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_median_tpm.gct.gz

library(tidyverse)

# 56,200 Genes, 54 Tissues
gtex_tpm <- read_csv('data/raw/gtex-median-data.csv')

# The following chunk is used to condense multiple sub-tissues into a single
# tissue using the maximum TPM of the sub-tissues.

# Create vector of tissue names
gtex_tpm_tissues <- colnames(gtex_tpm)[-c(1,2)]

# New empty data frame with just the descriptor columns from original
gtex_tpm_condensed <- gtex_tpm[,1:2]

# iterate through each tissue name and retrieve prefix
for (tissue_name in gtex_tpm_tissues) {
  tissue_name_prefix <- str_trim(strsplit(tissue_name, '-', fixed = TRUE)[[1]][1])
  
  # If column has already been condensed  or
  # if column is a cell line, skip iteration
  if (tissue_name_prefix %in% colnames(gtex_tpm_condensed) | tissue_name_prefix == 'Cells') {next}
  
  # Create vector of indices of matching prefixes
  # The '+ 2' accounts for the 2 descriptor columns at the start of the matrix
  match_cols <- grep(tissue_name_prefix, gtex_tpm_tissues) + 2
  
  # Add new column using maximum value of each row
  # Use condensed name if multiple columns
  # Use original name if single column
  if (length(match_cols) > 1) {
    
    gtex_tpm_condensed <- add_column(gtex_tpm_condensed, !!tissue_name_prefix := apply(gtex_tpm[,match_cols],1,max))
  }
  else {
    gtex_tpm_condensed <- add_column(gtex_tpm_condensed, !!tissue_name := apply(gtex_tpm[,match_cols],1,max))
  }
}

# save matrix of 56,200 genes vs 30 r
write.csv(gtex_tpm_condensed, 
            file = "data/processed/gtex_tpm_condensed.csv",
            row.names = F)
