#!bin/bash
# Program:
#             This is the piplie that maps all files to the reference genome, and performs the downstream variant calling with GATK.
# History:
# 27/11/2014   Ni shuai
PATH=/bin:/usr/bin:usr/local/bin:~/bin:~/software/GATK:~/software/picard/picard-tools:/fs/lustre/wrk/shni/files
export PATH

path_reads=/fs/lustre/wrk/shni/files/8q24/
path_ref=/fs/lustre/wrk/shni/files/reference/
path_vcf=/fs/lustre/wrk/shni/files/vcf/
#####################################################
#  Load modules
#####################################################
module load bwa
module load samtools
#####################################################
#  Make index for all reference sequences
#####################################################
cd $path_ref; 
for files in *; do echo $files;
if [ -d $files ]; then cd $files 
for filess in *_ref.fa; do bwa index $filess; done;
cd ..
fi; done;
####################################################
#  Mipping reads to the reference genome
####################################################

###  Make SA coordinates of the input reads according different reference sequence
cd $path_reads;
for files in *; do 
	if [ -d $files ]; then cd $files
		for filess in *.fastq; do  
			bwa aln -k 2 -t 8 $path_ref/8q24_ref/8q24_ref.fa $filess > ${filess/.fastq/_8q24.sai}; 
			echo "$filess is done making SA coordinates for 8q24"; 
done; 
cd ..
fi; echo "$files is done making SA coordinates for 8q24"; 
done;


cd $path_reads;
for files in *; do 
	if [ -d $files ]; then cd $files
		for filess in *.fastq; do  
			bwa aln -k 2 -t 8  $path_ref/hoxb13_ref/hoxb13_ref.fa $filess > ${filess/.fastq/_hoxb13.sai}; done; 
cd ..
fi; echo "$files is done making SA coordinates for hoxb13";  done;

###  Generate alignment files in the SAM format give single end reads

cd $path_reads;
for files in *; do 
	if [ -d $files ]; then cd $files
		for filess in *.fastq; do  
			bwa samse $path_ref/8q24_ref/8q24_ref.fa ${filess/.fastq/_8q24.sai} $filess > ${filess/.fastq/_8q24.sam}; done;
cd ..
fi; done;


cd $path_reads;
for files in *; do 
	if [ -d $files ]; then cd $files
		for filess in *.fastq; do  
			bwa samse $path_ref/hoxb13_ref/hoxb13_ref.fa  ${filess/.fastq/_hoxb13.sai} $filess > ${filess/.fastq/_hoxb13.sam}; done;
cd ..
fi; done;

################ Creat Dicts for the reference 
echo 'evertying is ok, start to creat dicts for the reference'
cd $path_ref;
for files in *; do
	if [ -d $files ];
		then
		cd $files;
		for filess in *_ref.fa; do
			java -jar ~/software/picard/picard-tools/CreateSequenceDictionary.jar  REFERENCE=$filess OUTPUT=${filess/fa/dict};
			samtools faidx $filess;
			done;
	cd ..
	fi; done;
echo 'dicting reference is done...'

#
#####################################################
#  convert sam into bam, and add the readgroup, the function 
#  automatically sorts the bam and indexes the bam
#####################################################

cd $path_reads;
for files in *; do 
	if [ -d $files ]; then cd $files
		for filess in *.sam; do  
			samtools view -Sb $filess > ${filess/sam/bam}; done; 
cd ..
fi; done;
################ Add reading groups to bam file
echo "start to add reading groups to bam files"
cd $path_reads;

for files in *; do
	if [ -d $files ]
		then cd $files;
		for filess in *.bam; do
		java -jar ~/software/picard/picard-tools/AddOrReplaceReadGroups.jar I=$filess O=${filess/.bam/_RG.bam}  SORT_ORDER=coordinate CREATE_INDEX=true RGPL=illumina RGID=184 RGSM=sample184 RGLB=bar RGPU=pu184 VALIDATION_STRINGENCY=LENIENT;
		echo "$filess read group added";
		done;

	cd ..
	fi; done;
echo "Read group Added for all"

#####################################################
#  Calling SNPs
#####################################################
############### Call SNP with GATK

cd $path_reads;

for files in *; do 
	if [ -d $files ] 
		then cd $files;
		for filess in *8q24_RG.bam; do 
			java -jar ~/software/GATK/GenomeAnalysisTK.jar -R $path_ref/8q24_ref/8q24_ref.fa -T UnifiedGenotyper -I $filess -o $path_vcf/${filess/_RG.bam/.vcf}; done;
cd ..
fi; done;


cd $path_reads;

for files in $path_reads; do 
	if [ -d $files ] 
		then cd $files;
		for filess in *hoxb13_RG.bam; do 
	java -jar ~/software/GATK/GenomeAnalysisTK.jar -R $path_ref/hoxb13_ref/hoxb13_ref.fa -T UnifiedGenotyper -I $filess -o $path_vcf/${filess/_RG.bam/.vcf};  done; 
cd ..
fi; done; 

########################


