set -ex

source ./config.sh

cd /results

if [ -n "$DESEQ2" ] && [ -n "$PERTURBATION_ID" ] && [ -n "$OUTPUT_DIRECTORY" ];
then

    echo "DESEQ2 : $DESEQ2"
    echo "Perturbation ID : $PERTURBATION_ID"
    echo "Output directory : $OUTPUT_DIRECTORY"

    output=${OUTPUT_DIRECTORY}/gsea.tsv

    python /code/gsea.py \
        --deseq2 $DESEQ2 \
        --output $output \
        --gene-sets "hard coded path to gene sets????"

    else
    echo "This program requires something thats missing."

fi