#/bin/bash

#module load vcflib/1.0.0
module load freebayes/1.3.4

cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/154clade_SNPs
bam_file_list=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/154clade_SNPs/154clade_bam_list
ref=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/mapping/154_ref_NMI97348/NMI97348.fasta


#freebayes -p 1 -f NC_017518.fa -F 0.7 -b bowtie2_NZ0533/${x}_NZ_bwt_dpsh.bam > SNPs/individual_vcfs/${x}_NZ_raw.vcf
#freebayes -p 1 -f $ref -C 10 --min-alternate-fraction 0.7  --min-coverage 20 $input > 1158B.raw.vcf

freebayes -p 1 -f $ref -L $bam_file_list -r contig_1:1200000-1301000 > clade154_raw_region13.vcf
