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
    help="a gene set file in gmt format", 
    metavar="character"
  ),
  make_option(
    c("-o", "--output"),
    type="character", 
    help="output tsv file to write enrichments to (should start with /results/)", 
    metavar="character"
  )
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

deseq2_file <- opt$deg
#deseq2_file <- "/data/single_deseq2_pipeline_out/DEG.tsv"

gmt_file <- opt$gene_set
#gmt_file <- "/code/msig_dummy.gmt"

output_file <- opt$output
#output_file <- "/results/fgsea_out.tsv"  

run_fgsea <- function(deseq2_file, gmt_file, output_file) {
  deseq2_results <- read.table(deseq2_file, sep = "\t", header = TRUE, row.names = 1)
  deseq2_results <- deseq2_results[order(deseq2_results$stat, decreasing = TRUE), ]
  
  ranking_stat <- deseq2_results$stat
  
  ranked_genes <- setNames(ranking_stat, rownames(deseq2_results))
  
  pathways <- gmtPathways(gmt_file)
  
  fgsea_res <- fgsea(
    pathways = pathways, 
    stats = ranked_genes
    )
  
  fgsea_res <- fgsea_res[order(fgsea_res$NES, decreasing = TRUE)]
  
  fwrite(fgsea_res, output_file, sep='\t')
  return(fgsea_res)
}

gsea_results <- run_fgsea(deseq2_file, gmt_file, output_file)

