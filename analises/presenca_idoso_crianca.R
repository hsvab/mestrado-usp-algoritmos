# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de idoso (pessoa com 70 anos ou mais) na família
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA) %>% 
  group_by(ID_FAM) %>% 
  summarise(PRESENCA_IDOSO = ifelse(max(FAIXA_ETARIA)>=14,
                                    1,
                                    0
                                    ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_IDOSO=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_IDOSO), by = 'ID_FAM')
#
#
# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de crianças até 4 anos (FX_ET_0)
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA) %>% 
  group_by(ID_FAM) %>% 
  summarise(PRESENCA_FILH_ate4 = ifelse(max(FAIXA_ETARIA)==0,
                                    1,
                                    0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_FILH_ate4=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_FILH_ate4), by = 'ID_FAM')
#
#
# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de crianças até 4 anos (FX_ET_0)
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA) %>% 
  group_by(ID_FAM) %>% 
  summarise(PRESENCA_FILH_5a9 = ifelse(max(FAIXA_ETARIA)==1,
                                        1,
                                        0
                                        ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_FILH_5a9=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_FILH_5a9), by = 'ID_FAM')
#
#
# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de crianças até 4 anos (FX_ET_0)
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA) %>% 
  group_by(ID_FAM) %>% 
  summarise(PRESENCA_FILH_10a14 = ifelse(max(FAIXA_ETARIA)==2,
                                       1,
                                       0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_FILH_10a14=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_FILH_10a14), by = 'ID_FAM')
#
#
# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de crianças até 4 anos (FX_ET_0)
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA) %>% 
  group_by(ID_FAM) %>% 
  summarise(PRESENCA_FILH_15a19 = ifelse(max(FAIXA_ETARIA)==3,
                                         1,
                                         0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_FILH_15a19=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_FILH_15a19), by = 'ID_FAM')


# Regressão linear múltipla de TOT_VIAG de od_reg com as faixas etárias
modelo_4 <- lm(TOT_VIAG ~ PRESENCA_FILH_ate4 + PRESENCA_FILH_5a9 + PRESENCA_FILH_10a14 + PRESENCA_FILH_15a19 + PRESENCA_IDOSO, data=od)
summary(modelo_4)
