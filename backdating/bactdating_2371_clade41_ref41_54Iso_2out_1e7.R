#devtools::install_github("xavierdidelot/BactDating")

setwd("/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/20220728_For_Una")

library(BactDating)
library(ape)
library(ggplot2)
set.seed(0)
#?BactDating
getwd()
tre_41_ref41_54iso_2out=loadCFML(prefix='./41clade_2371_92_41ref_54iso_2out_clonalframeml.out')
tre_41_ref41_54iso_2out$tip.label
clade41_ref41_54iso_2out_2371IDs<-tre_41_ref41_54iso_2out$tip.label
clade41_ref41_54iso_2out_2371IDs
write.csv(clade41_ref41_54iso_2out_2371IDs,"./clade41_ref41_54iso_2out_2371IDs.csv", row.names = FALSE)

dates=c(2003.869,2006.532,2003.039,2004.880,2004.644,2003.433,2004.929,2002.789,2000.028,1999.455,1997.863,1996.540,1997.934,1996.877,2001.584,1992.792,1992.959,1994.792,1995.625,1996.458,1995.625,1995.625,1995.625,1999.573,2003.817,1996.540,1993.792,1997.677,2001.392,1999.660,1999.674,2004.578,1997.499,1998.231,2006.110,2001.655,2003.945,1998.031,1995.540,1995.792,1995.625,1995.373,1994.710,1995.710,1996.373,1996.540,1993.625,1995.291,1993.206,1993.540,1995.044,2005.513,2007.044,1999.800,1992.127,1990.877)
dates


pdf(file="./41_ref41_54iso_2out_2371root_to_tip_correlation.pdf")
svg(file="./41_ref41_54iso_2out_2371root_to_tip_correlation.svg")
root_to_tip_correlation <-roottotip(tre_41_ref41_54iso_2out,dates, rate=NA,permTest = 10000, showFig=T, colored = T,showPredInt = "gamma", showText=T, showTree = T)
dev.off()


res=bactdate(tre_41_ref41_54iso_2out,dates,useRec=T, nbIts=1e7)


pdf(file="./41_ref41_54iso_2out_1e7_2371MCMCTrace.pdf")
plot(res, 'trace')
dev.off()


pdf(file="./41_ref41_54iso_2out_1e7_2371time_Bactdating.pdf")
plot(res,'treeCI')
dev.off()

#export the result
l=as.treedata.resBactDating(res)
l
library(treeio)
obj=methods::new('treedata',phylo=l[[1]],data=dplyr::tbl_df(as.data.frame(l[[2]])))
obj
write.beast(obj,'41_ref41_54iso_2out_2371_treeBactDating1e7.nex')







