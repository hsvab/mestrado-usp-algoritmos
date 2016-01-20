# Lê a base od processada e unificada

od <- fread(input = file.path(.dirBasesUnicas, "od.csv"),
               header = TRUE, sep = ";", dec = ",", data.table = FALSE,
               colClasses = c("ID_DOM"="character", "ID_FAM"="character",
                              "ID_PESS"="character", "ID_VIAG"="character"))
# Gera od-01.csv
source('correcao_distancia.R')
source('correcao_tipo_est_auto.R')
source('correcao_serv_pas.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-01.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-01.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-01")

# Gera od-02.csv
source('faixas_etarias.R')
source('faixas_horarias.R')
source('faixas_renda.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-02.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-02.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-02")

# Gera od-03.csv
source('contagem_modos_viagem.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-03.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-03.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-03")

# Gera od-04.csv
source('distancias_pessoa.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-04.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1, AUX2, AUX3)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-04.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-04")

# Gera od-05.csv
source('duracoes_pessoas.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-05.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1, AUX2, AUX3)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-05.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-05")

# Gera od-06.csv
source('contagem_modos_pessoa.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-06.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-06.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-06")

# Gera od-07.csv
source('contagem_motivos_viagem.R')
source('contagem_motivos_pessoas.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-07.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-07.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-07")

# Gera od-08.csv
source('contagem_periodos_viagens.R')
source('contagem_periodos_pessoas.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-08.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-08.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-08")

# Gera od-09.csv
source('dummies_fxs_etarias.R')
source('correcao_faixas_etarias.R')
source('presenca_idoso_crianca.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-09.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-09.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-09")

# Gera od-10.csv
source('dummies_anos.R')
source('presenca_carro.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-10.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-10.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-10")

# Gera od-11.csv
source('contagem_pessoas_familia.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-11.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-11.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-11")

# Gera od-12A.csv
source('cluster-fam-var-viagens.R')
source('cluster-fam-var-viagens-por-ano.R')
source('cluster-pess-var-viagens.R')
source('cluster-pess-var-viagens-por-ano.R')
od %>% write.table(file = file.path(.dirBasesUnicas, "od-12.csv"),
                   sep = ";", dec = ",", row.names = FALSE)
# Compacta a base automaticamente como bz2
comando = paste0('bzip2 -f -q -9 "', file.path(.dirBasesUnicas, "od-12.csv"), '"')
system( comando, wait=FALSE )
cat(length(names(od)), "variáveis na versão od-12")
