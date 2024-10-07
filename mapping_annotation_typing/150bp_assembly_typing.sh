#!/bin/bash

#load modules needed for analysis

#module load fastp/0.20.1
module load spades/3.13.0
module load kraken/1.1
module load ispcr/33
module load meningotype/0.8.2-beta-01

#options to define directories where the reads are
miseq_reads_directory=''
designation_directory=''
name=''

while getopts 'r:d:n:h' opt; do
  case $opt in
    r) miseq_reads_directory=$OPTARG ;;
    d) designation_directory=$OPTARG ;;
    n) name=$OPTARG ;;
    h) echo "Usage: bash 150bp_assembly_typing.sh -r <miseq_reads_directory> -d <designation_directory> -n <sequence ending ie _R1.fastq.gz etc> -h <help>"
        exit
        ;;
  esac
done

#reference_genome =/media/data/[where your references are]

#mkdir ${designation_directory}/trimmed
mkdir ${designation_directory}/assembly
mkdir ${designation_directory}/typing

trimmed_directory=${designation_directory}/trimmed
spades_directory=${designation_directory}/assembly
typing=${designation_directory}/typing


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

#fastp --in1  ${miseq_reads_directory}/$read1 --in2  ${miseq_reads_directory}/$read2 -g -q 20 -f 5 -t 5 -F 5 -T 5 -l 70 --cut_right --cut_right_window_size 4 --cut_right_mean_quality 20 --out1 ${trimmed_directory}/${x}_R1_P.fastq.gz --out2 ${trimmed_directory}/${x}_R1_P.fastq.gz --unpaired1 ${trimmed_directory}/${x}_R1_uP.fastq.gz --unpaired2 ${trimmed_directory}/${x}_R2_uP.fastq.gz -h ${trimmed_directory}/${x}.html

##remove phix sequences, don't need to run usually if want to run remove #
#bowtie2 -p 30 -x /NGS/transfer/bugnome/media/data/bwtindexes/phix174_ind -1 ${trimmed_directory}/${x}_R1_P.fastq.gz -2 ${trimmed_directory}/${x}_R2_P.fastq.gz --un-conc ${trimmed_directory}/${x}_P.fastq.gz

##de novo assembly
spades.py -k 21,33,55,77,99 -t 10 -m 20 --careful --cov-cutoff auto -1 ${miseq_reads_directory}/$read1 -2 ${miseq_reads_directory}/$read2 -o ${spades_directory}/${x}

##fetch assembled sequences
cp ${spades_directory}/${x}/contigs.fasta ${spades_directory}/${x}.fasta
awk 'BEGIN {FS="_"} $4>=300 {print;flag=1;next}/>/{flag=0}flag' ${spades_directory}/${x}.fasta > ${spades_directory}/${x}more300.fasta
diff ${spades_directory}/${x}more300.fasta assembly/${x}.fasta | sed -e '/^[0-9]/d' | sed 's/> //' > ${spades_directory}/${x}less300.fasta

##identify sepcies

kraken --db /opt/bioinf/kraken/kraken_db/standard ${spades_directory}/${x}more300.fasta | kraken-report --db /opt/bioinf/kraken/kraken_db/standard > ${spades_directory}/${x}.kraken

##typing
meningotype --all  ${spades_directory}/${x}/contigs.fasta > ${typing}/${x}_type.tsv


done
