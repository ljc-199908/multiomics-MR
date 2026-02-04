suppressPackageStartupMessages({
  library(data.table)
})

flag_mhc <- function(chr, pos) {
  # MHC region: chr6: 26-34Mb
  (chr == 6L) & (pos >= 26000000L) & (pos <= 34000000L)
}

calc_F_stat <- function(beta, se) (beta^2) / (se^2)

filter_instruments <- function(exposure_dat, cfg) {
  dt <- as.data.table(exposure_dat)

  # Require P threshold
  dt <- dt[pval.exposure < cfg$p_threshold]

  # Optional: exclude MHC (requires chr/pos; user must provide or annotate)
  if (isTRUE(cfg$exclude_mhc)) {
    if (!all(c("chr.exposure","pos.exposure") %in% names(dt))) {
      stop("Missing chr.exposure/pos.exposure for MHC exclusion. Please annotate coordinates first.")
    }
    dt <- dt[!flag_mhc(chr.exposure, pos.exposure)]
  }

  # Remove ambiguous palindromes (TwoSampleMR marks in harmonise step, but allow early filtering)
  # Here we only provide a placeholder to force user to decide.
  if (isTRUE(cfg$remove_palindromic_ambiguous)) {
    message("NOTE: palindromic ambiguity filtering should be applied after harmonise_data().")
  }

  # F statistic
  dt[, F := calc_F_stat(beta.exposure, se.exposure)]
  dt <- dt[F >= cfg$min_F]

  # PhenoScanner confounder filtering (left as stub intentionally)
  # Implementations differ; user must decide confounder list / API.
  dt <- phenoscanner_filter_stub(dt, p_cutoff = cfg$phenoscanner_p)

  dt[]
}

phenoscanner_filter_stub <- function(dt, p_cutoff=1e-5) {
  # Intentionally NOT implemented: requires external querying strategy and confounder definitions.
  # Users should implement:
  #  - query SNPs in PhenoScanner
  #  - drop SNPs associated with confounders (education, smoking, etc.)
  stop("phenoscanner_filter_stub(): please implement confounder filtering for your study.")
}
