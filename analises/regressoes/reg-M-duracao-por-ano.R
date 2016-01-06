source('dummies_fxs_etarias.R')
source('corrigindo-faixas-etarias.R')
source('presenca_idoso_crianca.R')
source('dummies_anos.R')
source('presenca_carro.R')

# od_reg_1 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_1 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de filhos até 4 anos
modelo_1 <- lm(DURACAO ~  PRESENCA_FILH_ate4 + (ANO_87:PRESENCA_FILH_ate4) +
                 (ANO_97:PRESENCA_FILH_ate4) + (ANO_07:PRESENCA_FILH_ate4), 
               data=od_reg_1)
summary(modelo_1)


# od_reg_2 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_2 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de filhos entre 5 e 9 anos
modelo_2 <- lm(DURACAO ~ PRESENCA_FILH_5a9 + (ANO_87:PRESENCA_FILH_5a9) +
                 (ANO_97:PRESENCA_FILH_5a9) + (ANO_07:PRESENCA_FILH_5a9), 
               data=od_reg_2)
summary(modelo_2)


# od_reg_3 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_3 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de filhos entre 10 e 14 anos
modelo_3 <- lm(DURACAO ~ PRESENCA_FILH_10a14 + (ANO_87:PRESENCA_FILH_10a14) +
                 (ANO_97:PRESENCA_FILH_10a14) + (ANO_07:PRESENCA_FILH_10a14),
               data=od_reg_3)
summary(modelo_3)


# od_reg_4 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_4 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de filhos entre 15 e 19 anos
modelo_4 <- lm(DURACAO ~ PRESENCA_FILH_15a19 + (ANO_87:PRESENCA_FILH_15a19) +
                 (ANO_97:PRESENCA_FILH_15a19) + (ANO_07:PRESENCA_FILH_15a19),
               data=od_reg_4)
summary(modelo_4)


# od_reg_5 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_5 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de idosos entre 60 e 70 anos
modelo_5 <- lm(DURACAO ~ PRESENCA_IDOSO_60_70 + (ANO_87:PRESENCA_IDOSO_60_70) +
                 (ANO_97:PRESENCA_IDOSO_60_70) + (ANO_07:PRESENCA_IDOSO_60_70),
               data=od_reg_5)
summary(modelo_5)


# od_reg_6 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_6 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de idosos com mais de 70 anos
modelo_6 <- lm(DURACAO ~ PRESENCA_IDOSO_70 + (ANO_87:PRESENCA_IDOSO_70) +
                 (ANO_97:PRESENCA_IDOSO_70) + (ANO_07:PRESENCA_IDOSO_70),
               data=od_reg_6)
summary(modelo_6)


# od_reg_7 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_7 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de filhos até 9 anos
modelo_7 <- lm(DURACAO ~ PRESENCA_FILH_ate4 + (ANO_87:PRESENCA_FILH_ate4) +
                 (ANO_97:PRESENCA_FILH_ate4) + (ANO_07:PRESENCA_FILH_ate4) + 
                 PRESENCA_FILH_5a9 + (ANO_87:PRESENCA_FILH_5a9) +
                 (ANO_97:PRESENCA_FILH_5a9) + (ANO_07:PRESENCA_FILH_5a9),
               data=od_reg_7)
summary(modelo_7)


# od_reg_8 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_8 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de filhos até 14 anos
modelo_8 <- lm(DURACAO ~ PRESENCA_FILH_ate4 + (ANO_87:PRESENCA_FILH_ate4) +
                 (ANO_97:PRESENCA_FILH_ate4) + (ANO_07:PRESENCA_FILH_ate4) + 
                 PRESENCA_FILH_5a9 + (ANO_87:PRESENCA_FILH_5a9) +
                 (ANO_97:PRESENCA_FILH_5a9) + (ANO_07:PRESENCA_FILH_5a9) + 
                 PRESENCA_FILH_10a14 + (ANO_87:PRESENCA_FILH_10a14) +
                 (ANO_97:PRESENCA_FILH_10a14) + (ANO_07:PRESENCA_FILH_10a14),
               data=od_reg_8)
summary(modelo_8)


# od_reg_9 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_9 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de filhos até 19 anos
modelo_9 <- lm(DURACAO ~ PRESENCA_FILH_ate4 + (ANO_87:PRESENCA_FILH_ate4) +
                 (ANO_97:PRESENCA_FILH_ate4) + (ANO_07:PRESENCA_FILH_ate4) + 
                 PRESENCA_FILH_5a9 + (ANO_87:PRESENCA_FILH_5a9) +
                 (ANO_97:PRESENCA_FILH_5a9) + (ANO_07:PRESENCA_FILH_5a9) + 
                 PRESENCA_FILH_10a14 + (ANO_87:PRESENCA_FILH_10a14) +
                 (ANO_97:PRESENCA_FILH_10a14) + (ANO_07:PRESENCA_FILH_10a14) +
                 PRESENCA_FILH_15a19 + (ANO_87:PRESENCA_FILH_15a19) +
                 (ANO_97:PRESENCA_FILH_15a19) + (ANO_07:PRESENCA_FILH_15a19),
               data=od_reg_9)
summary(modelo_9)


# od_reg_10 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_10 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de idosos com mais de 60 anos
modelo_10 <- lm(DURACAO ~ PRESENCA_IDOSO_60_70 + (ANO_87:PRESENCA_IDOSO_60_70) +
                  (ANO_97:PRESENCA_IDOSO_60_70) + (ANO_07:PRESENCA_IDOSO_60_70) +
                  PRESENCA_IDOSO_70 + (ANO_87:PRESENCA_IDOSO_70) +
                  (ANO_97:PRESENCA_IDOSO_70) + (ANO_07:PRESENCA_IDOSO_70),
                data=od_reg_10)
summary(modelo_10)


# od_reg_11 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
# idade inferior a 60 anos (FAIXA_ETARIA < 12)
od_reg_11 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1, FAIXA_ETARIA<12)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de idosos com mais de 60 anos
modelo_11 <- lm(DURACAO ~ PRESENCA_IDOSO_60_70 + (ANO_87:PRESENCA_IDOSO_60_70) +
                  (ANO_97:PRESENCA_IDOSO_60_70) + (ANO_07:PRESENCA_IDOSO_60_70) +
                  PRESENCA_IDOSO_70 + (ANO_87:PRESENCA_IDOSO_70) +
                  (ANO_97:PRESENCA_IDOSO_70) + (ANO_07:PRESENCA_IDOSO_70),
                data=od_reg_11)
summary(modelo_11)


# od_reg_12 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_12 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de DURACAO de od_reg com as faixas etárias
# Avaliação somente do efeito da presença de automóvel
modelo_12 <- lm(DURACAO ~ PRESENCA_AUTO + (ANO_87:PRESENCA_AUTO) +
                  (ANO_97:PRESENCA_AUTO) + (ANO_07:PRESENCA_AUTO), 
                data=od_reg_12)
summary(modelo_12)

