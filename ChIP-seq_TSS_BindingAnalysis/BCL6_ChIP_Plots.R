library(bigWig)
library(zoo)
library(lattice)
library(data.table)
source('composite_functions.R')
################################################################################
#Import bed files of 1kb upstream of TSS for each gene
Motifs <- list.files('Gene_beds')
Motiflist <- vector('list', length(Motifs))
for (i in 1:length(Motifs)) {
  Motiflist[[i]] <- fread(paste('Gene_beds', Motifs[i], sep = ''))
}
names(Motiflist) <- substr(Motifs, 1, nchar(Motifs)-4)
Motifs <- names(Motiflist)
for (i in 1:length(Motiflist)) {
  colnames(Motiflist[[i]]) = c('chr', 'start', 'end', 'gene', 'location', 'strand')
}

#Import data and determine signal at sites of interest
BWs = list.files('data')
BWs = BWs[grep('.bigWig', BWs)]

experiments = vector('list', length = length(BWs))
compositelist <- vector('list', length(Motifs))
for (p in 1:length(BWs)) {
for (i in 1:length(Motiflist)) {
  compositelist[[i]] <- BED.query.bigWig(Motiflist[[i]], paste('data/', BWs[p], sep = ''), paste('data/', BWs[p], sep = ''), 
                                         upstream = 500, downstream = 500, factor = Motifs[i], group = substr(BWs[p], 1, nchar(BWs[p])-7), ATAC = TRUE)
  compositelist[[i]]$x = -1000:0
  }
names(compositelist) = Motifs
experiments[[p]] = compositelist
}
names(experiments) = substr(BWs, 1, nchar(BWs)-7)
rm(compositelist)

experiment_table = NULL
for (i in 1:length(experiments)) {
  experiment_table[[i]] = do.call(rbind, experiments[[i]])
}
#Combine all data into a single variable
experiment_table = do.call(rbind, experiment_table)
experiment_table[,5] = NULL
#Subset data to only regions of interest
experiment_table = experiment_table[which(experiment_table$x <= 0 & experiment_table$x >= -1000),]
#Plot aggregate composite plots for each gene
for (i in 1:length(Motifs)) {
  plot_table =  experiment_table[grep(Motifs[i], experiment_table$factor),]
  plot_table = plot_table[-c(grep('IgG', plot_table$group)),]
  plot_table$group = Motifs[i]
  plot_table = aggregate(est~x,data=plot_table,FUN=sum)
  plot_table$factor = Motifs[i]
  plot_table$group = Motifs[i]
  plot.composites(plot_table, legend = TRUE, 
                  pdf_name = paste(Motifs[i], '_aggregation_composite', sep = ''),
                  ylabel = 'Read Frequency',
                  xlabel = 'Distance from TSS',
                  motifline = FALSE)
  
}

