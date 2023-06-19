#Get reference genome
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_000001635.27/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCF_000001635.27.zip" -H "Accept: application/zip"
unzip GCF_000001635.27.zip -d GCF_000001635.27
cp GCF_000001635.27/ncbi_dataset/data/GCF_000001635.27/GCF_000001635.27_GRCm39_genomic.fna ./
#Create seqs folder
mkdir seqs
#RS genome
#Get sequencess for 1kb upstream of genes
for bed in NCBI_Gene_coords/*.bed
do
  name=$(echo $bed | awk -F".bed" '{print $1}' | awk -F"NCBI_Gene_coords/" '{print $2}')
  echo $name
  fastaFromBed -name -s -fi GCF_000001635.27_GRCm39_genomic.fna -bed 'NCBI_Gene_coords/'$name'.bed' -fo 'seqs/'$name'.fasta'
done

#Get and rename Bcl6 motif
wget https://jaspar.genereg.net/api/v1/matrix/MA0463.1.meme
mv MA0463.1.meme Bcl6_mus.meme

#Run FIMO to identify instances of Bcl6 motif for 1kb upstream of each gene
for fa in seqs/*.fasta
do
    name=$(echo $fa | awk -F".fasta" '{print $1}' | awk -F"seqs/" '{print $2}')
    echo $name
    fimo --thresh 0.0004 --text Bcl6_mus.meme 'seqs/'$name'.fasta' > 'seqs/'${name}_fimo.txt
done

#Remove headers from FIMO files for counting number of motifs
cd seqs
sed -i '1d' *_fimo.txt

#Count number of Bcl6 motifs in each FIMO file
wc -l *_fimo.txt
