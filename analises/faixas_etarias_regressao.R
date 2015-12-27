source('dummies_fxs_etarias.R')
source('corrigindo-faixas-etarias.R')
source('presenca_idoso_crianca.R')
source('dummies_anos.R')

# od_reg_1 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
od_reg_1 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==1)

# Regressão linear múltipla de TOT_VIAG de od_reg com as faixas etárias
modelo_1 <- lm(TOT_VIAG ~ FX_ET_0 + FX_ET_1 + FX_ET_2 + FX_ET_3 + FX_ET_4 + FX_ET_5 + FX_ET_6 + FX_ET_7 +
                 FX_ET_8 + FX_ET_9 + FX_ET_10 + FX_ET_11 + FX_ET_12 + FX_ET_13 + FX_ET_14 + FX_ET_15 +
                 FX_ET_16 + FX_ET_17 + FX_ET_18 + FX_ET_19, data=od_reg_1)
summary(modelo_1)

# od_reg_2 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa é conjuge (SIT_FAM==2)
od_reg_2 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM==2)

# Regressão linear múltipla de TOT_VIAG de od_reg com as faixas etárias
modelo_2 <- lm(TOT_VIAG ~ FX_ET_0 + FX_ET_1 + FX_ET_2 + FX_ET_3 + FX_ET_4 + FX_ET_5 + FX_ET_6 + FX_ET_7 +
                 FX_ET_8 + FX_ET_9 + FX_ET_10 + FX_ET_11 + FX_ET_12 + FX_ET_13 + FX_ET_14 + FX_ET_15 +
                 FX_ET_16 + FX_ET_17 + FX_ET_18 + FX_ET_19, data=od_reg_2)
summary(modelo_2)

# od_reg_3 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# não é pessoa responsável pela família (SIT_FAM!=1) e nem conjuge (SIT_FAM!=2)
od_reg_3 <- od %>% filter(SEXO==2, F_PESS==1, SIT_FAM!=1, SIT_FAM!=2)

# Regressão linear múltipla de TOT_VIAG de od_reg com as faixas etárias
modelo_3 <- lm(TOT_VIAG ~ FX_ET_0 + FX_ET_1 + FX_ET_2 + FX_ET_3 + FX_ET_4 + FX_ET_5 + FX_ET_6 + FX_ET_7 +
                 FX_ET_8 + FX_ET_9 + FX_ET_10 + FX_ET_11 + FX_ET_12 + FX_ET_13 + FX_ET_14 + FX_ET_15 +
                 FX_ET_16 + FX_ET_17 + FX_ET_18 + FX_ET_19 + FX_ET_20, data=od_reg_3)
summary(modelo_3)
