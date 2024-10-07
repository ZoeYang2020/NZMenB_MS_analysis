#/bin/bash
cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/41_99_SNPs

for x in freebayes_clade41_99_region1.sh freebayes_clade41_99_region2.sh freebayes_clade41_99_region3.sh freebayes_clade41_99_region4.sh freebayes_clade41_99_region5.sh


do 
 
nohup ./${x} &

done 
