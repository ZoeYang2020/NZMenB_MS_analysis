#!/bin/bash

#load modules needed for analysis

module load fastp/0.20.1

#options to define directories where the reads are
miseq_reads_directory=''
designation_directory=''
name=''

while getopts 'r:d:n:h' opt; do
  case $opt in
    r) miseq_reads_directory=$OPTARG ;;
    d) designation_directory=$OPTARG ;;
    n) name=$OPTARG ;;
    h) echo "Usage: bash fastp_trim.sh -r <miseq_reads_directory> -d <designation_directory> -n <sequence ending ie _R1.fastq.gz etc> -h <help>"
        exit
        ;;
  esac
done

#reference_genome =/media/data/[where your references are]

mkdir ${designation_directory}/trimmed
#mkdir ${designation_directory}/assembly
#mkdir ${designation_directory}/bowtie2_NZ0533

trimmed_directory=${designation_directory}/trimmed
#spades_directory=${designation_directory}/assembly


##Define the files to be processed, for KSC_miseq reads no need to change 

files=${miseq_reads_directory}/*_$name
for f in $files
do

##Define the files to be processed, for KSC_miseq reads no need to change 

if [[ "$name" == "1.fastq.gz" ]];
 then
     x=$(basename $f _$name)
     echo ${x}
     read1=${x}_$name
     read2=${x}_2.fastq.gz
     echo $read2
 else
    echo next
fi

if [[ "$name" == "R1.fastq.gz" ]];
 then
     x=$(basename $f _$name)
     echo ${x}
     read1=${x}_$name
     read2=${x}_R2.fastq.gz
     echo $read2
 else
   echo next
fi

if [[ "$name" == "R1.fastq" ]];
 then
     x=$(basename $f _$name)
     echo ${x}
     read1=${x}_$name
     read2=${x}_R2.fastq
     echo $read2
 else
   echo next
fi

if [[ "$name" == "L001_R1_001.fastq" ]];
 then
     x=$(basename $f _$name)
     echo ${x}
     read1=${x}_$name
     read2=${x}_L001_R2_001.fastq
     echo $read2
 else
   echo next
fi

if [[ "$name" == "L001_R1_001.fastq.gz" ]];
 then
     x=$(basename $f _$name)
     echo ${x}
     read1=${x}_$name
     read2=${x}_L001_R2_001.fastq.gz
     echo $read2
 else
   echo next
fi

if [[ "$name" == "R1_001.fastq.gz" ]];
 then
     x=$(basename $f _$name)
     echo ${x}
     read1=${x}_$name
     read2=${x}_R2_001.fastq.gz
     echo $read2
 else
   echo next
fi
##quality trimming

fastp --in1  ${miseq_reads_directory}/$read1 --in2  ${miseq_reads_directory}/$read2 -g -q 20 -f 5 -t 5 -F 5 -T 5 -l 70 --cut_right --cut_right_window_size 4 --cut_right_mean_quality 20 --out1 ${trimmed_directory}/${x}_R1_P.fastq.gz --out2 ${trimmed_directory}/${x}_R2_P.fastq.gz --unpaired1 ${trimmed_directory}/${x}_R1_uP.fastq.gz --unpaired2 ${trimmed_directory}/${x}_R2_uP.fastq.gz -h ${trimmed_directory}/${x}.html


##copy to /NGS/active/IPL/MENINGO/analysis/HRC

cp ${trimmed_directory}/${x}_*.fastq.gz /NGS/active/IPL/MENINGO/analysis/HRC/trimmed

##remove phix sequences, don't need to run usually if want to run remove #
#bowtie2 -p 20 -x /NGS/transfer/bugnome/media/data/bwtindexes/phix174_ind -1 ${trimmed_directory}/${x}_R1_P.fastq.gz -2 ${trimmed_directory}/${x}_R2_P.fastq.gz  -U trimmed/${x}_R1_uP.fastq,trimmed/${x}_R2_uP.fastq --un-conc ${trimmed_directory}/${x}_P.fastq  --un ${trimmed_directory}/${x}_uP.fastq

done
