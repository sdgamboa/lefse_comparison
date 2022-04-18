
if (!'BiocManager' %in% installed.packages()[,'Package']) {
    install.packages('BiocManager')
}
    

packages <- c(
    'lefser', 'SummarizedExperiment', 'dplyr', 'tibble'
)

for (pkg in packages) {
    if (!pkg %in% installed.packages()[,'Package'])
        BiocManager::install(pkg)
}

suppressMessages({
    library(lefser)
    library(SummarizedExperiment)
    library(dplyr)
    library(tibble)
    library(magrittr)
})

## Example datset from lefser as SummarizedExperiment
data(zeller14)
se <- zeller14[, zeller14$study_condition != "adenoma"]
rownames(se) <- sub('^.+([a-z]__.+$)', '\\1', rownames(se))

## Matrix with counts
counts <- assay(se) %>%
    as.data.frame() %>% 
    rownames_to_column('features') %>% 
    mutate(across(.cols = everything(), .fns = ~as.character(.x))) %>% 
    set_colnames(paste0('col1', seq_along(.)))

# colanmes(counts) <- NULL

## Sample metadata
sm <- colData(se) %>% 
    as.data.frame() %>% 
    rownames_to_column('Sample') %>% 
    select(study_condition, age_category, Sample) %>% 
    t() %>% 
    as.data.frame() %>% 
    rownames_to_column('helper_col') %>% 
    mutate(across(.cols = everything(), .funs = ~as.character(.x))) %>% 
    set_colnames(paste0('col1', seq_along(.)))
    
    
# colnames(sm) <- NULL

## Combine counts and sample_metadata in a single dataframe in 'lefse' format
data <- bind_rows(sm, counts)
colnames(data) <- NULL

## Export to txt file
write.table(
    data, 'zeller14.txt', sep = '\t', row.names = FALSE, col.names = FALSE,
    quote = FALSE
)
