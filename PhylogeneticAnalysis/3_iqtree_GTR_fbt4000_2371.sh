#!/bin/bash
input=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/trees/2490_fbt4000/2490SNPs.phylip
module load iqtree2/2.0.6
iqtree2 -s $input -nt 48  -m GTR+F+R6 -B 4000 -alrt 2000
