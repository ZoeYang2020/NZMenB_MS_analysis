#/bin/bash


cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/41_138_SNPs
#export PERL5LIB=/home/zyang/NGS/transfer/bugnome/home/una/applications/vcftools_0.1.12b/perl/
#vcf-concat -f NZMenB2499_raw_region1.vcf  NZMenB2499_raw_region1_R1.vcf >test_comcatenae.vcf



cat clade41_138_raw_region1.vcf >combined_41_138_raw_SNPs.vcf

tail -15291  clade41_138_raw_region2.vcf >>combined_41_138_raw_SNPs.vcf 
tail -18356  clade41_138_raw_region3.vcf >>combined_41_138_raw_SNPs.vcf 
tail -16425  clade41_138_raw_region4.vcf >>combined_41_138_raw_SNPs.vcf
tail -6259   clade41_138_raw_region5.vcf >>combined_41_138_raw_SNPs.vcf


bcftools view -H combined_41_138_raw_SNPs.vcf  |sort -u -k2,2n -k4,4d -k5,5d >combined_41_138_raw_SNPs_rmdup.vcf

head -62  clade41_138_raw_region1.vcf > head_62

cat combined_41_138_raw_SNPs_rmdup.vcf >>head_62 


mv head_62 41_138_raw.vcf


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
