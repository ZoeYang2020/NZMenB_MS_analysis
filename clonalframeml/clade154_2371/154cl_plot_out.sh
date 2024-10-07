#!/bin/bash

cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonalframeml/clade154_2371
module load R/4.0.3
Rscript cfml_results.R clade154_2371clonalframeml.out 
