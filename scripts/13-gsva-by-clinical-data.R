# Load data and libraries ----------------------------------------------------
{
library(tidyverse)
library(readxl)
}

prad_pros_gsva_by_genesets <- read_csv("data/processed/prad_prostate_gsva_scores_by_genesets.csv") %>% 
  select(-1) %>% 
  filter(sample_type == "Tumour")

prad_pros_gsva_by_genesets$sample_id <- substr(prad_pros_gsva_by_genesets$sample_id, 1, 12)
prad_pros_gsva_by_genesets$sample_id <- str_replace_all(prad_pros_gsva_by_genesets$sample_id, "[.]", "-")


tcga_clinical <- read_csv("data/processed/tcga_prad_clinical_clean_tnm_&_gleason.csv")

tcga_clinical_gsva <- left_join(tcga_clinical, prad_pros_gsva_by_genesets, by = "sample_id")
tcga_clinical_gsva$gene_set <- factor(tcga_clinical_gsva$gene_set)
tcga_clinical_gsva$gene_set <- recode_factor(tcga_clinical_gsva$gene_set,
                                    `Full Gene List` = "Full Gene List",
                                    `642 NPTR Genes` = "642 NPTR Genes",
                                    `301 NPTR Genes` = "301 NPTR Genes",
                                    `Easophagus Genes` = "Easophagus Genes",
                                    `Liver Genes` = "Liver Genes",
                                    `30 NPTR GOI` = "30 NPTR GOI")


# Violin Plots ------------------------------------------------------------
## GSVA scores vs Gleason Score

tcga_clinical_gsva %>%
  ggplot(., aes(x = total_gleason_grade, y = gsva_score)) +
  geom_violin(trim = FALSE) +
  labs(x = "Gleason Grade", y = "GSVA Score", title = "GSVA scores by Gleason Grade of Gene Sets") +
  facet_wrap(~ gene_set)  +
  geom_boxplot(width = 0.1) +
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title = element_text(size = 14))

# ggsave(filename = "GSVA scores by Gleason Grade and Gene Sets.png")


## GSVA scores vs Tumour Stage
tcga_clinical_gsva %>%
  ggplot(., aes(x = as.character(tumour_stage), y = gsva_score)) +
  geom_violin(trim = FALSE) +
  labs(x = "Tumour Stage", y = "GSVA Score", title = "GSVA scores by Tumour Stage of Gene Sets") +
  facet_wrap(~ gene_set)  +
  geom_boxplot(width = 0.1)

# ggsave(filename = "GSVA scores by Tumour Stage of Gene Sets.png")


## GSVA scores vs Node Stage
tcga_clinical_gsva %>%
  ggplot(., aes(x = as.character(node_stage), y = gsva_score)) +
  geom_violin(trim = FALSE) +
  labs(x = "Node Stage", y = "GSVA Score", title = "GSVA scores by Node Stage of Gene Sets") +
  facet_wrap(~ gene_set)  +
  geom_boxplot(width = 0.1)

# ggsave(filename = "GSVA scores by Node Stage of Gene Sets.png")
