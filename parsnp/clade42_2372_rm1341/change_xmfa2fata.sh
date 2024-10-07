#!/bin/bash

input=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/parsnp/clade42_2372_rm1341/parsnp.xmfa
outdir=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/parsnp/clade42_2372_rm1341
/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/harvesttools-Linux64-v1.2/harvesttools  -x $input -M $outdir/42_2372_rmNMI1341parsnp.fasta
