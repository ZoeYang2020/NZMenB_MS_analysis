#!/bin/bash
clonalframeml=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/ClonalFrameML-master/src/ClonalFrameML 
tree=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonalframeml/41clade_2371_92_41ref/41clade_92_41refSNPs.contree
aln=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonalframeml/41clade_2371_92_41ref/2371_clade41_92parsnp_rfa.fasta
output=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonalframeml/41clade_2371_92_41ref/41clade_2371_92_41refclonalframeml.out
$clonalframeml $tree $aln $output -kappa 3.5969 -emsim 100 >clade41_2371_92_41refclonalframeml.log
 #-kappa 4.947 -embranch true -embranch_dispersion 0.1 -initial_values "0.869777  0.0016913 0.034/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/ClonalFrameML-master/src/ClonalFrameML6936" > recombination/clonalframe/NZisolates/parsnp.filt.branch.log
