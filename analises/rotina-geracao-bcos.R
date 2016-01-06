# Lê a base od processada e unificada
od <- read.csv(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od.csv",
               header = TRUE, sep = ";", dec = ",", colClasses = c("ID_DOM"="character", "ID_FAM"="character", "ID_PESS"="character", "ID_VIAG"="character"))

# Gera od-2.csv
source('faixas_etarias.R')
source('faixas_horarias.R')
source('faixas_renda.R')
od %>% write.table(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-2.csv", 
                   sep = ";", dec = ",", row.names = FALSE)

# Gera od-3.csv
source('contagem_modos_viagem.R')
od %>% write.table(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-3.csv", 
                   sep = ";", dec = ",", row.names = FALSE)

# Gera od-4.csv
source('distancias_pessoa.R')
od %>% write.table(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-4.csv", 
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1, AUX2, AUX3)

# Gera od-5.csv
source('duracoes_pessoas.R')
od %>% write.table(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-5.csv", 
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1, AUX2, AUX3)

# Gera od-6.csv
source('contagem_modos_pessoa.R')
od %>% write.table(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-6.csv", 
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)

# Gera od-7.csv
source('contagem_motivos_viagem.R')
source('contagem_motivos_pessoas.R')
od %>% write.table(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-7.csv", 
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)

# Gera od-8.csv
source('contagem_periodos_viagens.R')
source('contagem_periodos_pessoas.R')
od %>% write.table(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-8.csv", 
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)

# Gera od-9.csv
source('dummies_fxs_etarias.R')
source('correcao_faixas_etarias.R')
source('presenca_idoso_crianca.R')
od %>% write.table(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-9.csv", 
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)

# Gera od-10.csv
source('dummies_anos.R')
source('presenca_carro.R')
od %>% write.table(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-10.csv", 
                   sep = ";", dec = ",", row.names = FALSE)
rm(AUX1)