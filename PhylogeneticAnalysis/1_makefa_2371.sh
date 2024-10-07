#!/bin/bash
mv 2371SNPs_bialle.tab 2371SNPs
data=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/trees/2371SNPs
transit colum and row
awk '{for(i=1;i<=NF;i++)a[NR,i]=$i}END{for(i=1;i<=NF;i++){for(j=1;j<=NR;j++)printf a[j,i]" ";printf "\n"}}' $data>${data}.tr 
tail -2371 ${data}.tr >${data}.tr_sample
sed 's/ /\t/g' ${data}.tr_sample >${data}.tr_sample_tab
mergeID with tr_tab
perl mergefile_hash.pl 2371RIDs_IDs ${data}.tr_sample_tab  > ${data}.tr_sampleID_tab
awk -v OFS="\t" '$1=$1' ${data}.tr_sampleID_tab > ${data}.tr_sampleID_tab_1
cut -f 2,4-143829 ${data}.tr_sampleID_tab_1 >${data}_rename_tab
perl tab2fasta_2371.pl ${data}_rename_tab >${data}_rename_tab_fa
awk  '{gsub(" ","",$0); print;}' ${data}_rename_tab_fa >${data}.fa


