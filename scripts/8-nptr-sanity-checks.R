# Load data and packages --------------------------------------------------
library(tidyverse)
library(ggpubr)

gc_pcon_comparison_df <- read_csv("data/processed/gc_pcon_unified_vs_condensed.csv")
load("data/objects/642_nptr_genes.RData")
load("data/objects/301_nptr_genes.RData")

# GC Condensed vs GC unified ----------------------------------------------
gc_pcon_comparison_df %>% 
  ggplot(aes(x=gc_unified,y=gc_condensed)) + 
    geom_point(alpha=0.3) +
    geom_point(data=gc_pcon_comparison_df[gc_pcon_comparison_df$Hugo_Symbol %in% nptr_genes_642,],
               aes(x=gc_unified,y=gc_condensed), 
               color='blue',
               alpha=0.5) +
  geom_point(data=gc_pcon_comparison_df[gc_pcon_comparison_df$Hugo_Symbol %in% nptr_genes_301,],
             aes(x=gc_unified,y=gc_condensed), 
             color='red',
             alpha=0.5) +
  labs(
    title = 'Gini Coefficient Comparison before and after GTEx unification with TCGA',
    subtitle = '1'
    x = 'Gini after unification' ,
    y = 'Gini before unification') +
  xlim(0,1)+ylim(0,1)