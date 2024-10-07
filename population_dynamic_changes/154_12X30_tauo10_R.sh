#!/bin/bash
cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/population_dynamic_changes/154_1e7

module load R/4.0.3

Rscript population_dynamic_changes_154_noout_tau010.R 
