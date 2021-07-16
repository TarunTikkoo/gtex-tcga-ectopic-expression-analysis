# Load packages and data --------------------------------------------------

library(tidyverse)
library(GSVA)

load("data/objects/nptr_gene_sets_list.RData")

unified_tcga_prad_path <- "../_large-data-files/gtex-tcga-unified/prad-rsem-fpkm-tcga-t.txt"
unified_tcga_prad <- as.matrix(read.table(unified_tcga_prad_path, 
                                  sep = "\t",
                                  header = TRUE,
                                  row.names = 1))
unified_tcga_prad <- unified_tcga_prad[,-1] # remove Entrez Gene ID

# Cleanup
rm(unified_tcga_prad_path)
# GSVA --------------------------------------------------------------------

unified_tcga_prad_gsva <- as.data.frame(t(gsva(as.matrix(unified_tcga_prad), 
                                               nptr.gs, mx.diff = TRUE)))

# Convert GSVA scores to long format for violin plot
{
unified_tcga_prad_gsva_long <- unified_tcga_prad_gsva %>% 
  mutate(sample_id = row.names(.)) %>% 
  pivot_longer(cols = 1:6,names_to = "gene_set", values_to = "gsva_score") %>% 
  mutate(gene_set = factor(gene_set, levels = c("full_gene_set", 
                                                "642_NPTR",
                                                "301_NPTR", 
                                                "30_GOI",
                                                "liver_subset",
                                                "easophagus_subset")))

unified_tcga_prad_gsva_long$gene_set <-
  recode(unified_tcga_prad_gsva_long$gene_set,
         full_gene_set = "Full Gene List",
         `642_NPTR` = "642 NPTR Genes",
         `301_NPTR` = "305 NPTR Genes",
         `liver_subset` = "Liver Genes",
         `easophagus_subset` = "Easophagus Genes",
         `30_GOI` = "30 NPTR GOI")
}

# save(unified_tcga_prad_gsva_long, file = "data/objects/unified_tcga_prad_gsva_long.RData")

# Violin Plot -------------------------------------------------------------

ggplot(unified_tcga_prad_gsva_long, aes(x = gene_set, y = gsva_score)) +
  geom_violin(trim = FALSE) +
  labs(x = "Gene Set", y = "GSVA Score", title = "GSVA scores of TCGA PRAD Samples by Gene Sets") +
  geom_boxplot(width = 0.1) +
  theme(axis.text.x = element_text(size = 12, angle = 30, hjust = 1),
        axis.text.y = element_text(size = 12),
        axis.title = element_text(size = 14))

# ggsave(file = "figs/GSVA scores of TCGA PRAD Samples by Gene Sets.png")
