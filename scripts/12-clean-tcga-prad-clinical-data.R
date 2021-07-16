# Load libraries and data------------------------------------------------------
{
library(tidyverse)
library(readxl)
library(ggpubr)
}

# Load data 
{
# Import TCGA clinical data
# Only include sample ID, TNM and Gleason grade columns
# Remove every second row since each row is duplicated
tcga_clinical.path <- "data/raw/TCGA_PRAD_clinical_data.xlsx"
tcga_clinical <- 
  read_xlsx(tcga_clinical.path, col_names = TRUE) %>%
  select(case_submitter_id, ajcc_pathologic_n,
         ajcc_pathologic_t, primary_gleason_grade, secondary_gleason_grade) %>%
  .[seq(1,1000,2),] %>%
  rename(., node_stage = ajcc_pathologic_n) %>%
  rename(., tumour_stage = ajcc_pathologic_t) %>% 
  rename(., sample_id = case_submitter_id)

# Import sample names from TCGA PRAD data
tcga.prad_path <- "../_large-data-files/gtex-tcga-unified/prad-rsem-fpkm-tcga-t.txt"
tcga.prad_samples <- 
  as.character(read.table(tcga.prad_path, sep = "\t", nrows = 1, colClasses ="character")[1,3:428]) %>%
  substr(., 1,12)

# Create set of samples used in GSVA scores
tcga_clinical <- tcga_clinical[tcga_clinical$sample_id %in% tcga.prad_samples,]

# Remove "'--" and replace with NA's
tcga_clinical[tcga_clinical == "'--"] <- NA

# Cleanup
rm(tcga.prad_path,tcga.prad_samples, tcga_clinical.path)
}

# Clean Total Gleason Score ---------------------------------------------------
{
# Sum primary and secondary gleason scores
tcga_clinical$total_gleason_grade <- 
  as.integer(substr(tcga_clinical$primary_gleason_grade, 9,9)) +
  as.integer(substr(tcga_clinical$secondary_gleason_grade, 9,9))

# Combine Gleason Grades 9 and 10 into 9+
tcga_clinical$total_gleason_grade <- as.character(tcga_clinical$total_gleason_grade)
tcga_clinical$total_gleason_grade[tcga_clinical$total_gleason_grade == "9"] <- "9+"
tcga_clinical$total_gleason_grade[tcga_clinical$total_gleason_grade == "10"] <- "9+"
tcga_clinical$total_gleason_grade <- as.factor(tcga_clinical$total_gleason_grade)

# Remove primary and secondary gleason columns
tcga_clinical <- select(tcga_clinical, -c(primary_gleason_grade, secondary_gleason_grade))
}

# Cancer Staging --------------------------------------------------------------
## Replace stage code with integers
{
  tcga_clinical$tumour_stage <- if(!is.na(tcga_clinical$tumour_stage)){substr(tcga_clinical$tumour_stage, 2,2)}
  tcga_clinical$node_stage <- if(!is.na(tcga_clinical$node_stage)){substr(tcga_clinical$node_stage, 2,2)}
}

write_csv(tcga_clinical, file = "data/processed/tcga_prad_clinical_clean_tnm_&_gleason.csv")


# Total Gleason Grade Distribution
ggplot(tcga_clinical, aes(total_gleason_grade)) + 
  geom_bar(stat = "count", colour = "black", fill = "white") + 
  stat_count(geom = "text", aes(label = ..count..),position=position_stack(vjust=0.5)) +
  ggtitle("Distribution of Gleason Grades in TCGA PRAD samples (426)") +
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title = element_text(size = 14)) +
  labs(x = "Gleason Grade", y = "Frequency")
  

