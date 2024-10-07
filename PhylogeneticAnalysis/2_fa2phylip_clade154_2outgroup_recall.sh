#!/bin/bash
input=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/trees/clade154_2outSNPs.fa
x=$(basename $input .fa)
echo ${x}
perl convertAlignment.pl -i  $input -o /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/trees/${x}.phylip -f phylip

#$raxml -s  ${x}.phylip  -m GTRGAMMA -n raxml.ou

#$raxml -T 6 -f a -p 12345  -s ${x}.phylip  -x 12345   -m GTRGAMMA -n raxml.out

#$raxml -T 6  -f a  -p 12345 -s ${x}.phylip -x 12345 -# 100 -m  GTRGAMMA -n  ${x}.raxml_bt10.out
