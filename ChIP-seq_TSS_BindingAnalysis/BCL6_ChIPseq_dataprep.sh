mkdir data
cd data
#Download all needed Bcl6 ChIP-seq data sets
fasterq-dump GSM1857225
fasterq-dump GSM1857226
fasterq-dump GSM3347610
fasterq-dump GSM3347618
fasterq-dump GSM3347625
fasterq-dump GSM3347623
fasterq-dump GSM3347624
fasterq-dump GSM3347613
fasterq-dump GSM3347612
fasterq-dump GSM3347611
fasterq-dump GSM419049
fasterq-dump GSM419050
fasterq-dump GSM611114
fasterq-dump GSM611115
fasterq-dump GSM851557
#Zip data sets
gzip *fastq
#Name data sets according to experimental parameters
mv GSM1857225.fastq.gz Tfh_Bcl6.fastq.gz
mv GSM1857226.fastq.gz NonTfh_Bcl6.fastq.gz
mv GSM3347610.fastq.gz Input_fed_WT_Bcl6.fastq.gz
mv GSM3347618.fastq.gz Input_fast_C57_Bcl6.fastq.gz
mv GSM3347625.fastq.gz Input_control_Bcl6.fastq.gz
mv GSM3347623.fastq.gz BCL6_Control_Rep1_ChIP_seq.fastq.gz
mv GSM3347624.fastq.gz BCL6_Control_Rep2_ChIP_seq.fastq.gz
mv GSM3347613.fastq.gz BCL6_Fed_C57_Rep3_ChIP_seq.fastq.gz
mv GSM3347612.fastq.gz BCL6_Fed_C57_Rep2_ChIP_seq.fastq.gz
mv GSM3347611.fastq.gz BCL6_Fed_C57_Rep1_ChIP_seq.fastq.gz
mv GSM419049.fastq.gz macrophage_BCL6_ChIPSeq.fastq.gz
mv GSM419050.fastq.gz macrophage_IgG_ChIPSeq.fastq.gz
mv GSM611114.fastq.gz macrophage_BCL6_LPS_ChIPSeq_1.fastq.gz
mv GSM611115.fastq.gz macrophage_BCL6_LPS_ChIPSeq_2.fastq.gz
mv GSM851557.fastq.gz macrophage_Bcl6_ChIPSeq_replicate.fastq.gz
#Get mm39 reference genome
wget https://hgdownload.soe.ucsc.edu/goldenPath/mm39/bigZips/mm39.fa.gz
gunzip mm39.fa.gz
#Build index genome
bowtie2-build mm39.fa mm39
#Align reads to mm39
for fq in *.fastq.gz
do
    name=$(echo $fq | awk -F".fastq.gz" '{print $1}')
    echo $name
    bowtie2 -p 6 --maxins 500 -x mm39 -U ${name}.fastq.gz  \
       | samtools view -bS - | samtools sort - -o $name.bam
done
#Convert bam files to bigWig format and remove unmappable regions
for bam in *.bam
do
   name=$(echo $bam | awk -F".bam" '{print $1}')
   seqOutBias mm39.fa $bam --no-scale --bw=${name}_unscaled.bigWig --read-size=60

done

##TSS Gene locations were found by going to:
#https://genome.ucsc.edu/cgi-bin/hgSearch?db=mm39&search=
#and entering an individual gene, then making a bed file based on the 1kb location upstream from the gene
