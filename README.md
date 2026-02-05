# Multi-omics MR pipeline (template skeleton)

This repository provides a **template** (skeleton) for a Mendelian randomization (MR) and multi-omics (eQTL/pQTL) analysis pipeline.
It is designed for **transparency and reproducibility** of the analysis workflow supporting a manuscript, while intentionally
**requiring users to adapt paths, identifiers, and data formats** for their own datasets.

> ⚠️ **No restricted / controlled-access data are redistributed here.**
> Users must obtain the underlying GWAS/QTL summary statistics from the original providers and comply with their licenses/terms.

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

## Data availability (template language)
The analysis uses publicly available GWAS/QTL summary statistics (e.g., OpenGWAS/FinnGen/UKB-derived resources) and study-specific derived tables.
Because some resources have redistribution restrictions, this repository contains **code only** plus configuration templates and small toy examples.

## Citation
If you use this workflow template, please cite:
- the corresponding manuscript (add reference here), and
- the upstream software packages listed in `renv.lock` or the README methods section.

## License
MIT (recommended). See `LICENSE`.
