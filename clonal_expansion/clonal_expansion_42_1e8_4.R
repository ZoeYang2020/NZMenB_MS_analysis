#devtools::install_github('dhelekal/CaveDive')
#library(CaveDive)
#CaveDive::build_coal_tree()

setwd("/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/clonal_expansion")
getwd()



## ---- echo = FALSE, message = FALSE-------------------------------------------
#some errors here, so the scipte stoped
#knitr::opts_chunk$set(collapse = T, comment = "#>")
#tandard_priorsstandard_priorsptions(tibble.print_min = 4, tibble.print_max = 4)


## ----setup, message=FALSE
library(ape)
library(CaveDive)
library(treeio)
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
MyTree<-read.nexus("./42_2371_treeBactDating1e7.nex")
MyTree

#cladeA = c("NMI9039", "NMI9217")
#nout_154tree<- drop.tip(MyTree, cladeA)
#nout_154tree

#ggtree(nout_154tree, mrsd="2019-12-15")+ theme_tree2()





## ----run inference, message=FALSE---------------------------------------------
n_it <- 1e8
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

write.csv(expansions$model_data, file="./42_1e8_4_expansion_model_data.csv")
write.csv(expansions$expansion_data, file="./42_1e8_4_expansion_expansion_data.csv")


## ----plot traces, out.width="90%", fig.width=10, fig.height=10, dpi=300, fig.align="center", message=FALSE, eval=T----

svg(file="./42_1e8_4_trace.svg")
plot(expansions,mode="traces")
dev.off()

## ----plot summary, out.width="90%", fig.width=20, fig.height=20, dpi=300, fig.align="center", message=FALSE,eval=T----

svg(file="./42_1e8_4_summary_k1.svg")
plot(expansions,mode="summary", k_modes=1)
dev.off()


svg(file="./42_1e8_4_summary_k2.svg")
plot(expansions,mode="summary", k_modes=2)
dev.off()

svg(file="./42_1e8_4_summary_k3.svg")
plot(expansions,mode="summary", k_modes=3)
dev.off()

svg(file="./42_1e8_4_summary_k4.svg")
plot(expansions,mode="summary", k_modes=4)
dev.off()


svg(file="./42_1e8_4_summary_k5.svg")
plot(expansions,mode="summary", k_modes=5)
dev.off()

svg(file="./42_1e8_4_summary_k6.svg")
plot(expansions,mode="summary", k_modes=6)
dev.off()

svg(file="./42_1e8_4_summary_k7.svg")
plot(expansions,mode="summary", k_modes=7)
dev.off()

## ----plot correlates, out.width="90%", fig.width=23.75, fig.height=20, dpi=300, fig.align="center", message=FALSE,eval=T----
#plot(expansions, mode="persistence", correlates=list(correlates))


## ----plot modes, out.width="90%", fig.width=30, fig.height=15, dpi=300, fig.align="center", message=FALSE,eval=T----
svg(file="./42_1e8_4_summary_node_k1.svg")
plot(expansions, mode="modes", k_modes=1)
dev.off

svg(file="./42_1e8_4_summary_node_k2.svg")
plot(expansions, mode="modes", k_modes=2)
dev.off

svg(file="./42_1e8_4_summary_node_k3.svg")
plot(expansions, mode="modes", k_modes=3)
dev.off

svg(file="./42_1e8_4_summary_node_k4.svg")
plot(expansions, mode="modes", k_modes=4)
dev.off

svg(file="./42_1e8_4_summary_node_k5.svg")
plot(expansions, mode="modes", k_modes=5)
dev.off


svg(file="./42_1e8_4_summary_node_k6.svg")
plot(expansions, mode="modes", k_modes=6)
dev.off

svg(file="./42_1e8_4_summary_node_k7.svg")
plot(expansions, mode="modes", k_modes=7)
dev.off



## ----plot population dynamics, out.width="90%", fig.width=30, fig.height=15, dpi=300, fig.align="center", message=FALSE,eval=T----
svg(file="./42_1e8_4_population_k1.svg")
plot(expansions, mode="popfunc", k_modes=1)
dev.off()

svg(file="./42_1e8_4_population_k2.svg")
plot(expansions, mode="popfunc", k_modes=2)
dev.off()

svg(file="./42_1e8_4_population_k4.svg")
plot(expansions, mode="popfunc", k_modes=4)
dev.off()

svg(file="./42_1e8_4_population_k5.svg")
plot(expansions, mode="popfunc", k_modes=5)
dev.off()

svg(file="./42_1e8_4_population_k6.svg")
plot(expansions, mode="popfunc", k_modes=6)
dev.off()

svg(file="./42_1e8_4_population_k7.svg")
plot(expansions, mode="popfunc", k_modes=7)
dev.off()
