# Load packages and data ----------------------------------------------------
{
library(tidyverse)
library(GSVA)
library(stats)

# NPTR Gene sets on which GSVA will be performed
load("data/objects/nptr_gene_sets_list.RData")

unified_gtex_prostate_samples_path <- "../_large-data-files/gtex-tcga-unified/prostate-rsem-fpkm-gtex.txt"
unified_gtex_prostate_samples <-
  read.table(unified_gtex_prostate_samples_path,
             header = T,
             row.names = 1) %>%
  subset(., select=-1)
rm(unified_gtex_prostate_samples_path)

}

# GSVA Scores -------------------------------------------------------------
# GSVA score calculations
unified_gtex_prostate_samples_gsva <- as.data.frame(t(gsva(as.matrix(unified_gtex_prostate_samples), nptr.gs, mx.diff = TRUE)))

# Convert GSVA scores to long format for violin plot
{
unified_gtex_prostate_samples_gsva_long <- unified_gtex_prostate_samples_gsva %>% 
  mutate(sample_id = row.names(.)) %>% 
  pivot_longer(cols = 1:6,names_to = "gene_set", values_to = "gsva_score") %>% 
  mutate(gene_set = factor(gene_set, levels = c("full_gene_set", 
                                                "642_NPTR",
                                                "301_NPTR", 
                                                "30_GOI",
                                                "liver_subset",
                                                "easophagus_subset")))

unified_gtex_prostate_samples_gsva_long$gene_set <-
  recode(unified_gtex_prostate_samples_gsva_long$gene_set,
         full_gene_set = "Full Gene List",
         `642_NPTR` = "642 NPTR Genes",
         `301_NPTR` = "305 NPTR Genes",
         `liver_subset` = "Liver Genes",
         `easophagus_subset` = "Easophagus Genes",
         `30_GOI` = "30 NPTR GOI")
}

# save(unified_gtex_prostate_samples_gsva_long, file = "data/objects/unified_gtex_prostate_samples_gsva_long.RData")

# Violin Plot -------------------------------------------------------------
ggplot(unified_gtex_prostate_samples_gsva_long, aes(x = gene_set, y = gsva_score)) +
  geom_violin(trim = FALSE) +
  labs(x = "Gene Set", y = "GSVA Score", title = "GSVA scores of GTEx Prostate Samples by Gene Sets") +
  geom_boxplot(width = 0.1) +
  theme(axis.text.x = element_text(size = 12, angle = 30, hjust = 1),
        axis.text.y = element_text(size = 12),
        axis.title = element_text(size = 14))

# ggsave(file = "figs/GSVA scores of GTEx Prostate Samples by Gene Sets.png")

# Histograms -------------------------------------------------------------
# Simply here for extra reference - not output as they show the same information
# as violin plots
{
par(mfrow=c(3,2))
hist(unified_gtex_prostate_samples_gsva[,1], main = "Full Gene Set", xlim = c(-0.75, 0.75), ylim = c(0,5), freq = F, xlab=NULL)
hist(unified_gtex_prostate_samples_gsva[,2], main = "642 NPTR", xlim = c(-0.75, 0.75), ylim = c(0,5), freq = F, xlab=NULL)
hist(unified_gtex_prostate_samples_gsva[,3], main = "301 NPTR", xlim = c(-0.75, 0.75), ylim = c(0,5), freq = F, xlab=NULL)
hist(unified_gtex_prostate_samples_gsva[,4], main = "30 GOI", xlim = c(-0.75, 0.75), ylim = c(0,5), freq = F, xlab=NULL)
hist(unified_gtex_prostate_samples_gsva[,5], main = "Liver Subset", xlim = c(-0.75, 0.75), ylim = c(0,5), freq = F, xlab=NULL)
hist(unified_gtex_prostate_samples_gsva[,6], main = "Easophagus Subset", xlim = c(-0.75, 0.75), ylim = c(0,5), freq = F, xlab=NULL)
mtext('GSVA Score Distributions', outer = TRUE, cex = 1.5, line = -1.9)
}