suppressPackageStartupMessages({
  library(yaml)
  library(data.table)
})

read_config <- function(path="config/config_example.yml") {
  if (!file.exists(path)) stop("Config file not found: ", path)
  cfg <- yaml::read_yaml(path)
  if (is.null(cfg$opengwas_jwt) || grepl("PLEASE_SET", cfg$opengwas_jwt)) {
    stop("Please set opengwas_jwt in config (do NOT commit secrets).")
  }
  cfg
}

setup_env <- function(cfg) {
  # IMPORTANT: do not store JWT in repo; set in env locally
  Sys.setenv(OPENGWAS_JWT = cfg$opengwas_jwt)

  # Reproducibility
  set.seed(cfg$seed %||% 1)
  options(stringsAsFactors = FALSE)

  # Guardrails: assert key tools exist
  if (!file.exists(cfg$plink_bin)) stop("plink not found at: ", cfg$plink_bin)
  if (!file.exists(paste0(cfg$ld_ref_bfile, ".bed"))) {
    stop("LD reference bfile not found: ", cfg$ld_ref_bfile, "(.bed/.bim/.fam)")
  }

  invisible(TRUE)
}

`%||%` <- function(x, y) if (is.null(x)) y else x
