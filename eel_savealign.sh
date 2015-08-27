#!/bin/bash -l
while getopts 'i:o:f:m:' arg
do
	case $arg in
	i) path_sequence=$OPTARG;;
	o) path_out=$OPTARG;;
	f) file_number=$OPTARG;;
	m) path_matrices=$OPTARG;;
	esac done	

# created: Jan 14, 2015 1:56 PM
# author: shni
#SBATCH -J eel_align
#SBATCH -n 1
#SBATCH -t 72:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=shuai.ni@oulu.com
#SBATCH --mem-per-cpu=32000
if [[ ! -d $path_out ]]; then echo $path_out; mkdir $path_out; fi

for ((i==1; i<=81; i++));  do 
	if [ -d ${path_sequence}/${file_number}'thpair' ]; then 
	eel -am ${path_matrices}/* -as ${path_sequence}/${file_number}'thpair'/*.fasta -getTFBS -align . 10 1 2684.59 0.144 2.98 . -savealignGFF ${path_out}/${file_number}.gff -savealign ${path_out}/${file_number}.align;
	else echo "file ${path_sequence}/${file_number}thpair does not exist"; fi;
let "file_number++";
echo $file_number;
echo ${path_sequence}/${file_number}'thpair'/*.fasta;
echo ${path_out}/${file_number}.gff;
echo ${path_out}/${file_number}.align;
echo ${path_matrices};
done
