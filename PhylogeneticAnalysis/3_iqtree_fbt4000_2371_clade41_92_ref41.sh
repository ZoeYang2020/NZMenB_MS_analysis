#!/bin/bash
input=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/trees/2371_41clade_92_41refSNPs_rename_tab_fa.phylip
module load iqtree2/2.0.6
iqtree2 -s $input -nt 36  -B 4000 -alrt 2000 
