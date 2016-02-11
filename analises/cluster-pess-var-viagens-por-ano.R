# library(Hmisc, quietly = TRUE)
# library(fastcluster, quietly = TRUE)
# library(ggplot2, quietly = TRUE)
# library(ggdendro, quietly = TRUE)
# library(fpc, quietly = TRUE)
# library(dplyr, quietly = TRUE)

###############################################################
######### CLUSTER PESSOA em 1977 - método centroide ###########
###############################################################

cat("############################################\n")
cat("Cluster em 1977\n")
# Selecionando as variáveis com atributos de viagem, da pessoa
od_cluster_pess <- od %>% filter(ANO==1, F_PESS==1) %>% select(PESS_DIST_TOT, PESS_DIST_MED,
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
registros_antes <- nrow(od_cluster_pess)
cat("Linhas totais de 77 antes do na.omit: ", registros_antes, "\n")
od_cluster_pess <- na.omit(od_cluster_pess)
registros_depois <- nrow(od_cluster_pess)
cat("Linhas totais de 77 depois do na.omit: ", registros_depois, "\n")
cat("Registros 'perdidos': ", registros_antes - registros_depois, "\n")

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
tempo <- system.time(pess_hcluster_77 <- hclust.vector(od_cluster_pess, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 77:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(pess_hcluster_77, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da pessoa\n para 1977')
dev.copy(png,file="dendro-hierarq-cluster-pessoa-1977.png" )
dev.off()

grafico_seleciona_cluster(df=od_cluster_pess,
                          TITULO="Avaliação de clusters para pessoas em 1977",
                          NOME_ARQUIVO = "No-clusters-R2-RMSSTD-pessoa-1977")

# Gerando variáveis que aramazenarão qual é o cluster da observação
pess_kmcluster2 <- kmeans(od_cluster_pess, 2)
od_cluster_pess$pesscluster2_ano77 <- pess_kmcluster2$cluster
pess_kmcluster3 <- kmeans(od_cluster_pess, 3)
od_cluster_pess$pesscluster3_ano77 <- pess_kmcluster3$cluster
pess_kmcluster4 <- kmeans(od_cluster_pess, 4)
od_cluster_pess$pesscluster4_ano77 <- pess_kmcluster4$cluster
pess_kmcluster5 <- kmeans(od_cluster_pess, 5)
od_cluster_pess$pesscluster5_ano77 <- pess_kmcluster5$cluster
pess_kmcluster6 <- kmeans(od_cluster_pess, 6)
od_cluster_pess$pesscluster6_ano77 <- pess_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_pess, ID_PESS, pesscluster2_ano77, pesscluster3_ano77,
                           pesscluster4_ano77, pesscluster5_ano77, pesscluster6_ano77), by='ID_PESS')

rm(od_cluster_pess)

###############################################################
######### CLUSTER PESSOA em 1987 - método centroide ###########
###############################################################

cat("\n\n############################################\n")
cat("Cluster em 1987\n")
# Selecionando as variáveis com atributos de viagem, da pessoa
od_cluster_pess <- od %>% filter(ANO==2, F_PESS==1) %>% select(PESS_DIST_TOT, PESS_DIST_MED,
                                                               PESS_DURACAO_TOT, PESS_DURACAO_MED,
                                                               PESS_MODO_ONIBUS, PESS_MODO_DIRIG,
                                                               PESS_MODO_PASS, PESS_MODO_TREM,
                                                               PESS_MODO_MOTO, PESS_MODO_BICI,
                                                               PESS_MODO_APE, PESS_MODO_OUTROS,
                                                               PESS_NO_MODOS, PESS_MOTIVO_TRAB,
                                                               PESS_MOTIVO_EDUC, PESS_MOTIVO_RES,
                                                               PESS_MOTIVO_SERV_PAS,
                                                               PESS_MOTIVO_MANUT_COMPRAS,
                                                               PESS_MOTIVO_LAZER_OUTROS, PESS_NO_MOTIVOS,
                                                               PESS_PER_MADRUG, PESS_PER_COM_MAN,
                                                               PESS_PER_MANHA, PESS_PER_MEIODIA,
                                                               PESS_PER_TARDE, PESS_PER_COM_NOI,
                                                               PESS_PER_NOITE, PESS_NO_PERIODOS,
                                                               TOT_VIAG, ID_PESS)

# Só para grantir que não haverá 'NA' da análise (devem ser 0 ocorrências)
registros_antes <- nrow(od_cluster_pess)
cat("Linhas totais de 87 antes do na.omit: ", registros_antes, "\n")
od_cluster_pess <- na.omit(od_cluster_pess)
registros_depois <- nrow(od_cluster_pess)
cat("Linhas totais de 87 depois do na.omit: ", registros_depois, "\n")
cat("Registros 'perdidos': ", registros_antes - registros_depois, "\n")

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
#od_cluster_pess$PESS_MOTIVO_SERV_PAS <- scale(od_cluster_pess$PESS_MOTIVO_SERV_PAS)
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
tempo <- system.time(pess_hcluster_87 <- hclust.vector(od_cluster_pess, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 87:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(pess_hcluster_87, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da pessoa para 1987')
dev.copy(png, file="dendro-hierarq-cluster-pessoa-1987.png")
dev.off()

grafico_seleciona_cluster(df=od_cluster_pess,
                          TITULO="Avaliação de clusters para pessoas em 1987",
                          NOME_ARQUIVO = "No-clusters-R2-RMSSTD-pessoa-1987")

# Gerando variáveis que aramazenarão qual é o cluster da observação
pess_kmcluster2 <- kmeans(od_cluster_pess, 2)
od_cluster_pess$pesscluster2_ano87 <- pess_kmcluster2$cluster
pess_kmcluster3 <- kmeans(od_cluster_pess, 3)
od_cluster_pess$pesscluster3_ano87 <- pess_kmcluster3$cluster
pess_kmcluster4 <- kmeans(od_cluster_pess, 4)
od_cluster_pess$pesscluster4_ano87 <- pess_kmcluster4$cluster
pess_kmcluster5 <- kmeans(od_cluster_pess, 5)
od_cluster_pess$pesscluster5_ano87 <- pess_kmcluster5$cluster
pess_kmcluster6 <- kmeans(od_cluster_pess, 6)
od_cluster_pess$pesscluster6_ano87 <- pess_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_pess, ID_PESS, pesscluster2_ano87, pesscluster3_ano87,
                           pesscluster4_ano87, pesscluster5_ano87, pesscluster6_ano87), by='ID_PESS')

rm(od_cluster_pess)

###############################################################
######### CLUSTER PESSOA em 1997 - método centroide ###########
###############################################################

cat("\n\n############################################\n")
cat("Cluster em 1997\n")
# Selecionando as variáveis com atributos de viagem, da pessoa
od_cluster_pess <- od %>% filter(ANO==3, F_PESS==1) %>% select(PESS_DIST_TOT, PESS_DIST_MED,
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
registros_antes <- nrow(od_cluster_pess)
cat("Linhas totais de 97 antes do na.omit: ", registros_antes, "\n")
od_cluster_pess <- na.omit(od_cluster_pess)
registros_depois <- nrow(od_cluster_pess)
cat("Linhas totais de 97 depois do na.omit: ", registros_depois, "\n")
cat("Registros 'perdidos': ", registros_antes - registros_depois, "\n")

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
tempo <- system.time(pess_hcluster_97 <- hclust.vector(od_cluster_pess, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 97:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(pess_hcluster_97, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da pessoa para 1997')
dev.copy(png, file="dendro-hierarq-cluster-pessoa-1997.png")
dev.off()

grafico_seleciona_cluster(df=od_cluster_pess,
                          TITULO="Avaliação de clusters para pessoas em 1997",
                          NOME_ARQUIVO = "No-clusters-R2-RMSSTD-pessoa-1997")


# Gerando variáveis que aramazenarão qual é o cluster da observação
pess_kmcluster2 <- kmeans(od_cluster_pess, 2)
od_cluster_pess$pesscluster2_ano97 <- pess_kmcluster2$cluster
pess_kmcluster3 <- kmeans(od_cluster_pess, 3)
od_cluster_pess$pesscluster3_ano97 <- pess_kmcluster3$cluster
pess_kmcluster4 <- kmeans(od_cluster_pess, 4)
od_cluster_pess$pesscluster4_ano97 <- pess_kmcluster4$cluster
pess_kmcluster5 <- kmeans(od_cluster_pess, 5)
od_cluster_pess$pesscluster5_ano97 <- pess_kmcluster5$cluster
pess_kmcluster6 <- kmeans(od_cluster_pess, 6)
od_cluster_pess$pesscluster6_ano97 <- pess_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_pess, ID_PESS, pesscluster2_ano97, pesscluster3_ano97,
                           pesscluster4_ano97, pesscluster5_ano97, pesscluster6_ano97), by='ID_PESS')

rm(od_cluster_pess)

###############################################################
######### CLUSTER PESSOA em 2007 - método centroide ###########
###############################################################

cat("\n\n############################################\n")
cat("Cluster em 2007\n")
# Selecionando as variáveis com atributos de viagem, da pessoa
od_cluster_pess <- od %>% filter(ANO==4, F_PESS==1) %>% select(PESS_DIST_TOT, PESS_DIST_MED,
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
registros_antes <- nrow(od_cluster_pess)
cat("Linhas totais de 2007 antes do na.omit: ", registros_antes, "\n")
od_cluster_pess <- na.omit(od_cluster_pess)
registros_depois <- nrow(od_cluster_pess)
cat("Linhas totais de 2007 depois do na.omit: ", registros_depois, "\n")
cat("Registros 'perdidos': ", registros_antes - registros_depois, "\n")

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
tempo <- system.time(pess_hcluster_07 <- hclust.vector(od_cluster_pess, method="centroid", metric="euclidean", p=NULL))
print("Tempo do hclust.vector no ano de 07:", quote = F)
print(tempo)

# Plotando dendrograma para definir a quantidade de clusters
plot(pess_hcluster_07, xlab=NA, sub=NA, hang=-1, labels = FALSE,  main = 'Cluster de atributos de viagens da pessoa para 2007')
dev.copy(png, file="dendro-hierarq-cluster-pessoa-2007.png")
dev.off()

grafico_seleciona_cluster(df=od_cluster_pess,
                          TITULO="Avaliação de clusters para pessoas em 2007",
                          NOME_ARQUIVO = "No-clusters-R2-RMSSTD-pessoa-2007.png")

# Gerando variáveis que aramazenarão qual é o cluster da observação
pess_kmcluster2 <- kmeans(od_cluster_pess, 2)
od_cluster_pess$pesscluster2_ano07 <- pess_kmcluster2$cluster
pess_kmcluster3 <- kmeans(od_cluster_pess, 3)
od_cluster_pess$pesscluster3_ano07 <- pess_kmcluster3$cluster
pess_kmcluster4 <- kmeans(od_cluster_pess, 4)
od_cluster_pess$pesscluster4_ano07 <- pess_kmcluster4$cluster
pess_kmcluster5 <- kmeans(od_cluster_pess, 5)
od_cluster_pess$pesscluster5_ano07 <- pess_kmcluster5$cluster
pess_kmcluster6 <- kmeans(od_cluster_pess, 6)
od_cluster_pess$pesscluster6_ano07 <- pess_kmcluster6$cluster

# Incorporando as variáveis indicativas de cluster no BDU
od <- left_join(od, select(od_cluster_pess, ID_PESS, pesscluster2_ano07, pesscluster3_ano07,
                            pesscluster4_ano07, pesscluster5_ano07, pesscluster6_ano07), by='ID_PESS')

rm(registros_antes, registros_depois, tempo, od_cluster_pess)
