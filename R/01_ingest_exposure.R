suppressPackageStartupMessages({
  library(data.table)
  library(dplyr)
  library(TwoSampleMR)
})

# This function intentionally requires a column map from user.
read_exposure_generic <- function(file, colmap, sep="\t", exposure_label=NULL) {
  stopifnot(file.exists(file))
  required_keys <- c("snp","beta","se","ea","oa","eaf","pval","samplesize","phenotype")
  missing <- setdiff(required_keys, names(colmap))
  if (length(missing) > 0) stop("colmap missing keys: ", paste(missing, collapse=", "))

  dat <- TwoSampleMR::read_exposure_data(
    filename = file,
    sep = sep,
    clump = FALSE,
    snp_col = colmap$snp,
    beta_col = colmap$beta,
    se_col = colmap$se,
    effect_allele_col = colmap$ea,
    other_allele_col  = colmap$oa,
    eaf_col = colmap$eaf,
    pval_col = colmap$pval,
    samplesize_col = colmap$samplesize,
    phenotype_col  = colmap$phenotype
  )

  if (!is.null(exposure_label)) dat$exposure <- paste0(dat$exposure, exposure_label)
  dat
}

# Example: user must edit column names to match their files
get_default_colmaps <- function() {
  list(
    pqtl = list(snp="SNP", beta="BETA", se="SE", ea="A1", oa="A2", eaf="Freq",
                pval="pval", samplesize="samplesize.exposure", phenotype="exposure"),
    eqtl = list(snp="SNP", beta="beta", se="se", ea="effect_allele", oa="other_allele", eaf="eaf",
                pval="pval", samplesize="n", phenotype="phenotype")
  )
}
