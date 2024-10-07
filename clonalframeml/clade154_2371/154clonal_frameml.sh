#!/bin/bash
clonalframeml=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/ClonalFrameML-master/src/ClonalFrameML 
tree=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonalframeml/clade154_2371/clade154_tre_2371
aln=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonalframeml/clade154_2371/154_2371parsnp.fasta
output=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonalframeml/clade154_2371/clade154_2371clonalframeml.out
$clonalframeml $tree $aln $output -kappa 3.427797 -emsim 100 >clade154_2371clonalframeml.log
 #-kappa 4.947 -embranch true -embranch_dispersion 0.1 -initial_values "0.869777  0.0016913 0.034/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/ClonalFrameML-master/src/ClonalFrameML6936" > recombination/clonalframe/NZisolates/parsnp.filt.branch.log
