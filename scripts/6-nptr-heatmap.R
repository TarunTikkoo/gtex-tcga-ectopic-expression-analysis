# Load packages and data --------------------------------------------------
library(tidyverse)
library(pheatmap)

load("data/objects/642_nptr_genes.RData")
load("data/objects/301_nptr_genes.RData")

# Data citation 3 from Wang et al (2018): 
# https://figshare.com/articles/dataset/Data_record_3/5330593
unified_data_path <- "../_large-data-files/gtex-tcga-unified/"
prad_path <- paste(unified_data_path, "prad-rsem-fpkm-tcga-t.txt", sep = "")

# Import PRAD TCGA tumour data
prad_unified <- read_tsv(prad_path) %>% select(-2) # remove Entrez gene column


# Clean up
rm(prad_path, unified_data_path)


# 642 NPTR gs heatmap on PRAD data ---------------------------------------------
# filter unified tcga prad data to 642 nptr gs
nptr_prad_unified_642 <-
  prad_unified %>% 
    filter(Hugo_Symbol %in% nptr_genes_642)

write_csv(nptr_prad_unified_642, file = "data/processed/nptr_prad_unified_642.csv")

# log transform for pheatmap
log.nptr_prad_unified_642 <- 
  as.data.frame(cbind(nptr_prad_unified_642[1], # gene names
                      log(0.01 + nptr_prad_unified_642[-1], 10))) # log transform

# Heatmap for 642 nptr gs
pheatmap(log.nptr_prad_unified_642[-1],
         show_rownames = FALSE,
         show_colnames = FALSE,
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         main = "Expression heatmap of unified TCGA PRAD Tumour samples in  the 642 NPTR gs"
         # fontsize = 6.5,
         # fontsize_row=6,
         # fontsize_col = 6
        )

ggsave(filename = "figs/prad-t-642-nptr-heatmap.png")

# 301 NPTR gs heatmap on PRAD data ---------------------------------------------
# filter unified tcga prad data to 301 nptr gs
nptr_prad_unified_301 <-
  prad_unified %>% 
  filter(Hugo_Symbol %in% nptr_genes_301)

write_csv(nptr_prad_unified_301, file = "data/processed/nptr_prad_unified_301.csv")

# log transform for pheatmap
log.nptr_prad_unified_301 <- 
  as.data.frame(cbind(nptr_prad_unified_301[1], # gene names
                      log(0.01 + nptr_prad_unified_301[-1], 10))) # log transform

# Heatmap for 301 nptr gs
pheatmap(log.nptr_prad_unified_301[-1],
          show_rownames = FALSE,
          show_colnames = FALSE,
          cluster_rows = TRUE,
          cluster_cols = TRUE,
          main = "Expression heatmap of unified TCGA PRAD Tumour samples in  the 301 NPTR gs"
          # fontsize = 6.5,
          # fontsize_row=6,
          # fontsize_col = 6
        )

ggsave(filename = "figs/prad-t-301-nptr-heatmap.png")