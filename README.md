# Ectopic Expression of tissue-restricted transcripts in prostate cancer
Repository to store all work performed for the MC-SCBIF Research Project with Dr. David Goode at Peter MacCallum Cancer Centre

### Raw Datasets Used
- GTEx Median gene-level TPM by tissue: [Link](https://www.gtexportal.org/home/datasets)
  - Subtissues from this dataset were condensed into a single tissue using the max expression across subtissues. Therefore, this dataset will be referred to as the "Condensed GTEX" set in this project.
- Data Record 3 from Wang *et al.* (2018)
  - [Article](https://www.nature.com/articles/sdata201861)
  - [Data](https://figshare.com/articles/dataset/Data_record_3/5330593)
  - This set will be referred as the "unified GTEx" dataset
  
Wang, Q., Armenia, J., Zhang, C. *et al.* Unifying cancer and normal RNA sequencing data from different sources. *Sci Data* **5**, 180061 (2018). https://doi.org/10.1038/sdata.2018.61

### To do next
- 8-nptr-sanity-check
  - branch script to try to add legend for NPTR gene sets. Some ideas [here](https://stackoverflow.com/questions/17713919/two-geom-points-add-a-legend)
- 11-gsva-combined
  - remove separate gsva data scripts
  - fix order of violin plot x axis
- 12-clean-clinical-data
- 13-gsva-by-clinical

## Data Output Summary

| **Script #** | **Location**   | **Output**                                    |                  **Description**                                   |
|:------------:|----------------|-----------------------------------------------|--------------------------------------------------------------------|
| 0            | data/processed | gtex_tpm_condensed.csv                        | Condensed version of GTEx median dataset (in TPM)                  |
| 1            | data/processed | gtex-unified-(gtex+prad-genes-only).csv       | Median gene expression of GTEx unified dataset (FPKM)              |
| 1            | data/processed | prad-unified-(gtex+prad-genes-only).csv       | Median gene expression of TCGA PRAD tumour unified dataset (FPKM)  |
| 2            | data/processed | gtex_condensed_pcon_gini.csv                  | PCON, GC of GTEx median dataset genes                              |
| 2            | data/processed | gtex_unified_pcon_gini.csv                    | PCON, GC of unified GTEx genes                                     |
| 3            | data/processed | gc_pcon_unified_vs_condensed.csv              | PCON, GC comparison between unified and condensed GTEx data        |
| 4            | data/objects   | 642_nptr_genes.RData                          | List of 642 NPTR genes                                             |
| 5            | data/processed | 642_nptr_genes_gtex_dataset.csv               | Gene expression of 642 NPTR GTEx unified genes                     |
| 5            | data/processed | 301_nptr_genes_gtex_dataset.csv               | Gene expression of 301 NPTR GTEx unified genes                     |
| 5            | data/objects   | 301_nptr_genes.RData                          | List of 301 NPTR genes                                             |
| 6            | data/processed | nptr_prad_unified_301.csv                     | Expression of 301 NPTR genes in TCGA PRAD tumour dataset           |
| 6            | data/processed | nptr_prad_unified_642.csv                     | Expression of 642 NPTR genes in TCGA PRAD tumour dataset           |
| 7            | data/objects   | 30_nptr_goi.RData                             | List of 30 NPTR genes of interest                                  |
| 9            | data/objects   | gtex_unified_301_max_tissues.RData            | 301 NPTR genes and source tissue of max expression                 |
| 10           | data/objects   | nptr_gene_sets_list.RData                     | List object with 642, 301, 30 NPTR and liver, easophagus subsets   |
<<<<<<< HEAD
| 11           | data/processed | prad_prostate_gsva_scores_by_genesets.csv     | GSVA Scores of TCGA PRAD and GTEx Prostate samples by genesets     |
| 12           | data/processed | tcga_prad_clinical_clean_tnm_&_gleason.csv    | Cleaned clinical data gleason and TNM scores altered to integers  | 

## Figures Summary

| **Script #** | **Output**                                                             |                  **Description**                                        |
|:------------:|------------------------------------------------------------------------|-------------------------------------------------------------------------|
| 2            | PCON vs Gini - GTEx condensed dataset.png                              | PCON vs GC plot - GTEx condensed dataset                                |
| 2            | PCON vs Gini - GTEx unified dataset.png                                | PCON vs GC plot - GTEx unified dataset                                  |
| 3            | Gini Condensed vs Gini Unified.png                                     | GC vs GC comparison plot of condensed and unified GTEx data             |
| 3            | PCON Condensed vs PCON Unified.png                                     | PCON vs PCON comparison plot of condensed and unified GTEx data         |
| 7            | dendrogram-301-nptr-gs-in-prad.png                                     | Hierarchical clustered dendrogram of NPTR genes in unified PRAD         |
| 7            | dendrogram-30-nptr-goi-in-prad.png                                     | Dendrogram of NPTR genes in unified PRAD (zoomed to 30 GOI)             |
| 8            | GC vs GC comparison, NPTR highlighted.png                              | Sanity check of NPTR Gini Coefficients before and after unification     |
| 8            | PCON vs PCON comparison, NPTR highlighted.png                          | Sanity check of NPTR PCON before and after unification                  |
| 9            | NPTR Source Tissue Count of 642 NPTR genes.png                         |                                                                         |
| 9            | NPTR Source Tissue Count of 301 NPTR genes.png                         |                                                                         |
| 9            | NPTR Source Tissue Count of 30 NPTR genes.png                          |                                                                         |
| 11           | GSVA scores of Prostate Normal and PRAD Tumour Samples by Gene Sets.png|                                                                         |
| 13           | GSVA scores by Gleason Grade and Gene Sets.png                         |                                                                         |
| 13           | GSVA scores by Node Stage of Gene Sets                                 |                                                                         |
=======
| 11           | data/objects   | unified_gtex_prostate_samples_gsva_long.RData | GSVA scores for unified GTEx prostate samples by gene set          |
| 12           | data/objects   | unified_tcga_prad_samples_gsva_long.RData     | GSVA scores for unified TCGA PRAD samples by gene set              |


## Figures Summary

| **Script #** | **Folder**   | **Output**                                           |                  **Description**                                        |
|:------------:|--------------|------------------------------------------------------|-------------------------------------------------------------------------|
| 2            | figs         | PCON vs Gini - GTEx condensed dataset.png            | PCON vs GC plot - GTEx condensed dataset                                |
| 2            | figs         | PCON vs Gini - GTEx unified dataset.png              | PCON vs GC plot - GTEx unified dataset                                  |
| 3            | figs         | Gini Condensed vs Gini Unified.png                   | GC vs GC comparison plot of condensed and unified GTEx data             |
| 3            | figs         | PCON Condensed vs PCON Unified.png                   | PCON vs PCON comparison plot of condensed and unified GTEx data         |
| 7            | figs         | dendrogram-301-nptr-gs-in-prad.png                   | Hierarchical clustered dendrogram of NPTR genes in unified PRAD         |
| 7            | figs         | dendrogram-30-nptr-goi-in-prad.png                   | Dendrogram of NPTR genes in unified PRAD (zoomed to 30 GOI)             |
| 8            | figs         | GC vs GC comparison, NPTR highlighted.png            | Sanity check of NPTR Gini Coefficients before and after unification     |
| 8            | figs         | PCON vs PCON comparison, NPTR highlighted.png        | Sanity check of NPTR PCON before and after unification                  |
| 9            | figs         | NPTR Source Tissue Count of 642 NPTR genes.png       |                                                                         |
| 9            | figs         | NPTR Source Tissue Count of 301 NPTR genes.png       |                                                                         |
| 9            | figs         | NPTR Source Tissue Count of 30 NPTR genes.png        |                                                                         |
| 11           | figs         | GSVA scores of GTEx Prostate Samples by Gene Sets.png| Violin plot of GSVA scores of unified GTEx prostate samples by gene set |
| 12           | figs         | GSVA scores of TCGA PRAD Samples by Gene Sets.png    | Violin plot of GSVA scores of unified TCGA PRAD samples by gene set     |
>>>>>>> 597b9cdae49556ef1aab1a142a488b43f07eead9
