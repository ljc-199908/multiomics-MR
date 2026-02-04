suppressPackageStartupMessages({
  library(data.table)
  library(TwoSampleMR)
})

run_mr_for_pair <- function(dat, method_list=NULL) {
  if (is.null(method_list)) {
    method_list <- c("mr_ivw", "mr_ivw_mre", "mr_egger_regression",
                     "mr_weighted_median", "mr_weighted_mode", "mr_wald_ratio")
  }
  res <- TwoSampleMR::mr(dat, method_list = method_list)

  # OR + 95% CI
  res$OR    <- exp(res$b)
  res$lower <- exp(res$b - 1.96*res$se)
  res$upper <- exp(res$b + 1.96*res$se)

  res
}

run_mr_batch <- function(dat_all, method_list=NULL) {
  dt <- as.data.table(dat_all)
  setkey(dt, exposure, outcome)

  pairs <- unique(dt[, .(exposure, outcome)])
  out <- vector("list", nrow(pairs))

  for (i in seq_len(nrow(pairs))) {
    ex <- pairs$exposure[i]; ou <- pairs$outcome[i]
    d  <- dt[list(ex, ou)]
    if (nrow(d) < 1) next

    out[[i]] <- as.data.table(run_mr_for_pair(d, method_list))
    out[[i]][, `:=`(exposure=ex, outcome=ou)]
  }

  rbindlist(out, fill=TRUE)
}
