# library(Hmisc, quietly = TRUE)
# library(dplyr, quietly = TRUE)
# library(fastcluster, quietly = TRUE)
# library(ggplot2, quietly = TRUE)
# library(ggdendro, quietly = TRUE)
# library(fpc, quietly = TRUE)

##############################################
######### CLUSTER FAMILIA COM WARD ###########
##############################################

# Selecionando as variáveis com atributos de viagem, da família
od_cluster_fam <- od %>% filter(F_FAM==1) %>% select(FAM_DIST_TOT, FAM_DIST_MED, FAM_DURACAO_TOT,
                                                     FAM_DURACAO_MED, FAM_VIAG_TOT, ID_FAM)

# Só para garantir que não haverá 'NA' da análise (devem ser 0 ocorrências)
od_cluster_fam <- na.omit(od_cluster_fam)

# Padronizando os dados [Z-score]
# zi = ((xi - média(x))/desvio padrão(x)
od_cluster_fam$FAM_DIST_TOT <- scale(od_cluster_fam$FAM_DIST_TOT)
od_cluster_fam$FAM_DIST_MED <- scale(od_cluster_fam$FAM_DIST_MED)
od_cluster_fam$FAM_DURACAO_TOT <- scale(od_cluster_fam$FAM_DURACAO_TOT)
od_cluster_fam$FAM_DURCAO_MED <- scale(od_cluster_fam$FAM_DURACAO_MED)
od_cluster_fam$FAM_VIAG_TOT <- scale(od_cluster_fam$FAM_VIAG_TOT)

# Utilizando a análise hierárquica de conglomerados utilizando o pacote fastcluster
tempo <- system.time(fam_hcluster_ward <- hclust.vector(od_cluster_fam, method="ward", metric="euclidean", p=NULL))
print("Tempo do hclust.vector fam_ward_tudo:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(fam_hcluster_ward, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da família\nmétodo ward')
dev.copy(png, file="dendro-hierarq-cluster-familia-total-ward.png")
dev.off()

grafico_seleciona_cluster(df=od_cluster_fam,
                          TITULO="Avaliação de clusters para familia",
                          NOME_ARQUIVO = "No-clusters-R2-RMSSTD-familia",
                          GRANDEZA=10^23)

# Gerando variáveis que aramazenarão qual é o cluster da observação
fam_kmcluster2 <- kmeans(od_cluster_fam, 2)
od_cluster_fam$famcluster2_ward <- fam_kmcluster2$cluster
fam_kmcluster3 <- kmeans(od_cluster_fam, 3)
od_cluster_fam$famcluster3_ward <- fam_kmcluster3$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4_ward <- fam_kmcluster4$cluster
fam_kmcluster5 <- kmeans(od_cluster_fam, 5)
od_cluster_fam$famcluster5_ward <- fam_kmcluster5$cluster
fam_kmcluster6 <- kmeans(od_cluster_fam, 6)
od_cluster_fam$famcluster6_ward <- fam_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster2_ward, famcluster3_ward,
                           famcluster4_ward, famcluster5_ward, famcluster6_ward), by='ID_FAM')

rm(od_cluster_fam)

###################################################
######### CLUSTER FAMILIA COM CENTROIDE ###########
###################################################

# Selecionando as variáveis com atributos de viagem, da família
od_cluster_fam <- od %>% filter(F_FAM==1) %>% select(FAM_DIST_TOT, FAM_DIST_MED, FAM_DURACAO_TOT,
                                                     FAM_DURACAO_MED, FAM_VIAG_TOT, ID_FAM)

# Só para garantir que não haverá 'NA' da análise (devem ser 0 ocorrências)
od_cluster_fam <- na.omit(od_cluster_fam)

# Padronizando os dados [Z-score]
# zi = ((xi - média(x))/desvio padrão(x)
od_cluster_fam$FAM_DIST_TOT <- scale(od_cluster_fam$FAM_DIST_TOT)
od_cluster_fam$FAM_DIST_MED <- scale(od_cluster_fam$FAM_DIST_MED)
od_cluster_fam$FAM_DURACAO_TOT <- scale(od_cluster_fam$FAM_DURACAO_TOT)
od_cluster_fam$FAM_DURCAO_MED <- scale(od_cluster_fam$FAM_DURACAO_MED)
od_cluster_fam$FAM_VIAG_TOT <- scale(od_cluster_fam$FAM_VIAG_TOT)

# Utilizando a análise hierárquica de conglomerados utilizando o pacote fastcluster
tempo <- system.time(fam_hcluster_centroide <- hclust.vector(od_cluster_fam, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector fam_centroide_tudo:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(fam_hcluster_centroide, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da família\n método centroide')
dev.copy(png, file="dendro-hierarq-cluster-familia-total-centroide.png")
dev.off()

# Gerando variáveis que aramazenarão qual é o cluster da observação
fam_kmcluster2 <- kmeans(od_cluster_fam, 2)
od_cluster_fam$famcluster2_centroide <- fam_kmcluster2$cluster
fam_kmcluster3 <- kmeans(od_cluster_fam, 3)
od_cluster_fam$famcluster3_centroide <- fam_kmcluster3$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4_centroide <- fam_kmcluster4$cluster
fam_kmcluster5 <- kmeans(od_cluster_fam, 5)
od_cluster_fam$famcluster5_centroide <- fam_kmcluster5$cluster
fam_kmcluster6 <- kmeans(od_cluster_fam, 6)
od_cluster_fam$famcluster6_centroide <- fam_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster2_centroide,
                           famcluster3_centroide, famcluster4_centroide,
                           famcluster5_centroide, famcluster6_centroide), by='ID_FAM')

rm(od_cluster_fam, tempo)
