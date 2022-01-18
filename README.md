# Oceanic heterotrophic flagellates are dominated by a few widespread taxa 

[![DOI](https://zenodo.org/badge/323586484.svg)](https://zenodo.org/badge/latestdoi/323586484)


This repository contains code and data included in:

--------
Obiol, A., Muhovic I. and Massana, R. Oceanic heterotrophic flagellates are dominated by a few widespread taxa. *Limnol. Oceanogr.* 2021; 66:4240:4253. doi: 10.1002/lno.11956

--------

## Phyloseq objects

Phyloseq objects including counts, taxonomy and sample metadata can be found in `tables/`. They are formatted as `.rds` objects and can be imported to `R` using the `readRDS` command.

|Object                        |Description                                                                                                                                                                             |
|:-----------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`MPN_18S.phy`                 |All samples considered in this study (287) and all taxa                                                                                                                                 |
|`MPN_18S_DNA.phy`             |DNA samples (188) with all taxa                                                                                                                                                         |
|`MPN_18S_HF.phy`              |DNA & RNA samples (279) with HF taxa                                                                                                                                                    |
|`MPN_18S_HF_DNA.phy`          |DNA samples (188) with HF taxa                                                                                                                                                          | 
|`MPN_18S_HF_DNA_SF.phy`       |Surface DNA samples (127) with HF taxa                                                                                                                                                  |
|`MPN_18S_HF_DNA_VP.phy`       |Vertical profiles DNA samples (73) with HF taxa                                                                                                                                         |
|`MPN_18S_HF_RNA.phy`          |RNA samples (91) with HF taxa                                                                                                                                                           |
|`MPN_18S_HF_SF_DNA_top52.phy` |Top 52 HF taxa in the 127 DNA surface samples                                                                                                                                           |
|`MPN_VP_V9_HF.phy`            |V9 amplicons table with HF taxa published in [Obiol et al. 2020](https://doi.org/10.1111/1755-0998.13147)                                                                               |
|`MPN_VP_mTags.phy`            |mTags tables published in [Obiol et al. 2020](https://doi.org/10.1111/1755-0998.13147)                                                                                                  |
|`TARA_HF.phy`                 |TARA V9 amplicons with HF taxa published in [de Vargas et al. 2015](https://doi.org/10.1126/science.1261605). Data downloaded from [Callahan 2017](http://doi.org/10.5281/zenodo.581694)|


## R scripts used in the analysis

All R scripts used in this study can be found in `scripts/`.

|Script                       |Description                                                                                                                |
|:----------------------------|:--------------------------------------------------------------------------------------------------------------------------|
|`0-phyloseq_setup.Rmd`       |Creation of all phyloseq objects                                                                                           |
|`1-HF_distribution.Rmd`      |HF distributions at the ASV/group level, alpha and betadiversity analyses                                                  |
|`2-comparison.Rmd`           |Comparison of DNA distribution results with RNA, Malaspina V9 amplicons, metagenomes and TARA Oceans datasets              |
|`3-main_taxa.Rmd`            |Analysis of the main species in surface and vertical profiles                                                              |
|`4-network_analyses.Rmd`     |Correlation network analyses                                                                                                |
|`GMPR.R`                     |Auxiliary function for read normalization in the heatmap analysis ([Chen et al. 2018](https://doi.org/10.7717/peerj.4600)) |
|`aux_functions.R`            |Auxiliary functions used in this study                                                                                     |

The following packages are required:

  - `ComplexHeatmap`
  - `DivNet`
  - `RColorBrewer`
  - `ape`
  - `corncob`
  - `geodist`
  - `ggnewscale`
  - `ggraph`
  - `ggsci`
  - `ggtext`
  - `ggtree`
  - `patchwork`
  - `reshape2`
  - `speedyseq`
  - `tidygraph`
  - `tidytree`
  - `tidyverse`
  - `treeio`
  - `vegan`
  - `viridis`

## Alignments of phylogenetic trees

The alignments used for building phylogenetic trees of HF groups can be found in `alignments/`. They are formatted as `fasta`.

|Group            |Reference                                                                |
|:----------------|:------------------------------------------------------------------------|
|Bicosoecida      |[del Campo & Massana 2011](https://doi.org/10.1016/j.protis.2010.10.003) |
|Centrohelida     |[Shɨshkin et al. 2018](https://doi.org/10.1016/j.protis.2018.06.003)     |
|Cercozoa         |[Bass et al. 2018](https://doi.org/10.1111/jeu.12524)                    |
|Choanoflagellata |[del Campo & Massana 2011](https://doi.org/10.1016/j.protis.2010.10.003) |
|Chrysophyceae    |[del Campo & Massana 2011](https://doi.org/10.1016/j.protis.2010.10.003) |
|Dictyochophyceae |[Sekiguchi et al. 2002](https://doi.org/10.1078/1434-4610-00094)         |
|MAST             |[Massana et al. 2014](https://dx.doi.org/10.1038%2Fismej.2013.204)       |
|Picozoa          |[Moreira & López-García](https://doi.org/10.1002/bies.201300176)         |
|Telonemia        |[Shalchian-Tabrizi](https://doi.org/10.1016/j.protis.2006.10.003)        |

## Correlation results

Results of [sparCC](https://github.com/scwatts/fastspar) can be found in `correlations/` for HF only and prokaryotes and HF together. 

Bash script to run [EnDED](https://github.com/InaMariaDeutschmann/EnDED) can be found in `correlations/EnDED/ended.sh`.

## DivNet and corncob results 

Results for [DivNet](https://github.com/adw96/DivNet) and [corncob](https://github.com/bryandmartin/corncob) runs can be found in `analysis/`.

## Other objects

Auxiliary objects for the R scripts to run are located in `other/`.
