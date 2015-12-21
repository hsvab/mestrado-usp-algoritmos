# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de idoso com idade entre 60 e 70 anos na família
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA) %>% 
  group_by(ID_FAM) %>%
  summarise(PRESENCA_IDOSO_60_70 = ifelse(any(FAIXA_ETARIA==12) | any(FAIXA_ETARIA==13),
                                    1,
                                    0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_IDOSO_60_70=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_IDOSO_60_70), by = 'ID_FAM')
#
###
#
# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de idoso (pessoa com 70 anos ou mais) na família
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA) %>% 
  group_by(ID_FAM) %>% 
  summarise(PRESENCA_IDOSO_70 = ifelse(max(FAIXA_ETARIA)>=14,
                                       1,
                                       0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_IDOSO_70=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_IDOSO_70), by = 'ID_FAM')
#
###
#
# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de crianças até 4 anos (FX_ET_0)
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA, SIT_FAM) %>% 
  group_by(ID_FAM) %>% 
  summarise(PRESENCA_FILH_ate4 = ifelse(any(FAIXA_ETARIA==0 & (SIT_FAM==3 | SIT_FAM==4)),
                                    1,
                                    0
                                    ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_FILH_ate4=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_FILH_ate4), by = 'ID_FAM')
#
###
#
# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de crianças entre 5 e 9 anos (FX_ET_1)
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA,SIT_FAM) %>% 
  group_by(ID_FAM) %>% 
  summarise(PRESENCA_FILH_5a9 = ifelse(any(FAIXA_ETARIA==1 & (SIT_FAM==3 | SIT_FAM==4)),
                                        1,
                                        0
                                        ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_FILH_5a9=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_FILH_5a9), by = 'ID_FAM')
#
###
#
# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de crianças de 10 a 14 anos (FX_ET_2)
# Atenção: só foram marcados quem estava com situação familiar de filho ou outro parente, se a pessoa era cônjuge ou responsável, esta dummy não é acionada
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA, SIT_FAM) %>% 
  group_by(ID_FAM) %>% 
  summarise(PRESENCA_FILH_10a14 = ifelse(any(FAIXA_ETARIA==2 & (SIT_FAM==3 | SIT_FAM==4)),
                                       1,
                                       0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_FILH_10a14=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_FILH_10a14), by = 'ID_FAM')
#
###
#
# Usando variável auxiliar AUX1 para agrupar por familia e marcar a presença de adolescnetes entre 15 e 19 anos (FX_ET_3)
# Atenção: só foram marcados quem estava com situação familiar de filho ou outro parente, se a pessoa era cônjuge ou responsável, esta dummy não é acionada
AUX1 <- od %>% select(ANO, ID_FAM, FAIXA_ETARIA, SIT_FAM) %>% 
  group_by(ID_FAM) %>% 
  summarise(PRESENCA_FILH_15a19 = ifelse(any(FAIXA_ETARIA==3 & (SIT_FAM==3 | SIT_FAM==4)),
                                         1,
                                         0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_FILH_15a19=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_FILH_15a19), by = 'ID_FAM')