#/bin/bash
cd /home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/SNPs/154clade_SNPs
for x in freebayes_clade154_region10.sh freebayes_clade154_region11.sh freebayes_clade154_region12.sh freebayes_clade154_region13.sh freebayes_clade154_region14.sh freebayes_clade154_region15.sh freebayes_clade154_region16.sh freebayes_clade154_region17.sh freebayes_clade154_region18.sh freebayes_clade154_region19.sh freebayes_clade154_region1.sh freebayes_clade154_region20.sh freebayes_clade154_region21.sh freebayes_clade154_region22.sh freebayes_clade154_region2.sh freebayes_clade154_region3.sh freebayes_clade154_region4.sh freebayes_clade154_region5.sh freebayes_clade154_region6.sh freebayes_clade154_region7.sh freebayes_clade154_region8.sh freebayes_clade154_region9.sh

do 
 
nohup ./${x} &

done 
