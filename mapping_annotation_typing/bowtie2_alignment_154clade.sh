#!/bin/bash

module load bowtie2/2.3.2
data=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/fastq_link/clade_154_fastq/*_R1_P.fastq.gz
input_folder=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/fastq_link/clade_154_fastq
output=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/mapping
output_unmaped=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/mapping/unmapped



##options to define directories where the reads are
#name=''

#while getopts 'n:d:h' opt; do
#  case $opt in
#    n) name=$OPTARG ;;i
#    d) output=$OPTARG;;
#    h) echo "Usage: bash bowtie2_aligenment.sh -n <file prefix to be processed> -d <run_session_name> -h <help>"
#        exit
#        ;;
#  esac
#done


for f in $data
do

##change [common_bits_of_yourfile] common bits of your file name, delete brackets for example for processed_ARL09-165_S1_L001_R1_001.fastq, change [common_bits_of_yourfile] to _L001_R1_001.fastq, delete brackets

x=$(basename $f _R1_P.fastq.gz)
echo ${x}

read1=${x}_R1_P.fastq.gz
read2=$(echo $read1|sed 's/_R1_P.fastq.gz/_R2_P.fastq.gz/')

echo $read2

##bowtie2 align to NZ
bowtie2 -p 20 -X 2000 --local -x /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/mapping/154_ref_NMI97348/NMI97348 -1 $input_folder/$read1 -2 $input_folder/$read2 -U $input_folder/${x}_R1_uP.fastq.gz,$input_folder/${x}_R2_uP.fastq.gz --un-conc $output_unmaped/${x}_un.fastq -S $output/${x}.sam 2>&1 | tee ${x}log.txt

java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar SortSam INPUT=$output/${x}.sam OUTPUT=$output/${x}_s.bam SORT_ORDER=coordinate 2>>${x}log.txt 

java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar MarkDuplicates REMOVE_DUPLICATES=TRUE INPUT=$output/${x}_s.bam OUTPUT=$output/${x}_dps.bam Metrics_FILE=$output/${x}metrics.txt 2>>${x}log.txt

java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar AddOrReplaceReadGroups INPUT=$output/${x}_dps.bam OUTPUT=$output/${x}.bam RGID=${x} RGSM=${x} RGLB=${x} RGPU=1 RGPL=illumin 2>>${x}log.txt 

java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar BuildBamIndex INPUT=$output/${x}.bam 2>>${x}log.txt 

done
