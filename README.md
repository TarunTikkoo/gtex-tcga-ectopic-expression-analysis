# Ectopic Expression of tissue-restricted transcripts in prostate cancer
Repository to store all work performed for the MC-SCBIF Research Project with Dr. David Goode at Peter MacCallum Cancer Centre

### Raw Datasets Used
- GTEx Median gene-level TPM by tissue: [Link](https://www.gtexportal.org/home/datasets)
  - Subtissues from this dataset were condensed into a single tissue using the max expression across subtissues. Therefore, this dataset will be referred to as the "Condensed GTEX" set in this project.
- Data Record 3 from Wang *et al.* (2018)
  - [Article](https://www.nature.com/articles/sdata201861)
  - [Data](https://figshare.com/articles/dataset/Data_record_3/5330593)
  - This set will be referred as the "unified GTEx" dataset
  
Wang, Q., Armenia, J., Zhang, C. *et al.* Unifying cancer and normal RNA sequencing data from different sources. *Sci Data* **5,** 180061 (2018). https://doi.org/10.1038/sdata.2018.61

### To do next
- Update Output Summary Table
- Find 30 GOI subset from Heatmap
- 6-Analyse NPTR
  - Check NPTR genes location in GC vs GC and PCON vs PCON
    - 3 seperate colours, one for 642 set, one for 301 set and one for 30 goi set

## Output Summary

| **Location**    | **Output**                                | **Script #** |
|-----------------|-------------------------------------------|--------------|
| data/processed  | gtex_tpm_condensed.csv                    | 0            |
| data/processed  | gtex-unified-(gtex+prad-genes-only).csv   | 1            |
| data/processed  | prad-unified-(gtex+prad-genes-only).csv   | 1            |
| data/processed  | gtex_condensed_pcon_gini.csv              | 2            |
| data/processed  | gtex_unified_pcon_gini.csv                | 2            |
| figs            | PCON vs Gini - GTEx condensed dataset.png | 2            |
| figs            | PCON vs Gini - GTEx unified dataset.png   | 2            |
| figs            | Gini Condensed vs Gini Unified.png        | 3            |
| figs            | PCON Condensed vs PCON Unified.png        | 3            |
| data/processed  | gc_pcon_unified_vs_condensed.csv          | 3            |
| data/processed  | nptr_genes_unified_dataset.csv            | 4            |
| data/objects    | 642_nptr_genes.RData                      | 4            |
| data/processed  | 301_nptr_genes_unified_dataset.csv        | 5            |
| data/objects    | 301_nptr_genes.RData                      | 5            |

