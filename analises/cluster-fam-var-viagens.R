# Preparando os dados
library(Hmisc, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(fastcluster, quietly = TRUE)
library(ggplot2, quietly = TRUE)
library(ggdendro, quietly = TRUE)
library(fpc, quietly = TRUE)

od_cluster_fam <- od %>% filter(F_FAM==1) %>% select(FAM_DIST_TOT, FAM_DIST_MED, FAM_DURACAO_TOT,
                                                     FAM_DURACAO_MED, FAM_VIAG_TOT, ID_FAM)

od_cluster_fam <- na.omit(od_cluster_fam)
od_cluster_fam$FAM_DIST_TOT <- scale(od_cluster_fam$FAM_DIST_TOT)
od_cluster_fam$FAM_DIST_MED <- scale(od_cluster_fam$FAM_DIST_MED)
od_cluster_fam$FAM_DURACAO_TOT <- scale(od_cluster_fam$FAM_DURACAO_TOT)
od_cluster_fam$FAM_DURCAO_MED <- scale(od_cluster_fam$FAM_DURACAO_MED)
od_cluster_fam$FAM_VIAG_TOT <- scale(od_cluster_fam$FAM_VIAG_TOT)

fam_hcluster <- hclust.vector(od_cluster_fam, method="ward", metric="euclidean", p=NULL)
plot(fam_hcluster, xlab='', sub='', labels = FALSE)
# ggdendrogram(fam_hcluster, rotate = TRUE, size = 4, theme_dendro = FALSE, color = 'tomato')

fam_kmcluster2 <- kmeans(od_cluster_fam, 2)
od_cluster_fam$famcluster2 <- fam_kmcluster2$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4 <- fam_kmcluster4$cluster
fam_kmcluster9 <- kmeans(od_cluster_fam, 9)
od_cluster_fam$famcluster9 <- fam_kmcluster9$cluster
# plotcluster(od_cluster_fam, fam_kmcluster$cluster)

od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster2, famcluster4, famcluster9), by='ID_FAM')
