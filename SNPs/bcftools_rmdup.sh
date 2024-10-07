#!/bin/bash
cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs
myvcf = /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/3_tail_10_test.vcf

bcftools view -H 3_tail_10_test.vcf | sort -u -k2,2n -k4,4d -k5,5d >3_head_SNPs_rmdup.vcfbcftools
