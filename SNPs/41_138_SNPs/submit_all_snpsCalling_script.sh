#/bin/bash
cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/41_138_SNPs

for x in freebayes_clade41_138_region1.sh freebayes_clade41_138_region2.sh freebayes_clade41_138_region3.sh freebayes_clade41_138_region4.sh freebayes_clade41_138_region5.sh


do 
 
nohup ./${x} &

done 
