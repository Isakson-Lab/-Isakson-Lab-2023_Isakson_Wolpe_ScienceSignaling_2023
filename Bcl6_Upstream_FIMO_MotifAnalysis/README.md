# Bcl6_Upstream_FIMO_MotifAnalysis    

This analysis of Bcl6 upstream binding motifs can be reproduced by downloading the `NCBI_Gene_coords` folder and `BCL6_MotifAnalysis_Bindingsites.sh` script. Executing the script will run the analysis by first downloading the mouse reference genome from NCBI. Next, the script retrieves the genomic reference sequences 1kb upstream from each gene of interest and deposits these into a `seqs` folder (included in this repository). The Bcl6 binding motif is then downloaded from the JASPAR database. Using the Bcl6 binding motif, a FIMO search is executed on each upstream sequence to determine the number of binding motifs which meet the threshold (0.0004). Finally, the number of binding motifs in each sequence is counted for plotting.



This data is plotted in Figure 6 E in the manuscript.
