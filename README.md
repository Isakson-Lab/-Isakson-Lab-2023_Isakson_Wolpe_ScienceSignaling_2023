# *in silico* analysis conducted in: Non-canonical role for pannexin stabilizing the transcription factor Bcl6 to regulate oxidative stress    
    
This repository contains the code used to conduct in silico analysis for the paper "Non-canonical role for pannexin stabilizing the transcription factor Bcl6 to regulate oxidative stress" by Abigail Wolpe et al. Each folder contains scripts, data (when possible), and output for the analysis indicated. Additionally, figure number and panel letter are indicated in the README file for each folder. A brief summary of each analysis conducted:

## ChIP-seq_TSS_BindingAnalysis    
    
This analysis determines average Bcl6 binding in the region 1kb upstream of a transcription start site for a given gene. To conduct this analysis, reads from 3 separate Bcl6 ChIP-seq experiments were retrieved from the Sequence Read Archive and aligned to the mm39 mouse genome. Reads were then converted from BAM to bigWig format and signal at sites of interest was combined, then plotted.

