import pandas as pd
import gseapy as gp
import click

def load_and_sort_deseq2(deseq2_results):
    """Load DESeq2 results from a TSV file and sort by the 'stat' column."""
    df = pd.read_csv(deseq2_results, sep='\t', index_col=0)
    
    if 'stat' not in df.columns:
        raise ValueError("Input file must contain 'stat' column")
    
    # Sort by the 'stat' column in descending order
    df.sort_values('stat', ascending=False, inplace=True)
    
    return df

def run_gsea(deseq2_results, gene_sets, alpha=0.05):
    """Run GSEA using sorted DESeq2 results and specified gene sets."""
    try:

        gene_list = deseq2_results[['index', 'stat']]
        gene_list.columns = ['gene', 'stat']  # Rename columns for clarity in GSEA

        # Run pre-ranked GSEA
        res = gp.prerank(
            rnk=gene_list,
            gene_sets=gene_sets,
            outdir=None,
            seed=42,
            verbose=True
        )

        res = res.res2d

        res = res[res['Adjusted P-value'] <= alpha]
        
        return res
    
    except Exception as e:
        print(f"Could not complete GSEA with error: {e}")



@click.command()
@click.option('--deseq2', "-d", required=True, type=str, help="tsv output from deseq2 where gene ID is in the index and results contains stat column")
@click.option('--output', "-o", required=True, type=str, help="output tsv to write enrichments to")
@click.option('--gene-sets', "-g", required=True, type=str, help="Path to gene sets in GMT format")
def main(deseq2, gene_sets):
    """
    Script to run GSEA on DESeq2 results sorted by the 'stat' column
    DESEQ2_TSV: Path to the DESeq2 output TSV file.
    """
    # Load and sort the DESeq2 results
    deseq2 = load_and_sort_deseq2(deseq2)
    
    gsea_results = run_gsea(deseq2, gene_sets)
    res.to_csv(output, sep='\t', index=None)

if __name__ == "__main__":
    main()