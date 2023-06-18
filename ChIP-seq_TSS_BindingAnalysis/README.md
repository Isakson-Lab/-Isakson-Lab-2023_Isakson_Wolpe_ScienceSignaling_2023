# ChIP-seq_TSS_BindingAnalysis    
    
To reproduce this analysis and plot Bcl6 ChIP-seq signal in the 1kb upstream of the transcription start site for each gene, please first download all files included in this folder. Then, run the script titled `BCL6_ChIPseq_dataprep.sh`. Once run, aligned read data for the ChIP-seq data sets of interest will be deposited into a newly created folder called `data`. 
    
Next, run the file titled `BCL6_ChIP_Plots.R`, this will plot fresh versions the figures included in the `Output_plots` folder. The folder titled `Gene_beds` and the script titled `composite_functions` are required to be in the working directory for plotting. 

These output plots correspond to Figure 6 I,J,K and Figure S4 B,C in the manuscript.
