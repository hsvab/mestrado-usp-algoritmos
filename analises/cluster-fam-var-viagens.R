# Preparando os dados
library(dplyr)
library(Hmisc)
library(fastcluster)
library(ggplot2)
library(ggdendro)
library(fpc)

od_cluster <- od %>% filter(F_FAM==1) %>% select(FAM_DIST_TOT, FAM_DIST_MED, FAM_DURACAO_TOT, 
                            FAM_DURACAO_MED, FAM_VIAG_TOT, ID_FAM)

od_cluster <- na.omit(od_cluster)
od_cluster$FAM_DIST_TOT <- scale(od_cluster$FAM_DIST_TOT)
od_cluster$FAM_DIST_MED <- scale(od_cluster$FAM_DIST_MED)
od_cluster$FAM_DURACAO_TOT <- scale(od_cluster$FAM_DURACAO_TOT)
od_cluster$FAM_DURCAO_MED <- scale(od_cluster$FAM_DURACAO_MED)
od_cluster$FAM_VIAG_TOT <- scale(od_cluster$FAM_VIAG_TOT)

# 
fam_hcluster <- hclust.vector(od_cluster, method="ward", metric="euclidean", p=NULL)
plot(fam_hcluster, xlab='', sub='', labels = FALSE)
# ggdendrogram(fam_hcluster, rotate = TRUE, size = 4, theme_dendro = FALSE, color = 'tomato')

fam_kmcluster2 <- kmeans(od_cluster, 2)
od_cluster$famcluster2 <- fam_kmcluster2$cluster
fam_kmcluster4 <- kmeans(od_cluster, 4)
od_cluster$famcluster4 <- fam_kmcluster4$cluster
fam_kmcluster9 <- kmeans(od_cluster, 9)
od_cluster$famcluster9 <- fam_kmcluster9$cluster

plotcluster(od_cluster, fam_kmcluster$cluster)

left_join()

