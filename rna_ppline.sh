#!bin/bash
# Program:
# This is the rnaseq gene differentiated expression analysis pipeline using Tophat and cufflinks. 
# History:
# 08/01/2014   Ni shuai
PATH=/bin:/usr/bin:usr/local/bin:~/bin:~/software/GATK:~/software/picard/picard-tools:/fs/lustre/wrk/shni/files
export PATH

path_ref=/fs/lustre/wrk/shni/files/rna-seq-wei/new_data/ref/
path_reads=/fs/lustre/wrk/shni/files/rna-seq-wei/new_data/reads/
#####################################################
#  Load modules
#####################################################
module load bowtie2
module load samtools
####################################################
  Make index for reference sequences
  Download annotation file for the genome
####################################################
cd $path_ref; 
wget ftp://ftp.ensembl.org/pub/release-78/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz
gunzip *fa.gz
mv *.fa hg38.fa
bowtie2-build hg38.fa hg38
wget ftp://ftp.ensembl.org/pub/release-78/gtf/homo_sapiens/Homo_sapiens.GRCh38.78.gtf.gz
gunzip *gtf.gz

###################################################
  Running Tophat to map reads to the reference genome
###################################################
echo 'so far so good'
cd $path_reads;
for files in *; do 
	if [ -d $files ]; then cd $files
		for filess in *.fastq; do  
			tophat -p 16 -G $path_ref/*.gtf -o ${filess/.fastq/} $path_ref/hg38 $filess
			echo "$filess is done with mapping"; 

done; 
cd ..
fi; echo "$files list is done for mapping"; 
done;

###################################################
#  Assemble transcriptoms with cufflinks
###################################################

cd $path_reads;
for files in *; do 
	if [ -d $files ]; then cd $files
	for filess in *; do
		if [ -d $filess ]; then cd $filess
			for filesss in $accepted*; do  
				~/software/cufflins-2.2.1/cufflinks -o ${filess} -p 16 $filesss
echo "$filesss is done making transcriptom"; 
done;
cd .. fi; done; 
cd .. fi; done;


