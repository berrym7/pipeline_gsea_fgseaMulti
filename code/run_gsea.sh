#!/usr/bin/env bash

set -ex

source ./config.sh
# This capsule will read in a tsv file from deseq2 and run fgseaMultilevel on it.

if [ -n "$DESEQ2" ] && [ -n "$PERTURBATION_ID" ] && [ -n "$OUTPUT_DIRECTORY" ];
then

    output=${OUTPUT_DIRECTORY}

    Rscript fgsea.R --deg $DESEQ2 --output $output --gene_set $GENE_SET
    echo "$PERTURBATION_ID has run to completetion"

    else
    echo "Something is wrong with $PERTURBATION_ID"

fi