#!/bin/bash

module load vcflib/1.0.0
module load vcftools/0.1.15
module load freebayes/1.3.4
module load bowtie2/2.3.2

mkdir assembly/correction
CORDIR="assembly/correction"


files=trimmed/*_R1_P.fastq.gz
for f in $files
do

##change [common_bits_of_yourfile] common bits of your file name, delete brackets for example for processed_ARL09-165_S1_L001_R1_001.fastq, change [common_bits_of_yourfile] to _L001_R1_001.fastq, delete brackets

x=$(basename $f _R1_P.fastq.gz)
echo ${x}

read1=${x}_R1_P.fastq.gz
read2=$(echo $read1|sed 's/_R1_P.fastq.gz/_R2_P.fastq.gz/')

echo $read2

###make bowtie indexes
bowtie2-build -f assembly/${x}/contigs.fasta $CORDIR/${x}

##bowtie2 align to assemble
bowtie2 -p 20 -X 2000 --local -x $CORDIR/${x} \
-1 trimmed/$read1 -2 trimmed/$read2 -U trimmed/${x}_R1_uP.fastq.gz,trimmed/${x}_R2_uP.fastq.gz \
--un-conc $CORDIR/${x}_un.fastq -S $CORDIR/cor.sam 2>&1 | tee $CORDIR/${x}_log.txt

java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar SortSam INPUT=$CORDIR/cor.sam OUTPUT=$CORDIR/cor_s.bam SORT_ORDER=coordinate
java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar MarkDuplicates INPUT=$CORDIR/cor_s.bam OUTPUT=$CORDIR/${x}_dps.bam Metrics_FILE=$CORDIR/${x}metrics.txt
java -Xmx16g -jar /opt/bioinf/picard/picard-2.10.10/bin/picard.jar BuildBamIndex INPUT=$CORDIR/${x}_dps.bam

###freebayes
freebayes -p 1 -f assembly/${x}/contigs.fasta \
--min-alternate-fraction 0.9 $CORDIR/${x}_dps.bam | \
vcfallelicprimitives -kg | vcffilter -f "TYPE = snp" -f "DP > 9" | \
bgzip -c > $CORDIR/${x}.vcf.gz
tabix -p vcf $CORDIR/${x}.vcf.gz

####consensus fasta
cat assembly/${x}/contigs.fasta | vcf-consensus $CORDIR/${x}.vcf.gz > $CORDIR/${x}_cor.fasta
 
awk 'BEGIN {FS="_"} $4>=300 {print;flag=1;next}/>/{flag=0}flag' $CORDIR/${x}_cor.fasta > $CORDIR/${x}_cormore300.fasta
diff $CORDIR/${x}_cormore300.fasta assembly/${x}.fasta | sed -e '/^[0-9]/d' | sed 's/> //' > $CORDIR/${x}corless300.fasta

done
