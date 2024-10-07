#devtools::install_github("mrc-ide/skygrowth")
#devtools::install_github("mdkarcher/phylodyn")
#install.packages("INLA", repos=c(getOption("repos"), INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)

setwd("/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/population_dynamic_changes/154_1e7")

library(ape)
library(geiger)
library(skygrowth)
library(ggplot2)
library(phylodyn)

MyTree<-read.nexus("./154_965_treeBactDating1e7.nex")
MyTree
cladeA = c("NMI9039", "NMI9217")
nout1e7_154tree<- drop.tip(MyTree, cladeA)
nout1e7_154tree


fit_tau010 <- skygrowth.map( nout1e7_154tree 
                            , res = 12*30 # Ne changes every 2 weeks
                            , tau0 = 10    # Smoothing parameter. If prior is not specified, this will also set the scale of the prior
)

pdf(file="./nout1e7154_fittau010_out.pdf")
plot(fit_tau010)
dev.off()

write.csv(fit_tau010[[2]], file="./nout1e7154_fittau010_out.csv")
capture.output(summary(fit_tau010), file = "nout1e7154fit_tau010.txt")

#help("skygrowth.mcmc")

mcmcfit <- skygrowth.mcmc(nout1e7_154tree, mhsteps = 1e+06, res = 12*30, tau0=1 )
write.csv(mcmcfit[[2]], file="./nout1e7154_mcmcfittau010_out.csv")
capture.output(summary(mcmcfit), file = "nout1e7154mcmcfit_tau010.txt")


pdf(file="./nout1e7154_mcmc_fittau010_out.pdf")
plot( mcmcfit )  + scale_y_log10(limits=c(.01, 1e7))
dev.off()



