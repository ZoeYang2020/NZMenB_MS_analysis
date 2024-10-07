#/bin/bash

#module load vcflib/1.0.0
module load freebayes/1.3.4

cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs
bam_file_list=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/2499_rename_bam_list
ref=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/NC_017518.fa
regions=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/regions_10000
#ref_fai=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/NC_017518.fa.fai
#generate_region=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/fasta_generate_regions.py

#$generate_region $ref_fai 10000 > regions_10000
freebayes-parallel $regions 68 -p 1 -f $ref -L $bam_file_list > NZmenB2499_raw.vcf

#/usr/bin/freebayes-parallel [regions file] [ncpus] [freebayes arguments]

#freebayes -p 1 -f NC_017518.fa -F 0.7 -b bowtie2_NZ0533/${x}_NZ_bwt_dpsh.bam > SNPs/individual_vcfs/${x}_NZ_raw.vcf
#freebayes -p 1 -f $ref -C 10 --min-alternate-fraction 0.7  --min-coverage 20 $input > 1158B.raw.vcf

#freebayes -p 1 -f $ref -L $bam_file_list > NZMenB2499_raw.vcf
