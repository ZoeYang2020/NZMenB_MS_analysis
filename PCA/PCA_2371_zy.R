#############################################################################################
################PCA_jinweitao_2019_4_25######################################################
#############################################################################################



#install.packages("FactoMineR")
#install.packages("factoextra")
library(FactoMineR)
library(factoextra)
library(ggplot2)
#读取数据

setwd("/home/zyang/NGS/active/IPL/MENINGO/analysis/HRC/zoe/AllNZMemB_2021/PCA/2371_biallele_PCA")
pinus <- read.csv("2371SNPs_3clade_PCA.csv",header=FALSE)

#列出数据前几行
head(pinus)

#pca分析（针对SNPS数据）
res.pca <- PCA(pinus[, 3:143804], graph = FALSE)
print(res.pca)


#plot individual
PCA_plot <-fviz_pca_ind(res.pca,
             geom.ind = "point", # show points only (nbut not "text")
             col.ind = pinus$V2, # color by groups
             palette = c("#a1c9f1", "#efb0c9", "#ade6d0"),
             addEllipses = TRUE, # Concentration ellipses
             legend.title = "Clade")
PCA_plot
ggsave("2371PCA.png", PCA_plot, width=6, height=4, dpi=600)


#做碎图ll
scree.plot<-fviz_eig(res.pca, addlabels = TRUE)
scree.plot

ggsave("2371PCA_Dimensions.png", scree.plot, width=6, height=4, dpi=600)






