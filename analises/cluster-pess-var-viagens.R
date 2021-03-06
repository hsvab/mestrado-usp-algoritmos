library(Hmisc, quietly = TRUE)
library(fastcluster, quietly = TRUE)
library(ggplot2, quietly = TRUE)
library(ggdendro, quietly = TRUE)
library(fpc, quietly = TRUE)
library(dplyr, quietly = TRUE)

#############################################
######### CLUSTER PESSOA COM WARD ###########
#############################################

# somente para homens
# od_cluster_pess <- od %>% filter(F_PESS==1, SEXO==0) %>% select(PESS_DIST_TOT, PESS_DIST_MED,

# somente para mulheres
# od_cluster_pess <- od %>% filter(F_PESS==1, SEXO==1) %>% select(PESS_DIST_TOT, PESS_DIST_MED,

# Selecionando as variáveis com atributos de viagem, da pessoa
od_cluster_pess <- od %>% filter(F_PESS==1) %>% select(PESS_DIST_TOT, PESS_DIST_MED,
                                                       PESS_DURACAO_TOT, PESS_DURACAO_MED,
                                                       PESS_MODO_ONIBUS, PESS_MODO_DIRIG,
                                                       PESS_MODO_PASS, PESS_MODO_TREM,
                                                       PESS_MODO_MOTO, PESS_MODO_BICI,
                                                       PESS_MODO_APE, PESS_MODO_OUTROS,
                                                       PESS_NO_MODOS, PESS_MOTIVO_TRAB,
                                                       PESS_MOTIVO_EDUC, PESS_MOTIVO_RES,
                                                       PESS_MOTIVO_SERV_PAS, PESS_MOTIVO_MANUT_COMPRAS,
                                                       PESS_MOTIVO_LAZER_OUTROS, PESS_NO_MOTIVOS,
                                                       PESS_PER_MADRUG, PESS_PER_COM_MAN,
                                                       PESS_PER_MANHA, PESS_PER_MEIODIA,
                                                       PESS_PER_TARDE, PESS_PER_COM_NOI,
                                                       PESS_PER_NOITE, PESS_NO_PERIODOS,
                                                       TOT_VIAG, ID_PESS)

# Só para grantir que não haverá 'NA' da análise (devem ser 0 ocorrências)
od_cluster_pess <- na.omit(od_cluster_pess)

# Padronizando os dados [Z-score]
# zi = ((xi - média(x))/desvio padrão(x)
od_cluster_pess$PESS_DIST_TOT <- scale(od_cluster_pess$PESS_DIST_TOT)
od_cluster_pess$PESS_DIST_MED <- scale(od_cluster_pess$PESS_DIST_MED)
od_cluster_pess$PESS_DURACAO_TOT <- scale(od_cluster_pess$PESS_DURACAO_TOT)
od_cluster_pess$PESS_DURCAO_MED <- scale(od_cluster_pess$PESS_DURACAO_MED)
od_cluster_pess$TOT_VIAG <- scale(od_cluster_pess$TOT_VIAG)

od_cluster_pess$PESS_MODO_ONIBUS <- scale(od_cluster_pess$PESS_MODO_ONIBUS)
od_cluster_pess$PESS_MODO_DIRIG <- scale(od_cluster_pess$PESS_MODO_DIRIG)
od_cluster_pess$PESS_MODO_PASS <- scale(od_cluster_pess$PESS_MODO_PASS)
od_cluster_pess$PESS_MODO_TREM <- scale(od_cluster_pess$PESS_MODO_TREM)
od_cluster_pess$PESS_MODO_MOTO <- scale(od_cluster_pess$PESS_MODO_MOTO)
od_cluster_pess$PESS_MODO_BICI <- scale(od_cluster_pess$PESS_MODO_BICI)
od_cluster_pess$PESS_MODO_APE <- scale(od_cluster_pess$PESS_MODO_APE)
od_cluster_pess$PESS_MODO_OUTROS <- scale(od_cluster_pess$PESS_MODO_OUTROS)
od_cluster_pess$PESS_NO_MODOS <- scale(od_cluster_pess$PESS_NO_MODOS)

od_cluster_pess$PESS_MOTIVO_TRAB <- scale(od_cluster_pess$PESS_MOTIVO_TRAB)
od_cluster_pess$PESS_MOTIVO_EDUC <- scale(od_cluster_pess$PESS_MOTIVO_EDUC)
od_cluster_pess$PESS_MOTIVO_RES <- scale(od_cluster_pess$PESS_MOTIVO_RES)
od_cluster_pess$PESS_MOTIVO_SERV_PAS <- scale(od_cluster_pess$PESS_MOTIVO_SERV_PAS)
od_cluster_pess$PESS_MOTIVO_MANUT_COMPRAS<- scale(od_cluster_pess$PESS_MOTIVO_MANUT_COMPRAS)
od_cluster_pess$PESS_MOTIVO_LAZER_OUTROS <- scale(od_cluster_pess$PESS_MOTIVO_LAZER_OUTROS)
od_cluster_pess$PESS_NO_MOTIVOS <- scale(od_cluster_pess$PESS_NO_MOTIVOS)

od_cluster_pess$PESS_PER_MADRUG <- scale(od_cluster_pess$PESS_PER_MADRUG)
od_cluster_pess$PESS_PER_COM_MAN <- scale(od_cluster_pess$PESS_PER_COM_MAN)
od_cluster_pess$PESS_PER_MANHA <- scale(od_cluster_pess$PESS_PER_MAN)
od_cluster_pess$PESS_PER_MEIODIA <- scale(od_cluster_pess$PESS_PER_MEIODIA)
od_cluster_pess$PESS_PER_TARDE <- scale(od_cluster_pess$PESS_PER_TARDE)
od_cluster_pess$PESS_PER_COM_NOI <- scale(od_cluster_pess$PESS_PER_COM_NOI)
od_cluster_pess$PESS_PER_NOITE <- scale(od_cluster_pess$PESS_PER_NOITE)
od_cluster_pess$PESS_NO_PERIODOS <- scale(od_cluster_pess$PESS_NO_PERIODOS)

# Utilizando a análise hierárquica de conglomerados utilizando o pacote fastcluster
tempo <- system.time(pess_hcluster_ward <- hclust.vector(od_cluster_pess, method="ward", metric="euclidean", p=NULL))
print("Tempo do hclust.vector pess_ward_tudo:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(pess_hcluster_ward, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da pessoa - método ward')
dev.copy(png, file="dendro-hierarq-cluster-pessoa-total-ward.png")
dev.off()

grafico_seleciona_cluster(df=od_cluster_pess,
                          TITULO="Avaliação de clusters para mulheres",
                          NOME_ARQUIVO = "No-clusters-R2-RMSSTD-mulheres")

# Gerando variáveis que aramazenarão qual é o cluster da observação
pess_kmcluster2 <- kmeans(od_cluster_pess, 2)
od_cluster_pess$pesscluster2_ward <- pess_kmcluster2$cluster

pess_kmcluster3 <- kmeans(od_cluster_pess, 3)
od_cluster_pess$pesscluster3_ward <- pess_kmcluster3$cluster

# somente para homens
# pess_H_kmcluster3 <- kmeans(od_cluster_pess, 3)
# od_cluster_pess$pesscluster3_ward_H <- pess_H_kmcluster3$cluster

# somente para mulheres
# pess_M_kmcluster3 <- kmeans(od_cluster_pess, 3)
# od_cluster_pess$pesscluster3_ward_M <- pess_M_kmcluster3$cluster

pess_kmcluster4 <- kmeans(od_cluster_pess, 4)
od_cluster_pess$pesscluster4_ward <- pess_kmcluster4$cluster

# somente para homens
# pess_H_kmcluster4 <- kmeans(od_cluster_pess, 4)
# od_cluster_pess$pesscluster4_ward_H <- pess_H_kmcluster4$cluster

# somente para mulheres
# pess_M_kmcluster4 <- kmeans(od_cluster_pess, 4)
# od_cluster_pess$pesscluster4_ward_M <- pess_M_kmcluster4$cluster

pess_kmcluster5 <- kmeans(od_cluster_pess, 5)
od_cluster_pess$pesscluster4_ward <- pess_kmcluster4$cluster

pess_kmcluster6 <- kmeans(od_cluster_pess, 6)
od_cluster_pess$pesscluster4_ward <- pess_kmcluster4$cluster

# Incorporando as variáveis indicativas de cluster no BDU (para homens)
# od <- left_join(od, select(od_cluster_pess, ID_PESS, pesscluster3_ward_H, pesscluster4_ward_H), by='ID_PESS')

# Incorporando as variáveis indicativas de cluster no BDU (para mulheres)
# od <- left_join(od, select(od_cluster_pess, ID_PESS, pesscluster3_ward_M, pesscluster4_ward_M), by='ID_PESS')

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_pess, ID_PESS, pesscluster2_ward,
                           pesscluster3_ward, pesscluster4_ward,
                           pesscluster5_ward, pesscluster6_ward), by='ID_PESS')

rm(od_cluster_pess)

##################################################
######### CLUSTER PESSOA COM CENTROIDE ###########
##################################################

# somente para homens
# od_cluster_pess <- od %>% filter(F_PESS==1, SEXO==0) %>% select(PESS_DIST_TOT, PESS_DIST_MED,

# somente para mulheres
# od_cluster_pess <- od %>% filter(F_PESS==1, SEXO==1) %>% select(PESS_DIST_TOT, PESS_DIST_MED,

# Selecionando as variáveis com atributos de viagem, da pessoa
od_cluster_pess <- od %>% filter(F_PESS==1) %>% select(PESS_DIST_TOT, PESS_DIST_MED,
                                                       PESS_DURACAO_TOT, PESS_DURACAO_MED,
                                                       PESS_MODO_ONIBUS, PESS_MODO_DIRIG,
                                                       PESS_MODO_PASS, PESS_MODO_TREM,
                                                       PESS_MODO_MOTO, PESS_MODO_BICI,
                                                       PESS_MODO_APE, PESS_MODO_OUTROS,
                                                       PESS_NO_MODOS, PESS_MOTIVO_TRAB,
                                                       PESS_MOTIVO_EDUC, PESS_MOTIVO_RES,
                                                       PESS_MOTIVO_SERV_PAS, PESS_MOTIVO_MANUT_COMPRAS,
                                                       PESS_MOTIVO_LAZER_OUTROS, PESS_NO_MOTIVOS,
                                                       PESS_PER_MADRUG, PESS_PER_COM_MAN,
                                                       PESS_PER_MANHA, PESS_PER_MEIODIA,
                                                       PESS_PER_TARDE, PESS_PER_COM_NOI,
                                                       PESS_PER_NOITE, PESS_NO_PERIODOS,
                                                       TOT_VIAG, ID_PESS)

# Só para grantir que não haverá 'NA' da análise (devem ser 0 ocorrências)
od_cluster_pess <- na.omit(od_cluster_pess)

# Padronizando os dados [Z-score]
# zi = ((xi - média(x))/desvio padrão(x)
od_cluster_pess$PESS_DIST_TOT <- scale(od_cluster_pess$PESS_DIST_TOT)
od_cluster_pess$PESS_DIST_MED <- scale(od_cluster_pess$PESS_DIST_MED)
od_cluster_pess$PESS_DURACAO_TOT <- scale(od_cluster_pess$PESS_DURACAO_TOT)
od_cluster_pess$PESS_DURCAO_MED <- scale(od_cluster_pess$PESS_DURACAO_MED)
od_cluster_pess$TOT_VIAG <- scale(od_cluster_pess$TOT_VIAG)

od_cluster_pess$PESS_MODO_ONIBUS <- scale(od_cluster_pess$PESS_MODO_ONIBUS)
od_cluster_pess$PESS_MODO_DIRIG <- scale(od_cluster_pess$PESS_MODO_DIRIG)
od_cluster_pess$PESS_MODO_PASS <- scale(od_cluster_pess$PESS_MODO_PASS)
od_cluster_pess$PESS_MODO_TREM <- scale(od_cluster_pess$PESS_MODO_TREM)
od_cluster_pess$PESS_MODO_MOTO <- scale(od_cluster_pess$PESS_MODO_MOTO)
od_cluster_pess$PESS_MODO_BICI <- scale(od_cluster_pess$PESS_MODO_BICI)
od_cluster_pess$PESS_MODO_APE <- scale(od_cluster_pess$PESS_MODO_APE)
od_cluster_pess$PESS_MODO_OUTROS <- scale(od_cluster_pess$PESS_MODO_OUTROS)
od_cluster_pess$PESS_NO_MODOS <- scale(od_cluster_pess$PESS_NO_MODOS)

od_cluster_pess$PESS_MOTIVO_TRAB <- scale(od_cluster_pess$PESS_MOTIVO_TRAB)
od_cluster_pess$PESS_MOTIVO_EDUC <- scale(od_cluster_pess$PESS_MOTIVO_EDUC)
od_cluster_pess$PESS_MOTIVO_RES <- scale(od_cluster_pess$PESS_MOTIVO_RES)
od_cluster_pess$PESS_MOTIVO_SERV_PAS <- scale(od_cluster_pess$PESS_MOTIVO_SERV_PAS)
od_cluster_pess$PESS_MOTIVO_MANUT_COMPRAS<- scale(od_cluster_pess$PESS_MOTIVO_MANUT_COMPRAS)
od_cluster_pess$PESS_MOTIVO_LAZER_OUTROS <- scale(od_cluster_pess$PESS_MOTIVO_LAZER_OUTROS)
od_cluster_pess$PESS_NO_MOTIVOS <- scale(od_cluster_pess$PESS_NO_MOTIVOS)

od_cluster_pess$PESS_PER_MADRUG <- scale(od_cluster_pess$PESS_PER_MADRUG)
od_cluster_pess$PESS_PER_COM_MAN <- scale(od_cluster_pess$PESS_PER_COM_MAN)
od_cluster_pess$PESS_PER_MANHA <- scale(od_cluster_pess$PESS_PER_MAN)
od_cluster_pess$PESS_PER_MEIODIA <- scale(od_cluster_pess$PESS_PER_MEIODIA)
od_cluster_pess$PESS_PER_TARDE <- scale(od_cluster_pess$PESS_PER_TARDE)
od_cluster_pess$PESS_PER_COM_NOI <- scale(od_cluster_pess$PESS_PER_COM_NOI)
od_cluster_pess$PESS_PER_NOITE <- scale(od_cluster_pess$PESS_PER_NOITE)
od_cluster_pess$PESS_NO_PERIODOS <- scale(od_cluster_pess$PESS_NO_PERIODOS)

# Utilizando a análise hierárquica de conglomerados utilizando o pacote fastcluster
tempo <- system.time(pess_hcluster_centroide <- hclust.vector(od_cluster_pess, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector pess_cetroide_tudo:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(pess_hcluster_centroide, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da pessoa - método centroide')
dev.copy(png, file="dendro-hierarq-cluster-pessoa-total-centroide.png")
dev.off()

# Gerando variáveis que aramazenarão qual é o cluster da observação
pess_kmcluster2 <- kmeans(od_cluster_pess, 2)
od_cluster_pess$pesscluster2_centroide <- pess_kmcluster2$cluster

pess_kmcluster3 <- kmeans(od_cluster_pess, 3)
od_cluster_pess$pesscluster3_centroide <- pess_kmcluster3$cluster

# somente para homens
# pess_H_kmcluster3 <- kmeans(od_cluster_pess, 3)
# od_cluster_pess$pesscluster3_centroide_H <- pess_H_kmcluster3$cluster

# somente para mulheres
# pess_M_kmcluster3 <- kmeans(od_cluster_pess, 3)
# od_cluster_pess$pesscluster3_centroide_M <- pess_M_kmcluster3$cluster

pess_kmcluster4 <- kmeans(od_cluster_pess, 4)
od_cluster_pess$pesscluster4_centroide <- pess_kmcluster4$cluster

# somente para homens
# pess_H_kmcluster4 <- kmeans(od_cluster_pess, 4)
# od_cluster_pess$pesscluster4_centroide_H <- pess_H_kmcluster4$cluster

# somente para mulheres
# pess_M_kmcluster4 <- kmeans(od_cluster_pess, 4)
# od_cluster_pess$pesscluster4_centroide_M <- pess_M_kmcluster4$cluster

pess_kmcluster5 <- kmeans(od_cluster_pess, 5)
od_cluster_pess$pesscluster5_centroide <- pess_kmcluster5$cluster

pess_kmcluster6 <- kmeans(od_cluster_pess, 6)
od_cluster_pess$pesscluster6_centroide <- pess_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU (para homens)
# od <- left_join(od, select(od_cluster_pess, ID_PESS, pesscluster3_centroide_H, pesscluster4_centroide_H), by='ID_PESS')

# Incorporando as variáveis indicativas de cluster no BDU (para mulheres)
# od <- left_join(od, select(od_cluster_pess, ID_PESS, pesscluster3_centroide_M, pesscluster4_centroide_M), by='ID_PESS')

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_pess, ID_PESS, pesscluster2_centroide,
                           pesscluster3_centroide, pesscluster4_centroide,
                           pesscluster5_centroide, pesscluster6_centroide), by='ID_PESS')

rm(od_cluster_pess)
