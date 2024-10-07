#!/bin/bash

data=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/trees/2371_41clade_92_41refSNPs

awk  '{gsub(" ","",$0); print;}' ${data}_rename_tab_fa >${data}.fa

input=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/trees/2371_41clade_92_41refSNPs_rename_tab_fa
x=$(basename $input .fa)
echo ${x}
perl convertAlignment.pl -i  $input -o /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/trees/${x}.phylip -f phylip

#$raxml -s  ${x}.phylip  -m GTRGAMMA -n raxml.out

#$raxml -T 6 -f a -p 12345  -s ${x}.phylip  -x 12345   -m GTRGAMMA -n raxml.out

#$raxml -T 6  -f a  -p 12345 -s ${x}.phylip -x 12345 -# 100 -m  GTRGAMMA -n  ${x}.raxml_bt10.out
