# Load packages and data --------------------------------------------------

library(tidyverse)
library(reldist) # For Gini Coefficient

# Import condensed gtex, drop Entrez Gene ID
path_gtex_condensed <- "data/processed/gtex_tpm_condensed.csv"
gtex_condensed <- read.csv(path_gtex_condensed) %>% 
  select(-1) %>% 
  rename(Hugo_Symbol = Description)

# Unified GTEx data
path_gtex_unified <- "data/processed/gtex-unified-(gtex+prad-genes-only).csv"
gtex_unified <- read.csv(path_gtex_unified)

# Clean up
rm(path_gtex_condensed, path_gtex_unified)

# Condensed data: GC and PCON ---------------------------------------------

# Calculate median exp and prostate contribution
# remove genes with 0 expression across all tissues
gtex_condensed <-
  gtex_condensed %>%
  mutate(
    median_exp = rowMedians(as.matrix(.[2:31])),
    # Num_Contrib = rowSums(.[2:31] != 0),
    # maxvals_TPM = rowMaxs(as.matrix(.[2:31  ])),
    total_exp = rowSums(.[2:31]),
    pcon = Prostate / total_exp) %>%
  filter(total_exp > 0)

# Calculated GC
gtex_condensed <- gtex_condensed %>%
  mutate(gini_coeff = apply(gtex_condensed[2:31],1,function(x) gini(x)))

ggplot(data = gtex_condensed, 
       mapping = aes(x = gini_coeff, y = pcon)) +
  geom_point() +
  labs(title = 'Prostate Contribution vs Gini Coeffecient of each gene in the GTEx Condensed dataset',
       x = 'Gini Coefficient',
       y = 'Prostate Contribution')

# ggsave(filename = "figs/PCON vs Gini - GTEx condensed dataset.png")

# Unified data: GC and PCON ---------------------------------------------

# Calculate median exp and prostate contribution
# remove genes with 0 expression across all tissues
gtex_unified <-
  gtex_unified %>%
  mutate(
         median_exp = rowMedians(as.matrix(.[2:14])),
         # Num_Contrib = rowSums(.[2:14] != 0),
         # maxvals_TPM = rowMaxs(as.matrix(.[2:14])),
         total_exp = rowSums(.[2:14]),
         pcon = prostate / total_exp) %>%
  filter(total_exp > 0)

# Calculated GC
gtex_unified <- gtex_unified %>%
  mutate(gini_coeff = apply(gtex_unified[2:14],1,function(x) gini(x)))

ggplot(data = gtex_unified, 
       mapping = aes(x = gini_coeff, y = pcon)) +
  geom_point() +
  labs(title = 'Prostate Contribution vs Gini Coeffecient of each gene in the Unified GTEx dataset',
       x = 'Gini Coefficient',
       y = 'Prostate Contribution')

# ggsave(filename = "figs/PCON vs Gini - GTEx unified dataset.png")


# Export GC,PCON Data -----------------------------------------------------
gtex_condensed %>% 
  select(Hugo_Symbol, pcon, gini_coeff) %>% 
  write.csv(.,
            file = "data/processed/gtex_condensed_pcon_gini.csv",
            row.names = F)

gtex_unified %>% 
  select(Hugo_Symbol, pcon, gini_coeff) %>% 
  write.csv(.,
            file = "data/processed/gtex_unified_pcon_gini.csv",
            row.names = F)
