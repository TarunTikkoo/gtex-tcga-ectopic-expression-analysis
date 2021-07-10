# Load data and packages --------------------------------------------------
{
library(tidyverse)
library(ggpubr)

gtex_unified_642 <- read_csv("data/processed/642_nptr_genes_gtex_dataset.csv") %>% 
              select(-1)
gtex_unified_301 <- read_csv("data/processed/301_nptr_genes_gtex_dataset.csv") %>% 
  select(-1)

load("data/objects/30_nptr_goi.RData")
gtex_unified_30_goi <- gtex_unified_642 %>% 
  filter(Hugo_Symbol %in% goi_nptr_30)
}                        

# Tissue Count for 642 NPTR -----------------------------------------------
{
gtex_unified_642.max.tissues <- cbind(gtex_unified_642[1], colnames(gtex_unified_642)[max.col(gtex_unified_642[2:14], "first")+1])
colnames(gtex_unified_642.max.tissues)[2] <- "tissues"

ggplot(gtex_unified_642.max.tissues, aes(tissues)) + 
  geom_bar(color = 'black', fill = 'white') +
  labs(title = 'NPTR Source Tissue Count of 642 NPTR genes',
       x = 'Tissues',
       y = 'Counts') +
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 12),
        axis.title = element_text(size = 14))

# ggsave(filename = "figs/NPTR Source Tissue Count of 642 NPTR genes.png")
}

# Tissue Count for 301 NPTR -----------------------------------------------
{
gtex_unified_301.max.tissues <- cbind(gtex_unified_301[1], colnames(gtex_unified_301)[max.col(gtex_unified_301[2:14], "first")+1])
colnames(gtex_unified_301.max.tissues)[2] <- "tissues"
save(gtex_unified_301.max.tissues, file = "data/objects/gtex_unified_301_max_tissues.RData")

ggplot(gtex_unified_301.max.tissues, aes(tissues)) + 
  geom_bar(color = 'black', fill = 'white') +
  labs(title = 'NPTR Source Tissue Count of 301 NPTR genes',
       x = 'Tissues',
       y = 'Counts') +
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 12),
        axis.title = element_text(size = 14))

# ggsave(filename = "figs/NPTR Source Tissue Count of 301 NPTR genes.png")
}

# Tissue Count for 30 GOI NPTR --------------------------------------------
{
gtex_unified_30_goi.max.tissues <- cbind(gtex_unified_30_goi[1], colnames(gtex_unified_30_goi)[max.col(gtex_unified_30_goi[2:14], "first")+1])
colnames(gtex_unified_30_goi.max.tissues)[2] <- "tissues"

ggplot(gtex_unified_30_goi.max.tissues, aes(tissues)) + 
  geom_bar(color = 'black', fill = 'white') +
  labs(title = 'NPTR Source Tissue Count of 30 GOI NPTR genes.png',
       x = 'Tissues',
       y = 'Counts') +
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 12),
        axis.title = element_text(size = 14))

# ggsave(filename = "figs/NPTR Source Tissue Count of 30 GOI NPTR genes.png")
}
