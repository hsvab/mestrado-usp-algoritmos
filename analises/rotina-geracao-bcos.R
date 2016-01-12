# Lê a base od processada e unificada
install.packages('ggplot2')
library(ggplot2)
install.packages('readstata13')
library(readstata13)
install.packages('Hmisc')
library(Hmisc)
install.packages('psych')
library(psych)
install.packages('plyr')
library(plyr)
install.packages('dplyr')
library(dplyr)

bases.note.haydee <- '/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/'
bases.servidor <- '/home/haydee/mestrado/bases/banco unico - pols/'
analises.note.haydee <- '/home/haydee/Área de trabalho/mestrado-PT/ALGORITMOS/analises/'
analises.servidor <- '/home/haydee/mestrado/algoritmos/analises/'

# Escolher conforme for mais conveniente
diretorio.bases <- bases.note.haydee
diretorio.algoritmos.analises <- analises.note.haydee

# Setando diretorio aonde estão os algoritmos
setwd(diretorio.algoritmos.analises)

od <- read.csv(file = paste0(diretorio.bases, "od.csv"),
               header = TRUE, sep = ";", dec = ",", colClasses = c("ID_DOM"="character", "ID_FAM"="character",
                                                                   "ID_PESS"="character", "ID_VIAG"="character"))

# Gera od-01.csv
source('correcao_tipo_est_auto.R')
source('correcao_serv_pas.R')
od %>% write.table(file = paste0(diretorio.bases, "od-01.csv"),
                   sep = ";", dec = ",", row.names = FALSE)

# Gera od-02.csv
source('faixas_etarias.R')
source('faixas_horarias.R')
source('faixas_renda.R')
od %>% write.table(file = paste0(diretorio.bases, "od-02.csv"),
                   sep = ";", dec = ",", row.names = FALSE)

# Gera od-03.csv
source('contagem_modos_viagem.R')
od %>% write.table(file = paste0(diretorio.bases, "od-03.csv"),
                   sep = ";", dec = ",", row.names = FALSE)

# Gera od-04.csv
source('distancias_pessoa.R')
od %>% write.table(file = paste0(diretorio.bases, "od-04.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1, AUX2, AUX3)

# Gera od-05.csv
source('duracoes_pessoas.R')
od %>% write.table(file = paste0(diretorio.bases, "od-05.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1, AUX2, AUX3)

# Gera od-06.csv
source('contagem_modos_pessoa.R')
od %>% write.table(file = paste0(diretorio.bases, "od-06.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)

# Gera od-07.csv
source('contagem_motivos_viagem.R')
source('contagem_motivos_pessoas.R')
od %>% write.table(file = paste0(diretorio.bases, "od-07.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)

# Gera od-08.csv
source('contagem_periodos_viagens.R')
source('contagem_periodos_pessoas.R')
od %>% write.table(file = paste0(diretorio.bases, "od-08.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)

# Gera od-09.csv
source('dummies_fxs_etarias.R')
source('correcao_faixas_etarias.R')
source('presenca_idoso_crianca.R')
od %>% write.table(file = paste0(diretorio.bases, "od-09.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)

# Gera od-10.csv
source('dummies_anos.R')
source('presenca_carro.R')
od %>% write.table(file = paste0(diretorio.bases, "od-10.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)

# Gera od-11.csv
source('contagem_pessoas_familia.R')
od %>% write.table(file = paste0(diretorio.bases, "od-11.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)


# Gera od-12A.csv
source('cluster-fam-var-viagens.R')
source('cluster-fam-var-viagens-por-ano.R')
#source('cluster-pess-var-viagens.R')
#source('cluster-pess-var-viagens-por-ano.R')
od %>% write.table(file = paste0(diretorio.bases, "od-12A.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
