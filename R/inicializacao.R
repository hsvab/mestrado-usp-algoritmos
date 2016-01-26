cat("Seja bem vinda(o) ao Projeto do Mestrado da Haydée.\n")
packages<-function(x){
  x<-as.character(x)
  base::require(x,character.only=TRUE, quietly=TRUE)
}

pacotes_mestrado <- c("mlogit", "ggplot2", "readstata13", "foreign","data.table",
                      "Hmisc", "gmodels", "memisc", "sfsmisc", "lazyeval",
                       "psych", "plyr", "fastcluster", "mlogit", "mnlogit",
                      "dplyr")

cat("Carregando as bibliotecas:\n")
cat(pacotes_mestrado,"\n")

for( pacote in pacotes_mestrado ) {
  packages(pacote)
}

rm(packages, pacotes_mestrado, pacote)
cat("Carregando as funções auxiliares.....")
source('R/funcoes_auxiliares.R')
cat(" OK\n")

cat("Carregando funções auxiliares de sumarização....")
source('R/auxiliar_sumarizacao.R')
cat(" OK\n")

cat("Carregando função que gera gráficos de clusters....")
source('R/graficos_de_clusters.R')
cat(" OK\n")

cat("Carregando funções que aplica labels no dataframe da OD....")
source('R/aplica_labels.R')
cat(" OK\n")

cat("Carregando variáveis globais....")
source('R/variaveis_gerais.R')
cat(" OK\n")

# Setando diretorio aonde estão os algoritmos
setwd(.dirAlgoritmosAnalises)
cat("\nAlterando o 'working directory' para 'analises' ('",getwd(),"')\n")

cat("\nAmbiente pronto para ser utilizado, bom trabalho! <3\n\n")
