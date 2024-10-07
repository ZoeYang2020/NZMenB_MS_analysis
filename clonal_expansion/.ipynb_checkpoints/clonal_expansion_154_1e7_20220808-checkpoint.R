sessionInfo()


library(backports)
library(cli)
library(colorspace)
library(deSolve)
library(ff)
library(ps)
library(Rcpp)
library(rlang)
library(vctrs)
library(ape)
library(usethis)
library(pillar)
library(tibble)
library(dplyr)
library(tidyverse)


remotes::install_github("YuLab-SMU/tidytree")
library(dplyr)


install.packages("rlang")

install.packages("pak")
pak::pkg_install("r-lib/rlang")

install.packages("rlang")

library(rlang)


check_installed(rlang) 

devtools::install_version('rvcheck',version='0.1.8')
BiocManager::install("ggtree", force = TRUE)

library(ggtree)



if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree",force = TRUE)




devtools::install_github('dhelekal/CaveDive')
library(CaveDive)
#CaveDive::build_coal_tree()

#trying R3.6.1, but cavedave need R>4.0.0
#trying R4.0.5
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree",force = TRUE)

BiocManager::install("backports", force = TRUE)


install.packages("backports")


library(ggtree)

setwd("/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonal_expansion")
getwd()



## ---- echo = FALSE, message = FALSE-------------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
tandard_priorsstandard_priorsptions(tibble.print_min = 4, tibble.print_max = 4)


## ----setup, message=FALSE
library(ape)
library(CaveDive)
library(treeio)
library(ggtree)
set.seed(1)

## ----parametrise priors, message=FALSE----------------------------------------
expansion_rate<-1 
N_mean_log<-5 
N_sd_log<-1
t_mid_rate<-5
K_sd_log<-1/2 
exp_time_nu<-1/3
exp_time_kappa<-1/4

## ----priors, message=FALSE----------------------------------------------------
priors <- standard_priors(expansion_rate=expansion_rate, 
                          N_mean_log=N_mean_log, 
                          N_sd_log=N_sd_log, 
                          t_mid_rate=t_mid_rate, 
                          K_sd_log=K_sd_log, 
                          exp_time_nu=exp_time_nu, 
                          exp_time_kappa=exp_time_kappa)
print(priors)


## ----set concentration, message=FALSE-----------------------------------------
concentration <- 2

## ----simulate a phylogeny 1, out.width="50%", dpi=300, fig.align="center", message=FALSE----
tip_times <- runif(100, 0, 5)
tip_times <- tip_times - max(tip_times)
tip_times <- tip_times[order(-tip_times)]

phy1 <- simulate_expansion_phylo(priors, 
                                 tip_times, 
                                 concentration=concentration, 
                                 collapse_singles=F)
head(phy1)
plot_structured_tree(phy1$tree, phy1$params$n_exp+1)

## ----simulate a phylogeny 2, out.width="50%",dpi=300, fig.align="center", message=FALSE----
tip_times <- runif(100, 0, 5)
tip_times <- tip_times - max(tip_times)
tip_times <- tip_times[order(-tip_times)]

phy2 <- simulate_expansion_phylo(priors, 
                                 tip_times, 
                                 concentration=concentration, 
                                 given=list(n_exp=3, N=100), 
                                 collapse_singles=F)
print(phy2$params)
plot_structured_tree(phy2$tree, phy2$params$n_exp+1)

## ----simulate a phylogeny 3, out.width="50%", dpi=300, fig.align="center", message=FALSE----
tip_times <- runif(100, 0, 5)
tip_times <- tip_times - max(tip_times)

corr_x <- c(rnorm(30,mean=10,sd=1),rnorm(30,mean=2,sd=1),rnorm(40, mean=2, sd=1))[order(-tip_times)]
corr_y <- c(rnorm(30,mean=2,sd=1),rnorm(30,mean=10,sd=1),rnorm(40, mean=2, sd=1))[order(-tip_times)]
corr_z <- c(rnorm(30,mean=2,sd=1),rnorm(30,mean=2,sd=1),rnorm(40, mean=10, sd=1))[order(-tip_times)]

correlates <- data.frame(x=corr_x, y=corr_y, z=corr_z)

tip_colours <- c(rep(1,30), rep(2,30), rep(3,40))[order(-tip_times)]

tip_times <- tip_times[order(-tip_times)]

phy3 <- simulate_expansion_phylo(priors, 
                                 tip_times, 
                                 concentration=concentration, 
                                 given=list(N=200, K=c(200,180), n_exp=2, tip_colours=tip_colours), 
                                 collapse_singles=F)

times <- node.depth.edgelength(phy3$tree)
times <- times - max(times)
phy.times <-  times[nodeid(phy3$tree, phy3$tree$tip.label)]

tip.ord <- order(-phy.times)
rownames(correlates) <- phy3$tree$tip.label[tip.ord] 

plot_structured_tree(phy3$tree, phy3$params$n_exp+1)


#read time scaled phylogeny
MyTree<-read.nexus("./154_2371_treeBactDating1e7.nex")
MyTree

#cladeA = c("NMI9039", "NMI9217")
#nout_154tree<- drop.tip(MyTree, cladeA)
#nout_154tree

#ggtree(nout_154tree, mrsd="2019-12-15")+ theme_tree2()





## ----run inference, message=FALSE---------------------------------------------
n_it <- 1e7
thinning <- n_it/1e4
phy_inf <- collapse.singles(MyTree)
start <- Sys.time()
expansions <- run_expansion_inference(phy_inf, priors, concentration=1, n_it=n_it, thinning=thinning) 
end <- Sys.time()
total_time <- as.numeric (end - start, units = "mins")
print(paste("Total time elapsed: ",total_time))


## ----print expansions---------------------------------------------------------
print(expansions)
head(expansions$model_data)
head(expansions$expansion_data)

## ----discard burn in----------------------------------------------------------
expansions <- discard_burn_in(expansions, proportion=0.4)
print(expansions)
head(expansions$model_data)
head(expansions$expansion_data)


## ----plot traces, out.width="90%", fig.width=10, fig.height=10, dpi=300, fig.align="center", message=FALSE, eval=T----

svg(file="./154_1e7_trace.svg")
plot(expansions,mode="traces")
dev.off()

## ----plot summary, out.width="90%", fig.width=20, fig.height=20, dpi=300, fig.align="center", message=FALSE,eval=T----

svg(file="./154_1e7_summmary.svg")
plot(expansions,mode="summary", k_modes=5)
dev.off()
## ----plot correlates, out.width="90%", fig.width=23.75, fig.height=20, dpi=300, fig.align="center", message=FALSE,eval=T----
#plot(expansions, mode="persistence", correlates=list(correlates))


## ----plot modes, out.width="90%", fig.width=30, fig.height=15, dpi=300, fig.align="center", message=FALSE,eval=T----
svg(file="./154_1e7_summary.scg")
plot(expansions, mode="modes", k_modes=5)
dev.off
## ----plot population dynamics, out.width="90%", fig.width=30, fig.height=15, dpi=300, fig.align="center", message=FALSE,eval=T----
svg(file="./154_1e7_population.svg")
plot(expansions, mode="popfunc", k_modes=5)
dev.off()







