# Load data and packages --------------------------------------------------

library(tidyverse)
{
# Unified GTEx prostate samples
prostate.gtex <- read.table("../_large-data-files/gtex-tcga-unified/prostate-rsem-fpkm-gtex.txt",
                            header = T,
                            row.names = 1) %>%
  subset(., select=-1)

# Unified TCGA PRAD samples
prad.tcga_path <- "../_large-data-files/gtex-tcga-unified/prad-rsem-fpkm-tcga-t.txt"
prad.tcga <- as.matrix(read.table(prad.tcga_path, 
                                  sep = "\t",
                                  header = TRUE,
                                  row.names = 1))
prad.tcga <- prad.tcga[,-1]

# Merge prostate and PRAD data by gene name
prad_pros_merged <- merge(prostate.gtex, prad.tcga, by = 0)
row.names(prad_pros_merged) <- prad_pros_merged$Row.names
prad_pros_merged$Row.names <- NULL

# Load gene sets for GSVA scoring
load("data/objects/nptr_gene_sets_list.RData")

# GSVA Scoring ------------------------------------------------------------

# prad_pros_gsva <- as.data.frame(t(gsva(as.matrix(prad_pros_merged), nptr.gs, mx.diff = TRUE)))
# save(prad_pros_gsva, file = "data/objects/prad_pros_gsva.RData")
load("data/objects/prad_pros_gsva.RData")

# Cleanup
rm(prad_pros_merged, prad.tcga, prostate.gtex, prad.tcga_path)
}

# Data wrangling ----------------------------------------------------------

{
prad_pros_gsva$sample_id <- row.names(prad_pros_gsva)
row.names(prad_pros_gsva) <- NULL
prad_pros_gsva$sample_type <- if_else(startsWith(prad_pros_gsva$sample_id, "GTEX"), "Normal", "Tumour")
prad_pros_gsva <- pivot_longer(prad_pros_gsva, cols = 1:6, names_to = "gene_set", values_to = "gsva_score")
prad_pros_gsva$sample_type <- factor(prad_pros_gsva$sample_type, levels = c("Normal", "Tumour"))
prad_pros_gsva$gene_set <- 
  recode_factor(prad_pros_gsva$gene_set,
         full_gene_set = "Full Gene List",
         `642_NPTR` = "642 NPTR Genes",
         `301_NPTR` = "301 NPTR Genes",
         `liver_subset` = "Liver Genes",
         `easophagus_subset` = "Easophagus Genes",
         `30_GOI` = "30 NPTR GOI",
         .ordered = TRUE)
}

write.csv(prad_pros_gsva, "data/processed/prad_prostate_gsva_scores_by_genesets.csv")

# Violin Plot -------------------------------------------------------------

ggplot(prad_pros_gsva, aes(x = gene_set, y = gsva_score,  fill = sample_type)) +
  geom_violin(trim = F, alpha = 0.5,
              # position = position_nudge() # comment this line to change from overlapped to separated violin plots
              ) +
  labs(x = "Gene Set", y = "GSVA Score", title = "GSVA scores of Prostate Normal and PRAD Tumour Samples by Gene Sets") +
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 12),
        axis.title = element_text(size = 14)) +
  scale_fill_discrete(name = "")

# ggsave(filename = "figs/GSVA scores of Prostate Normal and PRAD Tumour Samples by Gene Sets.png")
