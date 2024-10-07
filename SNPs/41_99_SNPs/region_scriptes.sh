#/bin/bash

for x in freebayes_clade41_99_region1.sh freebayes_clade41_99_region2.sh freebayes_clade41_99_region3.sh freebayes_clade41_99_region4.sh freebayes_clade41_99_region5.sh

do 
 
tail -1 ${x} >>check_regions_settig

done 
