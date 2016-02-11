library(Hmisc, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(fastcluster, quietly = TRUE)
library(ggplot2, quietly = TRUE)
library(ggdendro, quietly = TRUE)
library(fpc, quietly = TRUE)

################################################################
######### CLUSTER FAMILIA em 1977 - método centroide ###########
################################################################

# Selecionando as variáveis com atributos de viagem, da família
od_cluster_fam <- od %>% filter(ANO==1, F_FAM==1) %>% select(FAM_DIST_TOT, FAM_DIST_MED,
                                                             FAM_DURACAO_TOT, FAM_DURACAO_MED,
                                                             FAM_VIAG_TOT, ID_FAM)

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
tempo <- system.time(fam_hcluster_77 <- hclust.vector(od_cluster_fam, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 77:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(fam_hcluster_77, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da família para 1977')
dev.copy(png, file="dendro-hierarq-cluster-familia-1977.png")
dev.off()

grafico_seleciona_cluster(df=od_cluster_fam,
                          TITULO="Avaliação de clusters para familia em 1977",
                          NOME_ARQUIVO = "No-clusters-R2-RMSSTD-familia-1977",
                          GRANDEZA=10^20)

# Gerando variáveis que aramazenarão qual é o cluster da observação
fam_kmcluster2 <- kmeans(od_cluster_fam, 2)
od_cluster_fam$famcluster2_ano77 <- fam_kmcluster2$cluster
fam_kmcluster3 <- kmeans(od_cluster_fam, 3)
od_cluster_fam$famcluster3_ano77 <- fam_kmcluster3$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4_ano77 <- fam_kmcluster4$cluster
fam_kmcluster5 <- kmeans(od_cluster_fam, 5)
od_cluster_fam$famcluster5_ano77 <- fam_kmcluster5$cluster
fam_kmcluster6 <- kmeans(od_cluster_fam, 6)
od_cluster_fam$famcluster6_ano77 <- fam_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster2_ano77, famcluster3_ano77,
                           famcluster4_ano77, famcluster5_ano77, famcluster6_ano77), by='ID_FAM')

rm(od_cluster_fam)

################################################################
######### CLUSTER FAMILIA em 1987 - método centroide ###########
################################################################

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
tempo <- system.time(fam_hcluster_87 <- hclust.vector(od_cluster_fam, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 87:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(fam_hcluster_87, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da família para 1987')
dev.copy(png, file="dendro-hierarq-cluster-familia-1987.png")
dev.off()

grafico_seleciona_cluster(df=od_cluster_fam,
                          TITULO="Avaliação de clusters para familia em 1987",
                          NOME_ARQUIVO = "No-clusters-R2-RMSSTD-familia-1987",
                          GRANDEZA=10^19)

# Gerando variáveis que aramazenarão qual é o cluster da observação
fam_kmcluster2 <- kmeans(od_cluster_fam, 2)
od_cluster_fam$famcluster2_ano87 <- fam_kmcluster2$cluster
fam_kmcluster3 <- kmeans(od_cluster_fam, 3)
od_cluster_fam$famcluster3_ano87 <- fam_kmcluster3$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4_ano87 <- fam_kmcluster4$cluster
fam_kmcluster5 <- kmeans(od_cluster_fam, 5)
od_cluster_fam$famcluster5_ano87 <- fam_kmcluster5$cluster
fam_kmcluster6 <- kmeans(od_cluster_fam, 6)
od_cluster_fam$famcluster6_ano87 <- fam_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster2_ano87, famcluster3_ano87,
                           famcluster4_ano87, famcluster5_ano87, famcluster6_ano87), by='ID_FAM')

rm(od_cluster_fam)

################################################################
######### CLUSTER FAMILIA em 1997 - método centroide ###########
################################################################

# Selecionando as variáveis com atributos de viagem, da família
od_cluster_fam <- od %>% filter(ANO==3, F_FAM==1) %>% select(FAM_DIST_TOT, FAM_DIST_MED,
                                                             FAM_DURACAO_TOT, FAM_DURACAO_MED,
                                                             FAM_VIAG_TOT, ID_FAM)

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
tempo <- system.time(fam_hcluster_97 <- hclust.vector(od_cluster_fam, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 97:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(fam_hcluster_97, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da família para 1997')
dev.copy(png, file="dendro-hierarq-cluster-familia-1997.png")
dev.off()

grafico_seleciona_cluster(df=od_cluster_fam,
                          TITULO="Avaliação de clusters para familia em 1997",
                          NOME_ARQUIVO = "No-clusters-R2-RMSSTD-familia-1997",
                          GRANDEZA=10^20)

# Gerando variáveis que aramazenarão qual é o cluster da observação
fam_kmcluster2 <- kmeans(od_cluster_fam, 2)
od_cluster_fam$famcluster2_ano97 <- fam_kmcluster2$cluster
fam_kmcluster3 <- kmeans(od_cluster_fam, 3)
od_cluster_fam$famcluster3_ano97 <- fam_kmcluster3$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4_ano97 <- fam_kmcluster4$cluster
fam_kmcluster5 <- kmeans(od_cluster_fam, 5)
od_cluster_fam$famcluster5_ano97 <- fam_kmcluster5$cluster
fam_kmcluster6 <- kmeans(od_cluster_fam, 6)
od_cluster_fam$famcluster6_ano97 <- fam_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster2_ano97, famcluster3_ano97,
                           famcluster4_ano97, famcluster5_ano97, famcluster6_ano97), by='ID_FAM')

rm(od_cluster_fam)

################################################################
######### CLUSTER FAMILIA em 2007 - método centroide ###########
################################################################

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
tempo <- system.time(fam_hcluster_07 <- hclust.vector(od_cluster_fam, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 2007:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(fam_hcluster_07, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da família para 2007')
dev.copy(png, file="dendro-hierarq-cluster-familia-2007.png")
dev.off()

grafico_seleciona_cluster(df=od_cluster_fam,
                          TITULO="Avaliação de clusters para familia em 2007",
                          NOME_ARQUIVO = "No-clusters-R2-RMSSTD-familia-2007",
                          GRANDEZA=10^20)

# Gerando variáveis que aramazenarão qual é o cluster da observação
fam_kmcluster2 <- kmeans(od_cluster_fam, 2)
od_cluster_fam$famcluster2_ano07 <- fam_kmcluster2$cluster
fam_kmcluster3 <- kmeans(od_cluster_fam, 3)
od_cluster_fam$famcluster3_ano07 <- fam_kmcluster3$cluster
fam_kmcluster4 <- kmeans(od_cluster_fam, 4)
od_cluster_fam$famcluster4_ano07 <- fam_kmcluster4$cluster
fam_kmcluster5 <- kmeans(od_cluster_fam, 5)
od_cluster_fam$famcluster5_ano07 <- fam_kmcluster5$cluster
fam_kmcluster6 <- kmeans(od_cluster_fam, 6)
od_cluster_fam$famcluster6_ano07 <- fam_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_fam, ID_FAM, famcluster2_ano07, famcluster3_ano07,
                           famcluster4_ano07, famcluster5_ano07, famcluster6_ano07), by='ID_FAM')

rm(od_cluster_fam, tempo)
