#!/bin/bash
cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/nucleotide_diversity
mega=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/nucleotide_diversity/megacc
input_path=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/nucleotide_diversity

#$mega -a $input_path/distance_estimation_avg_overall_pops_nucleotide_TNei.mao  -d $input_path/test_mega.fa 

#$mega -a $input_path/distance_estimation_avg_overall_pops_nucleotide.mao   -d $inpout_path/154cladeSNPs_.fa

$mega -a $input_path/distance_estimation_overall_mean_nucleotide.mao -d $input_path/clade154_2outSNPs_rm2.fa
#$mega -a $input_path/distance_estimation_overall_mean_nucleotide.mao -d $input_path/1995_2003_rm.fa 
#$mega -a $input_path/distance_estimation_overall_mean_nucleotide.mao -d $input_path/2004_2008_rm.fa
#$mega -a $input_path/distance_estimation_overall_mean_nucleotide.mao -d $input_path/2009_2019_rm.fa
#$mega -a $input_path/distance_estimation_overall_mean_nucleotide.mao -d $input_path/2371SNPs.fa
#$mega -a $input_path/distance_estimation_overall_mean_nucleotide.mao -d $input_path/2371_154clade_2outSNPs.fa
#$mega -a $input_path/distance_estimation_overall_mean_nucleotide.mao -d $input_path/2371IDs_42clade_2outSNPs.fa
