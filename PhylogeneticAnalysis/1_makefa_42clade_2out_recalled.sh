#!/bin/bash
mv clade42_2outSNPs_bialle.tab clade42_2outSNPs
data=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/trees/clade42_2outSNPs
transit colum and row
awk '{for(i=1;i<=NF;i++)a[NR,i]=$i}END{for(i=1;i<=NF;i++){for(j=1;j<=NR;j++)printf a[j,i]" ";printf "\n"}}' $data>${data}.tr 
tail -1429 ${data}.tr >${data}.tr_sample
sed 's/ /\t/g' ${data}.tr_sample >${data}.tr_sample_tab
mergeID with tr_tab
perl mergefile_hash.pl 2490_42clade_2out_RIDs_IDs ${data}.tr_sample_tab  > ${data}.tr_sampleID_tab
awk -v OFS="\t" '$1=$1' ${data}.tr_sampleID_tab > ${data}.tr_sampleID_tab_1
cut -f 2,4-119784  ${data}.tr_sampleID_tab_1 >${data}_rename_tab
perl tab2fasta_249042clade_2out_recall.pl ${data}_rename_tab >${data}_rename_tab_fa
awk  '{gsub(" ","",$0); print;}' ${data}_rename_tab_fa >${data}.fa


