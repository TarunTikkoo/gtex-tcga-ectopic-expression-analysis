# Load packages, GC, PCON data --------------------------------------------

library(tidyverse)
library(ggpubr) # for ggscatter, regression

gc_pcon_comparison_df <- 
  read.csv("data/processed/gtex_condensed_pcon_gini.csv",
    header = T) %>% 
  rename(pcon_condensed = pcon) %>% 
  rename(gc_condensed = gini_coeff)
  
gc_pcon_comparison_df <- 
  read.csv("data/processed/gtex_unified_pcon_gini.csv",
    header = T) %>% 
  inner_join(gc_pcon_comparison_df, ., by = "Hugo_Symbol") %>% 
  rename(pcon_unified = pcon) %>% 
  rename(gc_unified = gini_coeff)

write.csv(gc_pcon_comparison_df, file = "data/processed/gc_pcon_unified_vs_condensed.csv")

# GC Condensed vs GC unified ----------------------------------------------
ggscatter(gc_pcon_comparison_df, 
          x = "gc_unified", y = "gc_condensed", add = "reg.line",
          color = "black", shape = 21,size=3) + 
  theme_grey() +
  labs(
    title = 'Gini Coefficient Comparison before and after GTEx unification with TCGA',
    x = 'Gini after unification' ,
    y = 'Gini before unification') +
  xlim(0,1)+ylim(0,1)

# ggsave(file = "figs/Gini Condensed vs Gini Unified.png")

# PCON Condensed vs PCON unified ----------------------------------------------
ggscatter(gc_pcon_comparison_df,
          x = "pcon_unified", y = "pcon_condensed", add = "reg.line",
          color = "black", shape = 21,size=3) +
  theme_grey() +
  labs(
    title = 'Prostate Contribution (PCON) comparison before and after GTEx unification with TCGA',
    x = 'PCON after unification',
    y = 'PCON before unification') +
  xlim(0,1) + ylim(0,1)

# ggsave(file = "figs/PCON Condensed vs PCON Unified.png")
