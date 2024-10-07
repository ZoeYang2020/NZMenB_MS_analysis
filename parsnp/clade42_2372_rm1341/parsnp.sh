#!/bin/bash
ref=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/NC_017518.fa
input_contigs=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/fasta/2372_42clade_fasta_rmNMI1341
output=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/parsnp/clade42_2372_rm1341
parsnp=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/Parsnp-Linux64-v1.2/parsnp

$parsnp -c -x -u  -r $ref -d $input_contigs -o $output

