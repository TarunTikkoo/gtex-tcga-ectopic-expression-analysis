# Load packages and data --------------------------------------------

library(tidyverse)
library(stats)

gtex_unified_gc_pcon <- read.csv("data/processed/gtex_unified_pcon_gini.csv",
                                 header = T)

gtex_condensed_gc_pcon <- read.csv("data/processed/gtex_condensed_pcon_gini.csv",
                                   header=T) 

# Filter high GC, Low PCON Genes on Unified Dataset ---------------------------

gtex_unified_gc_pcon %>% 
  filter(gini_coeff > quantile(gtex_unified_gc_pcon$gini_coeff, 0.90)) %>% 
  filter(pcon < quantile(gtex_unified_gc_pcon$pcon, 0.10)) %>% 
  # select(Hugo_Symbol)
  nrow(.)

gtex_condensed_gc_pcon %>% 
  filter(gini_coeff > quantile(gtex_condensed_gc_pcon$gini_coeff, 0.8)) %>% 
  filter(pcon < quantile(gtex_condensed_gc_pcon$pcon, 0.35))
