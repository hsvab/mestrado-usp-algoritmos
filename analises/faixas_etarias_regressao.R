# Criando novas variaveis com marcação da faixa etária, para posterior regressão linear
# e definição de (i) quem é criança e (ii) quem é idoso?
#
# Faixas Etárias:
# valor & label
# 0 -> 0 a 4 anos
# 1 -> 5 a 9 anos
# 2 -> 10 a 14 anos
# 3 -> 15 a 19 anos
# 4 -> 20 a 24 anos
# 5 -> 25 a 29 anos
# 6 -> 30 a 34 anos
# 7 -> 35 a 39 anos
# 8 -> 40 a 44 anos
# 9 -> 45 a 49 anos
# 10 -> 50 a 54 anos
# 11 -> 55 a 59 anos
# 12 -> 60 a 64 anos
# 13 -> 65 a 69 anos
# 14 -> 70 a 74 anos
# 15 -> 75 a 79 anos
# 16 -> 80 a 84 anos
# 17 -> 85 a 89 anos
# 18 -> 90 a 94 anos
# 19 -> 95 a 99 anos
# 20 -> mais de 100 anos

library(dplyr)

od <- od  %>%
  
  # Inicializando as variáveis para cada FX etaria
  mutate(FX_ET_0=0) %>%
  mutate(FX_ET_1=0) %>%
  mutate(FX_ET_2=0) %>%
  mutate(FX_ET_3=0) %>%
  mutate(FX_ET_4=0) %>%
  mutate(FX_ET_5=0) %>%
  mutate(FX_ET_6=0) %>%
  mutate(FX_ET_7=0) %>%
  mutate(FX_ET_8=0) %>%
  mutate(FX_ET_9=0) %>%
  mutate(FX_ET_10=0) %>%
  mutate(FX_ET_11=0) %>%
  mutate(FX_ET_12=0) %>%
  mutate(FX_ET_13=0) %>%
  mutate(FX_ET_14=0) %>%
  mutate(FX_ET_15=0) %>%
  mutate(FX_ET_16=0) %>%
  mutate(FX_ET_17=0) %>%
  mutate(FX_ET_18=0) %>%
  mutate(FX_ET_19=0) %>%
  mutate(FX_ET_20=0)

od <- od  %>%
  mutate(FX_ET_0=ifelse(
    IDADE >=0 & IDADE <=4,
    1,
    FX_ET_0
  ))

od <- od  %>%
  mutate(FX_ET_1=ifelse(
    IDADE >=5 & IDADE <=9,
    1,
    FX_ET_1
  ))

od <- od  %>%
  mutate(FX_ET_2=ifelse(
    IDADE >=10 & IDADE <=14,
    1,
    FX_ET_2
  ))

od <- od  %>%
  mutate(FX_ET_3=ifelse(
    IDADE >=15 & IDADE <=19,
    1,
    FX_ET_3
  ))

od <- od  %>%
  mutate(FX_ET_4=ifelse(
    IDADE >=20 & IDADE <=24,
    1,
    FX_ET_4
  ))

od <- od  %>%
  mutate(FX_ET_5=ifelse(
    IDADE >=25 & IDADE <=29,
    1,
    FX_ET_5
  ))

od <- od  %>%
  mutate(FX_ET_6=ifelse(
    IDADE >=30 & IDADE <=34,
    1,
    FX_ET_6
  ))

od <- od  %>%
  mutate(FX_ET_7=ifelse(
    IDADE >=35 & IDADE <=39,
    1,
    FX_ET_7
  ))

od <- od  %>%
  mutate(FX_ET_8=ifelse(
    IDADE >=40 & IDADE <=44,
    1,
    FX_ET_8
  ))

od <- od  %>%
  mutate(FX_ET_9=ifelse(
    IDADE >=45 & IDADE <=49,
    1,
    FX_ET_9
  ))

od <- od  %>%
  mutate(FX_ET_10=ifelse(
    IDADE >=50 & IDADE <=54,
    1,
    FX_ET_10
  ))

od <- od  %>%
  mutate(FX_ET_11=ifelse(
    IDADE >=55 & IDADE <=59,
    1,
    FX_ET_11
  ))

od <- od  %>%
  mutate(FX_ET_12=ifelse(
    IDADE >=60 & IDADE <=64,
    1,
    FX_ET_12
  ))

od <- od  %>%
  mutate(FX_ET_13=ifelse(
    IDADE >=65 & IDADE <=69,
    1,
    FX_ET_13
  ))

od <- od  %>%
  mutate(FX_ET_14=ifelse(
    IDADE >=70 & IDADE <=74,
    1,
    FX_ET_14
  ))

od <- od  %>%
  mutate(FX_ET_15=ifelse(
    IDADE >=75 & IDADE <=79,
    1,
    FX_ET_15
  ))

od <- od  %>%
  mutate(FX_ET_16=ifelse(
    IDADE >=80 & IDADE <=84,
    1,
    FX_ET_16
  ))

od <- od  %>%
  mutate(FX_ET_17=ifelse(
    IDADE >=85 & IDADE <=89,
    1,
    FX_ET_17
  ))

od <- od  %>%
  mutate(FX_ET_18=ifelse(
    IDADE >=90 & IDADE <=94,
    1,
    FX_ET_18
  ))

od <- od  %>%
  mutate(FX_ET_19=ifelse(
    IDADE >=95 & IDADE <=99,
    1,
    FX_ET_19
  ))

od <- od  %>%
  mutate(FX_ET_20=ifelse(
    IDADE > 99,
    1,
    FX_ET_20
  ))


# od_reg_1 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_1 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de TOT_VIAG de od_reg com as faixas etárias
modelo_1 <- lm(TOT_VIAG ~ FX_ET_0 + FX_ET_1 + FX_ET_2 + FX_ET_3 + FX_ET_4 + FX_ET_5 + FX_ET_6 + FX_ET_7 +
                 FX_ET_8 + FX_ET_9 + FX_ET_10 + FX_ET_11 + FX_ET_12 + FX_ET_13 + FX_ET_14 + FX_ET_15 +
                 FX_ET_16 + FX_ET_17 + FX_ET_18 + FX_ET_19 + FX_ET_20, data=od_reg_1)
summary(modelo_1)

# od_reg_2 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa é conjuge (SIT_FAM==2)
od_reg_2 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==2)

# Regressão linear múltipla de TOT_VIAG de od_reg com as faixas etárias
modelo_2 <- lm(TOT_VIAG ~ FX_ET_0 + FX_ET_1 + FX_ET_2 + FX_ET_3 + FX_ET_4 + FX_ET_5 + FX_ET_6 + FX_ET_7 +
                 FX_ET_8 + FX_ET_9 + FX_ET_10 + FX_ET_11 + FX_ET_12 + FX_ET_13 + FX_ET_14 + FX_ET_15 +
                 FX_ET_16 + FX_ET_17 + FX_ET_18 + FX_ET_19 + FX_ET_20, data=od_reg_2)
summary(modelo_2)

# od_reg_3 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa é responsável pela família (SIT_FAM==1) ou cônjuge
od_reg_3 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1 | SIT_FAM==2)

# Regressão linear múltipla de TOT_VIAG de od_reg com as faixas etárias
modelo_3 <- lm(TOT_VIAG ~ FX_ET_0 + FX_ET_1 + FX_ET_2 + FX_ET_3 + FX_ET_4 + FX_ET_5 + FX_ET_6 + FX_ET_7 +
                 FX_ET_8 + FX_ET_9 + FX_ET_10 + FX_ET_11 + FX_ET_12 + FX_ET_13 + FX_ET_14 + FX_ET_15 +
                 FX_ET_16 + FX_ET_17 + FX_ET_18 + FX_ET_19 + FX_ET_20, data=od_reg_3)
summary(modelo_3)

# od_reg_4 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# não é pessoa responsável pela família (SIT_FAM!=1) e nem conjuge (SIT_FAM!=2)
od_reg_4 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM!=1, SIT_FAM!=2)

# Regressão linear múltipla de TOT_VIAG de od_reg com as faixas etárias
modelo_4 <- lm(TOT_VIAG ~ FX_ET_0 + FX_ET_1 + FX_ET_2 + FX_ET_3 + FX_ET_4 + FX_ET_5 + FX_ET_6 + FX_ET_7 +
                 FX_ET_8 + FX_ET_9 + FX_ET_10 + FX_ET_11 + FX_ET_12 + FX_ET_13 + FX_ET_14 + FX_ET_15 +
                 FX_ET_16 + FX_ET_17 + FX_ET_18 + FX_ET_19 + FX_ET_20, data=od_reg_4)
summary(modelo_4)