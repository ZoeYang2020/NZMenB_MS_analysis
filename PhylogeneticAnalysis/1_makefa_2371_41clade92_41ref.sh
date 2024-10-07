#!/bin/bash
mv 2371_41clade_92_41refSNPs_bialle.tab 2371_41clade_92_41refSNPs
data=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/trees/2371_41clade_92_41refSNPs
transit colum and row
awk '{for(i=1;i<=NF;i++)a[NR,i]=$i}END{for(i=1;i<=NF;i++){for(j=1;j<=NR;j++)printf a[j,i]" ";printf "\n"}}' $data>${data}.tr 
tail -92 ${data}.tr >${data}.tr_sample
sed 's/ /\t/g' ${data}.tr_sample >${data}.tr_sample_tab
mergeID with tr_tab
perl mergefile_hash.pl 2371_41clade_92RID_IDs ${data}.tr_sample_tab  > ${data}.tr_sampleID_tab
awk -v OFS="\t" '$1=$1' ${data}.tr_sampleID_tab > ${data}.tr_sampleID_tab_1
cut -f 2,4-54851 ${data}.tr_sampleID_tab_1 >${data}_rename_tab
perl tab2fasta_2371_41clade92_41ref.pl ${data}_rename_tab >${data}_rename_tab_fa
#awk  '{gsub(" ","",$0); print;}' ${data}_rename_tab_fa >${data}.fa


