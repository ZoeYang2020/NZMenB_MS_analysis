#!/bin/bash
clonalframeml=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/ClonalFrameML-master/src/ClonalFrameML 
tree=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonalframeml/clade42_2372_rmNMI1341/42clade_2372_rm1341_tree2
aln=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonalframeml/clade42_2372_rmNMI1341/42_2372_rmNMI1341parsnp.fasta
output=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonalframeml/clade42_2372_rmNMI1341/42_2372_rm1341clonalframeml
$clonalframeml $tree $aln $output -kappa 3.4426 -emsim 100 > 42_2372_rm1341clonalframeml.log
 #-kappa 4.947 -embranch true -embranch_dispersion 0.1 -initial_values "0.869777  0.0016913 0.034/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/ClonalFrameML-master/src/ClonalFrameML6936" > recombination/clonalframe/NZisolates/parsnp.filt.branch.log
