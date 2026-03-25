#!/usr/bin/env Rscript

# =========================================================
# Example script: generate harmonised data from OpenGWAS
# =========================================================

suppressPackageStartupMessages({
  library(TwoSampleMR)
  library(dplyr)
})

# ---------------------------
# 1. Define exposure SNPs
# ---------------------------
# Example: use SNPs from exposure_dat2 (replace with your own)
# Here we assume exposure_dat2 already exists or load it

# load("exposure_dat2.RData")  # uncomment if needed

if (!exists("exposure_dat2")) {
  stop("Please provide exposure_dat2 with SNP column")
}

snps <- exposure_dat2$SNP

# ---------------------------
# 2. Define outcome IDs
# ---------------------------
outcomes <- c(
  "ebi-a-GCST90018788",
  "ebi-a-GCST90018820",
  "ebi-a-GCST90018866",
  "ebi-a-GCST010005"
)

# ---------------------------
# 3. Extract outcome data
# ---------------------------
outcome_dat_list <- lapply(outcomes, function(outcome_id) {
  message("Processing outcome: ", outcome_id)
  
  tryCatch({
    extract_outcome_data(
      snps = snps,
      outcomes = outcome_id
    )
  }, error = function(e) {
    message("Failed: ", outcome_id)
    return(NULL)
  })
})

# 合并结果
outcome_dat <- bind_rows(outcome_dat_list)

# ---------------------------
# 4. Harmonise data
# ---------------------------
dat <- harmonise_data(
  exposure_dat = exposure_dat2,
  outcome_dat  = outcome_dat
)

# ---------------------------
# 5. Save example output
# ---------------------------
dir.create("data", showWarnings = FALSE)

write.table(
  head(dat, 100),
  file = "data/example_harmonised_data_generated.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)

# ---------------------------
# 6. Done
# ---------------------------
cat("Example harmonisation complete.\n")
cat("Output saved to: data/example_harmonised_data_generated.tsv\n")
