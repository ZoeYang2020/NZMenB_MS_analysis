!/bin/bash
cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/nucleotide_diversity
mega=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/nucleotide_diversity/megacc
input_path=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/nucleotide_diversity

#$mega -a $input_path/distance_estimation_avg_overall_pops_nucleotide_TNei.mao  -d $input_path/test_mega.fa 

#$mega -a $input_path/distance_estimation_avg_overall_pops_nucleotide.mao   -d $inpout_path/154cladeSNPs_.fa

$mega -a $input_path/distance_estimation_overall_mean_nucleotide.mao -d $input_path/clade154_2outSNPs.fa
$mega -a $input_path/distance_estimation_overall_mean_nucleotide.mao -d $input_path/clade42_2outSNPs_bialle.fa
