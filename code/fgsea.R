library(fgsea)
library(data.table)
library(optparse)

option_list <- list(
  make_option(
    c("-d", "--deg"), 
    type="character", 
    help="Results from deseq2 in tsv format", 
    metavar="character"
  ),
  make_option(
    c("-g", "--gene_set"), 
    type="character", 
    help="a gene set file in gmt or rds (list of gene set names where the value is a vector of ensembl gene ids)", 
    metavar="character"
  ),
  make_option(
    c("-o", "--output"),
    type="character", 
    help="output directory to write enrichments to (should start with /results/)", 
    metavar="character"
  )
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

deseq2_file <- opt$deg
gmt_file <- opt$gene_set
output_file <- opt$output

run_fgsea <- function(deseq2_file, gmt_file, output_dir) {
  deseq2_results <- read.table(deseq2_file, sep = "\t", header = TRUE, row.names = 1)
  deseq2_results <- deseq2_results[order(deseq2_results$stat, decreasing = TRUE), ]
  
  ranking_stat <- deseq2_results$stat
  
  ranked_genes <- setNames(ranking_stat, rownames(deseq2_results))
  
  if (endsWith(gmt_file, ".rds")) {
    pathways <- readRDS(gmt_file)
  } else if (endsWith(gmt_file, ".gmt")) {
    pathways <- gmtPathways(gmt_file)
  }
  
  fgsea_res <- fgsea(
    pathways = pathways, 
    stats = ranked_genes
    )
  
  fgsea_res <- fgsea_res[order(fgsea_res$NES, decreasing = TRUE)]
  
  fgsea_res$pval[fgsea_res$pval == 0] <- 2e-308
  fgsea_res$signed_logP <- -log10(fgsea_res$pval) * sign(fgsea_res$NES)
  
  output_gsea <- paste0(output_dir, 'gsea.tsv')
  output_deg <- paste0(output_dir, 'deg.tsv')
  fwrite(fgsea_res, output_gsea, sep='\t')
  fwrite(deseq2_results, output_deg, sep='\t')
  
  return(fgsea_res)
}

gsea_results <- run_fgsea(deseq2_file, gmt_file, output_file)

print("Complete!")

