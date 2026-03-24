# Multi-omics MR pipeline

This repository contains the analysis pipeline supporting the study:

"Systematic prioritization of potential therapeutic targets for glomerulonephritis using multi-omics Mendelian randomization".

The workflow integrates Mendelian randomization (MR) with multi-omics data (eQTL/pQTL) to enable systematic prioritization of candidate therapeutic targets. The pipeline is designed to ensure transparency, reproducibility, and extensibility, and is organized in a modular structure that can be adapted to other datasets.

> ⚠️ **No restricted / controlled-access data are redistributed here.**
> Users must obtain the underlying GWAS/QTL summary statistics from the original providers and comply with their licenses and terms of use.


## What this repo contains
- A configurable R pipeline structure: ingestion → IV filtering → LD clumping → outcome extraction → harmonisation → MR → sensitivity → MR-PRESSO (batch) → (optional) colocalisation → reporting.
- Parameter templates (`config/config_example.yml`) with **placeholders** that must be edited by the user.
- Stubs with `stop("...")` where decisions are study-specific (e.g., confounder lists, Steiger settings, coloc dataset specs).

## Quick start
1. Install R (>=4.3 recommended) and required system tools (PLINK).
2. Copy and edit the config:
   ```bash
   cp config/config_example.yml config/config.yml
   ```
3. Edit `config/config.yml` (paths, token, IDs).
4. Run the (partial) pipeline:
   ```bash
   Rscript scripts/run_pipeline.R config/config.yml
   ```

## Data availability

The analysis uses publicly available GWAS/QTL summary statistics (e.g., OpenGWAS, FinnGen, and UK Biobank-derived resources), with detailed accession information provided in the manuscript.
Due to redistribution restrictions, this repository provides code and configuration templates only. All harmonised datasets can be reproduced using the deposited code.


## Citation

If you use this workflow template, please cite:

Li G, Zeng D, Gu J, Wang Y, Liu J, Yang D.  
Systematic prioritization of potential therapeutic targets for glomerulonephritis using multi-omics Mendelian randomization.  
PLOS Computational Biology (under revision).

Code repository DOI: https://doi.org/10.5281/zenodo.19210177

In addition, please cite the upstream software packages listed in `renv.lock` or described in the Methods section.

## License
MIT (recommended). See `LICENSE`.
