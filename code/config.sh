#!/usr/bin/env bash

# Inputs
DESEQ2=$(find -L /data -name "DEG.tsv")
PERTURBATION_ID=$(echo $DESEQ2 | cut -d"/" -f3)
OUTPUT_DIRECTORY="/results/$PERTURBATION_ID/"
GENE_SET=$(find -L /data/geneset -name "*.rds")

if [ ! -d "$OUTPUT_DIRECTORY" ]; then
    mkdir -p "$OUTPUT_DIRECTORY"
fi
