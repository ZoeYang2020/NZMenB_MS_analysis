#!/bin/bash
ref=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/ST-41/NMI01191_flye_polish.fasta
input_contigs=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/fasta/2371_clade41_92_fasta
output=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/parsnp/2371_clade41_92
parsnp=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/Parsnp-Linux64-v1.2/parsnp

$parsnp -c -x -u  -r $ref -d $input_contigs -o $output

