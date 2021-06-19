# Load packages and data --------------------------------------------

library(tidyverse)
library(stats)

gtex_unified_gc_pcon <- read.csv("data/processed/gtex_unified_pcon_gini.csv",
                                 header = T)

gtex_condensed_gc_pcon <- read.csv("data/processed/gtex_condensed_pcon_gini.csv",
                                   header=T) 

# Filter high GC, Low PCON Genes on Unified Dataset ---------------------------

# Classify NPTR genes as those with GC > 0.9 and PCON < 0.10
gc_quantile = 0.95
pcon_quantile = 0.05

nptr_genes <- gtex_unified_gc_pcon %>% 
  filter(gini_coeff > quantile(gtex_unified_gc_pcon$gini_coeff, gc_quantile)) %>% 
  filter(pcon < quantile(gtex_unified_gc_pcon$pcon, pcon_quantile)) %>% 
  select(Hugo_Symbol)

write.csv(nptr_genes, file = "data/processed/nptr_genes_unified_dataset")


# Condensed Data ------------------------------------------------------------

# NB. quantile selection for GC and PCON will have to be very different here
# since distribution of GCs is right skewed in condensed but left skewed in
# unified
# par(mfrow = c(1,2))
# hist(gtex_condensed_gc_pcon$gini_coeff)
# hist(gtex_unified_gc_pcon$gini_coeff)

gtex_condensed_gc_pcon %>% 
  filter(gini_coeff > quantile(gtex_condensed_gc_pcon$gini_coeff, gc_quantile)) %>% 
  filter(pcon < quantile(gtex_condensed_gc_pcon$pcon, pcon_quantile)) %>% 
  select(Hugo_Symbol)
