set -ex

source ./config.sh

if [ -n "$DESEQ2" ] && [ -n "$PERTURBATION_ID" ] && [ -n "$OUTPUT_DIRECTORY" ];
then

    echo "DESEQ2 : $DESEQ2"
    echo "Perturbation ID : $PERTURBATION_ID"
    echo "Output directory : $OUTPUT_DIRECTORY"
    echo "Gene Set : $GENE_SET"

    output=${OUTPUT_DIRECTORY}

    Rscript fgsea.R \
        --deg $DESEQ2 \
        --output $output \
        --gene_set $GENE_SET

    else
    echo "This program requires something thats missing."

fi