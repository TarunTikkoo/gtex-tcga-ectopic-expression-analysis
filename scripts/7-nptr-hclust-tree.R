# Load data --------------------------------------------------
library(tidyverse)

nptr_prad_unified_301 <- read_csv("data/processed/nptr_prad_unified_301.csv")

# log-transform
log.nptr_prad_unified_301 <- 
  as.data.frame(cbind(nptr_prad_unified_301[1], # gene names
                      log(0.01 + nptr_prad_unified_301[-1], 10))) %>%  # log transform
  column_to_rownames(var = "Hugo_Symbol")
  

# Clustering and cutting tree  --------------------------------------------
# Hierarchical clustering dendrogram of scaled gene expression
nptr_hclust <- as.dendrogram(hclust(dist(log.nptr_prad_unified_301)))

plot(nptr_hclust, 
     type = "rectangle", 
     ylab = "Height", 
     leaflab = "none",
     main = "Dendrogram of clustered 301 NPTR gs in unified TCGA PRAD samples")
# ggsave(filename = "figs/dendrogram-301-nptr-gs-in-prad.png")


# Zoom in on subset
plot(nptr_hclust[[1]], 
     type = "rectangle", 
     xlab = "Height",
     nodePar = list(lab.cex = 0.75, pch = NA, col = "blue"),
     horiz = TRUE,
     main = "Dendrogram of clustered 301 NPTR genes (zoomed to 30 GOI, rotated)")
# ggsave(filename = "figs/dendrogram-30-nptr-goi-in-prad.png")


# Extract genes of interest -----------------------------------------------
# save list of 30 goi
goi_nptr_30 <- labels(nptr_hclust[[1]])
save(goi_nptr_30, file = "data/objects/30_nptr_goi.RData")

