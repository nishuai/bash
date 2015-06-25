#!/bin/bash

#This removes reads of a below a certain length from paired read files in fastq format (e.g., R1 and R2 from the same library)
#from http://seqanswers.com/forums/showthread.php?t=31845
# Usage: $ bash nixshorts_PE [input fastqR1] [input fastqR2] [minimum read length to keep] 

# PROCESS:

#1. Start with inputs
R1fq=$1
R2fq=$2
minlen=$3

#2. Find all entries with read length less than minimum length and print line numbers, for both R1 and R2
awk -v min=$minlen '{if(NR%4==2) if(length($0)<min) print NR"\n"NR-1"\n"NR+1"\n"NR+2}' $R1fq > temp.lines1
awk -v min=$minlen '{if(NR%4==2) if(length($0)<min) print NR"\n"NR-1"\n"NR+1"\n"NR+2}' $R2fq >> temp.lines1

#3. Combine both line files into one, sort them numerically, and collapse redundant entries
sort -n temp.lines1 | uniq > temp.lines
rm temp.lines1

#4. Remove the line numbers recorded in "lines" from both fastqs
awk 'NR==FNR{l[$0];next;} !(FNR in l)' temp.lines $R1fq > $R1fq.$minlen
awk 'NR==FNR{l[$0];next;} !(FNR in l)' temp.lines $R2fq > $R2fq.$minlen
rm temp.lines

#5. Conclude
echo "Pairs shorter than $minlen bases removed from $R1fq and $R2fq"
