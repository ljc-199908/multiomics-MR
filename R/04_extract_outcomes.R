suppressPackageStartupMessages({
  library(TwoSampleMR)
})

extract_outcome_opengwas <- function(snps, outcome_id) {
  # This will work only if user has valid token & internet access.
  # Keep it as-is, but README should warn about API limits.
  TwoSampleMR::extract_outcome_data(snps = snps, outcomes = outcome_id)
}

read_outcome_local <- function(file, colmap, sep="\t") {
  stop("Please implement local outcome reader based on your file format.")
}
