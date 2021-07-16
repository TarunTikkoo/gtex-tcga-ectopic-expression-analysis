# Load packages -----------------------------------------------------------

library(tidyverse)

# Gene sets setup ---------------------------------------------------------

nptr.gs <- list()

# Full Gene Set
full_gene_set <- read_csv("data/processed/gtex-unified-(gtex+prad-genes-only).csv") %>% 
  pull(1)
nptr.gs[["full_gene_set"]] <- full_gene_set

# 642 NPTR Genes
load("data/objects/642_nptr_genes.RData")
nptr.gs[["642_NPTR"]] <- nptr_genes_642

# 301 NPTR Genes
load("data/objects/301_nptr_genes.RData")
nptr.gs[["301_NPTR"]] <- nptr_genes_301

# 30 NPTR GOI
load("data/objects/30_nptr_goi.RData")
nptr.gs[["30_GOI"]] <- goi_nptr_30


# Liver and esoph gene set ---------------------------------------------------

load("data/objects/gtex_unified_301_max_tissues.RData")

nptr.gs[["liver_subset"]] <- gtex_unified_301.max.tissues %>% 
                              filter(tissues == "liver") %>% 
                              pull(Hugo_Symbol)

nptr.gs[["easophagus_subset"]] <- gtex_unified_301.max.tissues %>% 
                                    filter(tissues == "max_easophagus") %>% 
                                    pull(Hugo_Symbol)


# save(nptr.gs, file = "data/objects/nptr_gene_sets_list.RData")
