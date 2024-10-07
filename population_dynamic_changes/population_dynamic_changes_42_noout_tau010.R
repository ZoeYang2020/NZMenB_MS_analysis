#devtools::install_github("mrc-ide/skygrowth")
#devtools::install_github("mdkarcher/phylodyn")
#install.packages("INLA", repos=c(getOption("repos"), INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)

setwd("/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/population_dynamic_changes")

library(ape)
library(geiger)
library(skygrowth)
library(ggplot2)
library(phylodyn)
#getwd()
#list.files (getwd())
MyTree<-read.nexus("./42_1427_treeBactDating1e6.nex")
MyTree
cladeA = c("NMI9039", "NMI9217")
nout_42tree<- drop.tip(MyTree, cladeA)
nout_42tree


fit_tau010 <- skygrowth.map( nout_42tree 
                            , res = 12*30 # Ne changes every 2 weeks
                            , tau0 = 10    # Smoothing parameter. If prior is not specified, this will also set the scale of the prior
)

pdf(file="./nout42_fittau010_out.pdf")
plot(fit_tau010)
dev.off()

write.csv(fit_tau010[[2]], file="./nout42_fittau010_out.csv")
capture.output(summary(fit_tau010), file = "nout42fit_tau010.txt")

#help("skygrowth.mcmc")

mcmcfit <- skygrowth.mcmc(nout_42tree, mhsteps = 1e+06, res = 12*30, tau0=1 )
write.csv(mcmcfit[[2]], file="./nout42_mcmcfittau010_out.csv")
capture.output(summary(mcmcfit), file = "nout42mcmcfit_tau010.txt")


pdf(file="./nout42_mcmc_fittau010_out.pdf")
plot( mcmcfit )  + scale_y_log10(limits=c(.01, 1e7))
dev.off()



