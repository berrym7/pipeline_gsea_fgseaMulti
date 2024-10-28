set -ex

source ./config.sh

if [ -n "$DESEQ2" ] && [ -n "$PERTURBATION_ID" ] && [ -n "$OUTPUT_DIRECTORY" ];
then

    output=${OUTPUT_DIRECTORY}

    echo "Command Being Run = Rscript fgsea.R --deg $DESEQ2 --output $output --gene_set $GENE_SET"
    Rscript fgsea.R --deg $DESEQ2 --output $output --gene_set $GENE_SET

    else
    echo "This program requires something thats missing."

fi