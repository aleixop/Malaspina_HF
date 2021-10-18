# Load basic packages

library(tidyverse)
library(speedyseq)
library(patchwork)
library(vegan)
library(viridis)
library(ggtext)

# Theme set for ggplot

theme_set(theme_bw(base_size = 10))

# Phyloseq auxiliary functions

tax_glom_custom = function(physeq, tax.col){ # adapted from https://github.com/joey711/phyloseq/issues/941#issuecomment-391018770
  
  require(tidyverse)
  
  reorderedtax = data.frame(tax_table(physeq)) %>% 
    # Puts the selected column first with everything else aftwds
    select(one_of(tax.col), everything()) %>% 
    as.matrix() %>% 
    tax_table()
  
  tax_table(physeq) = reorderedtax
  
  return(tax_glom(physeq, taxrank = tax.col))
  
}

relabun <- function(x){x/sum(x)}
percentage <- function(x){100*x/sum(x)}

# GMPR normalization (Chen et al., 2018)

gmpr_norm <- 
  function(physeq, min_shared_asvs = 5){
    
    source('GMPR.R')
    
    otu.tab <- 
      otu_table(physeq) %>% 
      as('matrix')
    
    gmpr.size.factor <- 
      GMPR(otu.tab, intersect.no = min_shared_asvs)
    
    otu.tab.norm <- 
      t(t(otu.tab)/gmpr.size.factor)
    
    samples_removed <-
      names(gmpr.size.factor[is.na(gmpr.size.factor)])
    
    samples_kept <- 
      names(gmpr.size.factor[!is.na(gmpr.size.factor)])
    
    if (length(samples_removed) > 0)
      message(paste0('Samples removed after normalization: ', paste(samples_removed, collapse = ', ')))
    
    otu.tab.norm.filt <- 
      otu.tab.norm[,samples_kept]
    
    physeq_norm <- 
      physeq %>% 
      prune_samples(samples = sample_names(.) %in% samples_kept)
    
    otu_table(physeq_norm) <- otu_table(otu.tab.norm, taxa_are_rows = T)
    
    return(physeq_norm)
  }

# Corncob analysis

formuler_env <- function(x){
  as.formula(paste0('~',paste0(x,collapse = '+')))
}

corncob_test <- function(var, physeq){
  # remove samples with NA's
  sample_data(physeq) <-
    physeq %>%
    prune_samples(samples = rowSums(is.na(sample_data(physeq))) == 0)
  
  # corncob's differential test
  testvar <- differentialTest(formula = formuler_env(var),
                              formula_null = ~1,
                              phi.formula = ~1,
                              phi.formula_null =  ~1,
                              data = physeq,
                              test = 'Wald',
                              boot = FALSE,
                              fdr_cutoff = 0.05,
                              na.rm = TRUE)
  
  return(testvar)
  
}

obtain_coeffs <- function(obj){
  data.frame(plot(obj, data_only = T)) %>%
       mutate(asv = gsub(".*\\(|\\)","",taxa))
}

# Network analysis

flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  tibble(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}