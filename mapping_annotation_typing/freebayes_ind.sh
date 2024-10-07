#/bin/bash

module load vcflib/1.0.0
module load freebayes/1.3.4

files=bowtie2_NZ0533/*.bam
for f in $files
do
x=$(basename $f _NZ_bwt_dpsh.bam)
echo ${x}

freebayes -p 1 -f NC_017518.fa -F 0.7 -b bowtie2_NZ0533/${x}_NZ_bwt_dpsh.bam > SNPs/individual_vcfs/${x}_NZ_raw.vcf

vcffilter -f "QUAL > 30" -f "DP > 19" -f "SAR > 1" -f "SAF > 1" SNPs/individual_vcfs/${x}_NZ_raw.vcf > SNPs/individual_vcfs/${x}_NZ_f.vcf

sed 's/NC_017518/Chromosome/g' SNPs/individual_vcfs/${x}_NZ_f.vcf | snpeff -ud 100 -no-intron -s ${x}_summary Neisseria_meningitidis_nz_05_33 -o vcf -v  > SNPs/individual_vcfs/${x}_NZ_f_eff.vcf

sed -i 's/Chromosome/NC_017518/g' SNPs/individual_vcfs/${x}_NZ_f_eff.vcf

bgzip -c SNPs/individual_vcfs/${x}_NZ_f.vcf > SNPs/individual_vcfs/${x}_NZ_f.vcf.gz
tabix -p vcf SNPs/individual_vcfs/${x}_NZ_f.vcf.gz

done
