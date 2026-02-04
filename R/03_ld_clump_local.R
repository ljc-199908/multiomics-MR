suppressPackageStartupMessages({
  library(data.table)
  library(ieugwasr)
})

ld_clump_by_exposure <- function(exposure_dat, cfg) {
  dt <- as.data.table(exposure_dat)
  setkey(dt, exposure)

  exposures <- unique(dt$exposure)
  out_list <- vector("list", length(exposures))

  for (i in seq_along(exposures)) {
    ex <- exposures[i]
    d <- dt[list(ex)]
    clump_input <- d[, .(rsid=SNP, pval=pval.exposure)]

    # NOTE: local clumping requires PLINK + reference panel
    clumped <- ieugwasr::ld_clump_local(
      dat = clump_input,
      clump_r2 = cfg$clump_r2,
      clump_kb = cfg$clump_kb,
      clump_p  = 1,
      plink_bin = cfg$plink_bin,
      bfile = cfg$ld_ref_bfile
    )

    out_list[[i]] <- d[SNP %in% clumped$rsid]
    message(sprintf("Clumped %s: %d -> %d SNPs", ex, nrow(d), nrow(out_list[[i]])))
  }

  rbindlist(out_list, fill=TRUE)
}
