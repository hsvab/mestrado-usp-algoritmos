library(Hmisc, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(fastcluster, quietly = TRUE)
library(ggplot2, quietly = TRUE)
library(ggdendro, quietly = TRUE)
library(fpc, quietly = TRUE)

# Selecionando as variáveis com atributos de viagem, da família
od_cluster_fam <- od %>% filter(ANO==1, F_FAM==1) %>% select(FAM_DIST_TOT, FAM_DIST_MED, FAM_DURACAO_TOT,
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
tempo <- system.time(fam_hcluster <- hclust.vector(od_cluster_fam, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 77:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(fam_hcluster, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da família para 1977')
dev.copy(png, file="dendro-hierarq-cluster-familia-1977.png")
dev.off()
# ggdendrogram(fam_hcluster, rotate = TRUE, size = 4, theme_dendro = FALSE, color = 'tomato')

# Gerando variáveis que aramazenarão qual é o cluster da observação
fam_kmcluster3 <- kmeans(od_cluster_fam, 3)
od_cluster_fam$famcluster3_ano77 <- fam_kmcluster3$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4_ano77 <- fam_kmcluster4$cluster
# plotcluster(od_cluster_fam, fam_kmcluster$cluster)

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster3_ano77, famcluster4_ano77), by='ID_FAM')




rm(od_cluster_fam)

# Selecionando as variáveis com atributos de viagem, da família
od_cluster_fam <- od %>% filter(ANO==2, F_FAM==1) %>% select(FAM_DIST_TOT, FAM_DIST_MED, FAM_DURACAO_TOT,
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
tempo <- system.time(fam_hcluster <- hclust.vector(od_cluster_fam, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 87:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(fam_hcluster, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da família para 1987')
dev.copy(png, file="dendro-hierarq-cluster-familia-1987.png")
dev.off()
# ggdendrogram(fam_hcluster, rotate = TRUE, size = 4, theme_dendro = FALSE, color = 'tomato')

# Gerando variáveis que aramazenarão qual é o cluster da observação
fam_kmcluster3 <- kmeans(od_cluster_fam, 3)
od_cluster_fam$famcluster3_ano87 <- fam_kmcluster3$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4_ano87 <- fam_kmcluster4$cluster
# plotcluster(od_cluster_fam, fam_kmcluster$cluster)

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster3_ano87, famcluster4_ano87), by='ID_FAM')



rm(od_cluster_fam)

# Selecionando as variáveis com atributos de viagem, da família
od_cluster_fam <- od %>% filter(ANO==3, F_FAM==1) %>% select(FAM_DIST_TOT, FAM_DIST_MED, FAM_DURACAO_TOT,
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
tempo <- system.time(fam_hcluster <- hclust.vector(od_cluster_fam, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 97:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(fam_hcluster, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da família para 1997')
dev.copy(png, file="dendro-hierarq-cluster-familia-1997.png")
dev.off()
# ggdendrogram(fam_hcluster, rotate = TRUE, size = 4, theme_dendro = FALSE, color = 'tomato')

# Gerando variáveis que aramazenarão qual é o cluster da observação
fam_kmcluster3 <- kmeans(od_cluster_fam, 3)
od_cluster_fam$famcluster3_ano97 <- fam_kmcluster3$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4_ano97 <- fam_kmcluster4$cluster
# plotcluster(od_cluster_fam, fam_kmcluster$cluster)

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster3_ano97, famcluster4_ano97), by='ID_FAM')





rm(od_cluster_fam)

# Selecionando as variáveis com atributos de viagem, da família
od_cluster_fam <- od %>% filter(ANO==4, F_FAM==1) %>% select(FAM_DIST_TOT, FAM_DIST_MED, FAM_DURACAO_TOT,
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
tempo <- system.time(fam_hcluster <- hclust.vector(od_cluster_fam, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 2007:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(fam_hcluster, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da família para 2007')
dev.copy(png, file="dendro-hierarq-cluster-familia-2007.png")
dev.off()
# ggdendrogram(fam_hcluster, rotate = TRUE, size = 4, theme_dendro = FALSE, color = 'tomato')

# Gerando variáveis que aramazenarão qual é o cluster da observação
fam_kmcluster3 <- kmeans(od_cluster_fam, 3)
od_cluster_fam$famcluster3_ano07 <- fam_kmcluster3$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4_ano07 <- fam_kmcluster4$cluster
# plotcluster(od_cluster_fam, fam_kmcluster$cluster)

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster3_ano07, famcluster4_ano07), by='ID_FAM')

rm(od_cluster_fam)


