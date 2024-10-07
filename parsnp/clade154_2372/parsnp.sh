#!/bin/bash
ref=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/mapping/154_ref_NMI97348/NMI97348_flye_polish.fasta
input_contigs=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/fasta/2372_154clade_fasta
output=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/parsnp/clade154_2372
parsnp=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/Parsnp-Linux64-v1.2/parsnp



$parsnp -c -x -u  -r $ref -d $input_contigs -o $output

