#devtools::install_github("mrc-ide/skygrowth")
#devtools::install_github("mdkarcher/phylodyn")
#install.packages("INLA", repos=c(getOption("repos"), INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)

setwd("/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/population_dynamic_changes")
library(skygrowth)
library(ape)
library(ggplot2)
library(phylodyn)
#library(INLA)

#load(system.file( 'NY_flu.rda', package='skygrowth')  )
?read.newick

MyTree <- read.nexus("./1541e6_time_Bactdating_figtree.nex")
MyTree

#help("skygrowth.map")       

fit_tau01 <- skygrowth.map( MyTree 
                      , res = 12*28 # Ne changes every 2 weeks
                      , tau0 = 1    # Smoothing parameter. If prior is not specified, this will also set the scale of the prior
)

pdf(file="./154_fittau01_out.pdf")
plot(fit_tau01)
dev.off()

write.csv(fit_tau01[[2]], file="./154_fittau01_out.csv")
capture.output(summary(fit_tau01), file = "154fit_tau01.txt")

#help("skygrowth.mcmc")

mcmcfit <- skygrowth.mcmc(MyTree, mhsteps = 1e+06, res = 12*28, tau0=1 )
write.csv(mcmcfit[[2]], file="./154_mcmcfittau01_out.csv")
capture.output(summary(mcmcfit), file = "154mcmcfit_tau01.txt")



pdf(file="/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/population_size_dynamics/154_mcmc_fittau01_out.pdf")
plot( mcmcfit )  + scale_y_log10(limits=c(.01, 1e7))
dev.off()






