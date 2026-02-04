suppressPackageStartupMessages({
  library(TwoSampleMR)
})

harmonise_and_qc <- function(exposure_dat, outcome_dat) {
  dat <- TwoSampleMR::harmonise_data(exposure_dat, outcome_dat)

  # Drop ambiguous palindromic SNPs after harmonisation
  dat <- dat[dat$mr_keep == TRUE, ]

  # Optional: Steiger filtering (directionality)
  dat <- steiger_filter_stub(dat)

  dat
}

steiger_filter_stub <- function(dat) {
  # TwoSampleMR::steiger_filtering(dat) exists, but needs correct sample sizes / trait types.
  stop("steiger_filter_stub(): please decide trait types, sample sizes, and implement Steiger filtering.")
}
