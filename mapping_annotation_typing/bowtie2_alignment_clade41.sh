#!/bin/bash

module load bowtie2/2.3.2

#options to define directories where the reads are
#name=''

#while getopts 'n:d:h' opt; do
#  case $opt in
#    n) name=$OPTARG ;;
#    d) output=$OPTARG;;
#    h) echo "Usage: bash bowtie2_aligenment.sh -n <file prefix to be processed> -d <run_session_name> -h <help>"
#        exit
#        ;;
#  esac
#done

mkdir bowtie2_alignment
mkdir bowtie2_alignment/$output

files=fastq_links/*_R1_P.fastq.gz
for f in $files
do

##change [common_bits_of_yourfile] common bits of your file name, delete brackets for example for processed_ARL09-165_S1_L001_R1_001.fastq, change [common_bits_of_yourfile] to _L001_R1_001.fastq, delete brackets

x=$(basename $f _R1_P.fastq.gz)
echo ${x}

read1=${x}_R1_P.fastq.gz
read2=$(echo $read1|sed 's/_R1_P.fastq.gz/_R2_P.fastq.gz/')

echo $read2

##bowtie2 align to NZ
bowtie2 -p 20 -X 2000 --local -x NMI01191 -1 fastq_links/$read1 -2 fastq_links/$read2 -U fastq_links/${x}_R1_uP.fastq.gz,fastq_links/${x}_R2_uP.fastq.gz --un-conc bowtie2_alignment/${x}_NZ_un.fastq -S bowtie2_alignment/$output/NZ_bwt.sam 2>&1 | tee bowtie2_alignment/${x}_log.txt

java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar SortSam INPUT=bowtie2_alignment/$output/NZ_bwt.sam OUTPUT=bowtie2_alignment/$output/NZ_bwt_s.bam SORT_ORDER=coordinate

java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar MarkDuplicates REMOVE_DUPLICATES=TRUE INPUT=bowtie2_alignment/$output/NZ_bwt_s.bam OUTPUT=bowtie2_alignment/$output/NZ_bwt_dps.bam Metrics_FILE=bowtie2_alignment/${x}metrics.txt

java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar AddOrReplaceReadGroups INPUT=bowtie2_alignment/$output/NZ_bwt_dps.bam OUTPUT=bowtie2_alignment/${x}_NZ_bwt_dpsh.bam RGID=${x} RGSM=${x} RGLB=${x} RGPU=1 RGPL=illumina

java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar BuildBamIndex INPUT=bowtie2_alignment/${x}_NZ_bwt_dpsh.bam

done
