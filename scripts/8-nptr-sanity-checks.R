# Load data and packages --------------------------------------------------
library(tidyverse)
library(ggpubr)
library(ggforce)

gc_pcon_comparison_df <- read_csv("data/processed/gc_pcon_unified_vs_condensed.csv")
load("data/objects/642_nptr_genes.RData")
load("data/objects/301_nptr_genes.RData")
load("data/objects/30_nptr_goi.RData")

# GC Condensed vs GC unified ----------------------------------------------
ggplot(gc_pcon_comparison_df, aes(x=gc_unified,y=gc_condensed)) + 
  geom_point(alpha=0.3) + # all genes
  # 642 NPTR gs  
  geom_point(data=gc_pcon_comparison_df[gc_pcon_comparison_df$Hugo_Symbol %in% nptr_genes_642,],
               aes(x=gc_unified,y=gc_condensed), 
               color='blue',
               alpha=0.5) +
  # 301 NPTR gs
  geom_point(data=gc_pcon_comparison_df[gc_pcon_comparison_df$Hugo_Symbol %in% nptr_genes_301,],
             aes(x=gc_unified,y=gc_condensed), 
             color='red',
             alpha=0.5) +
  # 30 NPTR gs
  geom_point(data=gc_pcon_comparison_df[gc_pcon_comparison_df$Hugo_Symbol %in% goi_nptr_30,],
             aes(x=gc_unified,y=gc_condensed), 
             color='green',
             alpha=0.5,
             size = 2,
             show.legend = T) +
  
  labs(
    title = 'Gini Coefficient Comparison before and after GTEx unification with TCGA',
    subtitle = 'Blue: 642 NPTR gs, Red: 301 NPTR gs, Green: 30 NPTR gs',
    x = 'Gini after unification' ,
    y = 'Gini before unification') +
  xlim(0,1)+ylim(0,1)

# ggsave(figs/filename = "GC vs GC comparison, NPTR highlighted.png")

gc_pcon_comparison_df %>% 
  filter(gc_unified > 0.75) %>% 
  filter(gc_condensed <0.75) %>% 
  filter(Hugo_Symbol %in% goi_nptr_30)

# PCON Condensed vs PCON unified ----------------------------------------------
ggplot(gc_pcon_comparison_df, aes(x=pcon_unified ,y=pcon_condensed)) + 
  geom_point(alpha=0.3) + # all genes
  # 642 NPTR gs  
  geom_point(data=gc_pcon_comparison_df[gc_pcon_comparison_df$Hugo_Symbol %in% nptr_genes_642,],
             aes(x=pcon_unified,y=pcon_condensed), 
             color='blue',
             alpha=0.5) +
  # 301 NPTR gs
  geom_point(data=gc_pcon_comparison_df[gc_pcon_comparison_df$Hugo_Symbol %in% nptr_genes_301,],
             aes(x=pcon_unified,y=pcon_condensed), 
             color='red',
             alpha=0.5) +
  # 30 NPTR gs
  geom_point(data=gc_pcon_comparison_df[gc_pcon_comparison_df$Hugo_Symbol %in% goi_nptr_30,],
             aes(x=pcon_unified,y=pcon_condensed), 
             color='green',
             alpha=0.5,
             size = 2,
             show.legend = T) +
  
  labs(
    title = 'PCON Comparison before and after GTEx unification with TCGA',
    subtitle = 'Blue: 642 NPTR gs, Red: 301 NPTR gs, Green: 30 NPTR gs',
    x = 'PCON after unification' ,
    y = 'PCON before unification') +
  facet_zoom(xlim = c(0,0.1),
             ylim = c(0,0.1))

# ggsave(filename = "figs/PCON vs PCON comparison, NPTR highlighted.png")
