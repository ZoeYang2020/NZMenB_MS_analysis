#/bin/bash


cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/42clade_SNPs
#export PERL5LIB=/home/zyang/NGS/transfer/bugnome/home/una/applications/vcftools_0.1.12b/perl/
#vcf-concat -f NZMenB2499_raw_region1.vcf  NZMenB2499_raw_region1_R1.vcf >test_comcatenae.vcf

cat clade42_raw_region1.vcf >combined_42clade_raw_SNPs.vcf
tail -1326 clade42_raw_region1.vcf>>combined_42clade_raw_SNPs.vcf
tail -2235 clade42_raw_region1_R1_24779_51000.vcf>>combined_42clade_raw_SNPs.vcf
tail -3578 clade42_raw_region1_R2_50000_101000.vcf>>combined_42clade_raw_SNPs.vcf
tail -5501 clade42_raw_region2.vcf>>combined_42clade_raw_SNPs.vcf
tail -6966 clade42_raw_region3.vcf>>combined_42clade_raw_SNPs.vcf
tail -6637 clade42_raw_region4.vcf>>combined_42clade_raw_SNPs.vcf
tail -7262 clade42_raw_region5.vcf>>combined_42clade_raw_SNPs.vcf
tail -7100 clade42_raw_region6.vcf>>combined_42clade_raw_SNPs.vcf
tail -7478 clade42_raw_region7.vcf>>combined_42clade_raw_SNPs.vcf
tail -7104 clade42_raw_region8.vcf>>combined_42clade_raw_SNPs.vcf
tail -6158 clade42_raw_region9.vcf>>combined_42clade_raw_SNPs.vcf
tail -6116 clade42_raw_region10.vcf>>combined_42clade_raw_SNPs.vcf
tail -7650 clade42_raw_region11.vcf>>combined_42clade_raw_SNPs.vcf
tail -5864 clade42_raw_region12.vcf>>combined_42clade_raw_SNPs.vcf
tail -6199 clade42_raw_region13.vcf>>combined_42clade_raw_SNPs.vcf
tail -5729 clade42_raw_region14.vcf>>combined_42clade_raw_SNPs.vcf
tail -6426 clade42_raw_region15.vcf>>combined_42clade_raw_SNPs.vcf
tail -7315 clade42_raw_region16.vcf>>combined_42clade_raw_SNPs.vcf
tail -7108 clade42_raw_region17.vcf>>combined_42clade_raw_SNPs.vcf
tail -7408 clade42_raw_region18.vcf>>combined_42clade_raw_SNPs.vcf
tail -4381 clade42_raw_region19.vcf>>combined_42clade_raw_SNPs.vcf
tail -6626 clade42_raw_region20.vcf>>combined_42clade_raw_SNPs.vcf
tail -6463 clade42_raw_region21.vcf>>combined_42clade_raw_SNPs.vcf
tail -10197 clade42_raw_region22.vcf>>combined_42clade_raw_SNPs.vcf


bcftools view -H combined_42clade_raw_SNPs.vcf |sort -u -k2,2n -k4,4d -k5,5d >combined_42clade_raw_SNPs_rd.vcf

head -62 clade42_raw_region1.vcf> head_62

cat combined_42clade_raw_SNPs_rd.vcf >>head_62 


mv head_62 42cladeNZmenB_raw.vcf


      #14521 NZMenB2499_raw_region10.vcf
      #16740 NZMenB2499_raw_region11.vcf
      # 4395 NZMenB2499_raw_region12.vcf
      # 2692 NZMenB2499_raw_region1_R1.vcf
      # 4489 NZMenB2499_raw_region1_R2.vcf
      # 3924 NZMenB2499_raw_region1_R3.vcf
      # 3577 NZMenB2499_raw_region1_R4.vcf
      # 1657 NZMenB2499_raw_region1.vcf
      #17117 NZMenB2499_raw_region2.vcf
      #17911 NZMenB2499_raw_region3.vcf
      #18365 NZMenB2499_raw_region4.vcf
      #15790 NZMenB2499_raw_region5.vcf
      #17190 NZMenB2499_raw_region6.vcf
      #15746 NZMenB2499_raw_region7.vcf
      #18188 NZMenB2499_raw_region8.vcf
      #19567 NZMenB2499_raw_region9.vcf






#cat -n Head_double_test|sort -uk2 |sort -nk1| cut -f2-  >test_head_rmduplication
