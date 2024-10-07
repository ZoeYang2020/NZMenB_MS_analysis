#!/bin/bash

module load kraken/1.1



files=assembly/*_S*more300.fasta
for f in $files
do

x=$(basename $f .fasta)
echo ${x}

kraken --db /opt/bioinf/kraken/kraken_db/standard assembly/${x}.fasta | kraken-report --db /opt/bioinf/kraken/kraken_db/standard > kraken_rerun/${x}.kraken

done
