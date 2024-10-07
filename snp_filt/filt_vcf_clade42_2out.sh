#!/bin/bash
cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/snps_filt
export PERL5LIB=/home/zyang/NGS/transfer/bugnome/home/una/applications/vcftools_0.1.12b/perl/
input=/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/42clade_SNPs/42cladeNZmenB_raw.vcf
x=clade42_2out

#vcftools --vcf ${input} --keep ${x}RIDs  --recode --recode-INFO-all  --out  ${x}

mv $input ${x}.vcf


vcffilter -f "AC > 0" ${x}.vcf  > ${x}AC.vcf

#all 1154 samples contains either a reference or a mutation
#vcffilter -f "AN = 1174" ${x}AC.vcf > ${x}ACAN.vcf

vcffilter -f "QUAL > 30" ${x}AC.vcf > ${x}Qual.vcf

#remove depth lower than 10, and make sure there is no missing data
vcftools --vcf ${x}Qual.vcf  --minDP 10 --max-missing 1 --recode --recode-INFO-all --out ${x}QualDP.vcf

mv ${x}QualDP.vcf.recode.vcf ${x}QualDP.vcf

#extract site of snp,or mnp, or complex, can't using vcftools remove indel for this steo, it will remove all the mnp...just keep snp
vcffilter -f "TYPE = snp | TYPE = mnp | TYPE = complex"  ${x}QualDP.vcf > ${x}QualDPsmpcom.vcf

#get the core variation because the up step will remove some Genotype as . due to indel or ins together with snp, mnp. or complex variation
grep -vw '\.:.*' ${x}QualDPsmpcom.vcf > ${x}QualDPsmpcomCore.vcf
grep  '\.:.*' ${x}QualDPsmpcom.vcf > ${x}QualDPsmpcomAcc.vcf

#filtot frequency <0.7 sites
vcffilter -g 'RO / DP < 0.3' ${x}QualDPsmpcomCore.vcf > ${x}QualDPsmpcomCore07.vcf

#replace the . which filted by up step reference allele to 0, the reference type
sed 's/\t\./\t0/g' ${x}QualDPsmpcomCore07.vcf > ${x}QualDPsmpcomCore07Rf0.vcf

#decomplex
/usr/bin/vcfallelicprimitives ${x}QualDPsmpcomCore07Rf0.vcf >${x}QualDPsmpcomCore07Rf0_p.vcf

#remove indels
vcftools --vcf ${x}QualDPsmpcomCore07Rf0_p.vcf --remove-indels  --recode --recode-INFO-all  --out ${x}QualDPsmpcomCore07Rf0_pNoindel.vcf

mv ${x}QualDPsmpcomCore07Rf0_pNoindel.vcf.recode.vcf ${x}QualDPsmpcomCore07Rf0_pNoindel.vcf

sed 's/.:.:.:.:.:.:.:./0/g'  ${x}QualDPsmpcomCore07Rf0_pNoindel.vcf  >${x}QualDPsmpcomCore07Rf0_pNoindelRf0.vcf

/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/bin/bedtools intersect -a ${x}QualDPsmpcomCore07Rf0_pNoindelRf0.vcf -b NZRef_tandem_ref_bed -v > ${x}_rmtanden.vcf

head -66 ${x}QualDPsmpcomCore07Rf0_pNoindelRf0.vcf > ${x}_header.vcf
cat ${x}_rmtanden.vcf >>${x}_header.vcf

input2=${x}_header.vcf

cat ${input2} |vcf-subset -r -t SNPs -e >${input2}SNPs

vcftools --vcf ${input2}SNPs --min-alleles 2 --max-alleles 2  --recode --recode-INFO-all --out ${x}SNPs_bialle

sed 's/0:.:.:.:.:.:.:./0/g' ${x}SNPs_bialle.recode.vcf > ${x}SNPs_bialle

gzip -c ${x}SNPs_bialle  > ${x}SNPs_bialle.gz

zcat ${x}SNPs_bialle.gz | vcf-to-tab | sed 's|/||g' > ${x}SNPs_bialle.tab

vcftools --extract-FORMAT-info GT --vcf ${x}SNPs_bialle --out ${x}SNPs_bialle_GT
