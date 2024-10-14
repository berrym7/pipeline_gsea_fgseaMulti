set -ex

source ./config.sh

if [ -n "$DESEQ2" ] && [ -n "$PERTURBATION_ID" ] && [ -n "$OUTPUT_DIRECTORY" ];
then

    echo "DESEQ2 : $DESEQ2"
    echo "Perturbation ID : $PERTURBATION_ID"
    echo "Output directory : $OUTPUT_DIRECTORY"

    output=${OUTPUT_DIRECTORY}gsea.tsv

    Rscript fgsea.R \
        --deg $DESEQ2 \
        --output $output \
        --gene_set /code/msig_dummy.gmt

    else
    echo "This program requires something thats missing."

fi