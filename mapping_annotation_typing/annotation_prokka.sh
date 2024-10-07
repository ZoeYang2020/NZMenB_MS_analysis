#/bin/bash

module load prokka/1.14.5

files=assembly/correction/*_cormore300.fasta
for f in $files
do
x=$(basename $f _cormore300.fasta)
echo ${x}

prokka --compliant --prefix ${x} --outdir annotation/${x} \
--protein NC_017518.gbk \
--centre NZESR --locustag ${x} \
assembly/correction/${x}_cormore300.fasta
 
done
