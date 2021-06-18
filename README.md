# Ectopic Expression of tissue-restricted transcripts in prostate cancer
Repository to store all work performed for the MC-SCBIF Research Project with Dr. David Goode at Peter MacCallum Cancer Centre

### Raw Datasets Used
- GTEx Median gene-level TPM by tissue: [Link](https://www.gtexportal.org/home/datasets)
- Data Record 3 from Wang *et al.* (2018)
  - [Article](https://www.nature.com/articles/sdata201861)
  - [Data](https://figshare.com/articles/dataset/Data_record_3/5330593)
  
Wang, Q., Armenia, J., Zhang, C. *et al.* Unifying cancer and normal RNA sequencing data from different sources. *Sci Data* **5,** 180061 (2018). https://doi.org/10.1038/sdata.2018.61

### To do next
- 4-identify-nptr

## Output Summary

| **Output Type** | **Output**                                | **Script #** |
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

