set -ex

source ./config.sh

if [ -n "$DESEQ2" ] && [ -n "$PERTURBATION_ID" ] && [ -n "$OUTPUT_DIRECTORY" ];
then

    output=${OUTPUT_DIRECTORY}

    Rscript fgsea.R --deg $DESEQ2 --output $output --gene_set $GENE_SET

    else
    echo "This program is a doos"

fi