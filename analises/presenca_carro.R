######################################################
##### VERIFICANDO SE EXISTE AUTOMÓVEL NA FAMÍLIA #####
######################################################

# Usando variável auxiliar AUX1 para agrupar por familia e marcar a posse de automóvel por qualquer membro da família
AUX1 <- od %>% select(ANO, ID_FAM, QT_AUTO) %>%
  group_by(ID_FAM) %>%
  summarise(PRESENCA_AUTO = ifelse(any(QT_AUTO!=0),
                                          1,
                                          0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_AUTO=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_AUTO), by = 'ID_FAM')

######################################################
##### SEPARANDO DUMMIES DE 1 E 2 OU + AUTOMÓVEIS #####
######################################################

# Usando variável auxiliar AUX1 para agrupar por familia e marcar a posse de 1 auto por qualquer membro da família
AUX1 <- od %>% select(ANO, ID_FAM, QT_AUTO) %>%
  group_by(ID_FAM) %>%
  summarise(PRESENCA_AUTO1 = ifelse(any(QT_AUTO==1),
                                   1,
                                   0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_AUTO1=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_AUTO1), by = 'ID_FAM')


# Usando variável auxiliar AUX1 para agrupar por familia e marcar a posse de 2 ou mais autos por qualquer membro da família
AUX1 <- od %>% select(ANO, ID_FAM, QT_AUTO) %>%
  group_by(ID_FAM) %>%
  summarise(PRESENCA_AUTO2 = ifelse(any(QT_AUTO>=2),
                                    1,
                                    0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$PRESENCA_AUTO2=NULL
od <- left_join(od, select(AUX1, ID_FAM, PRESENCA_AUTO2), by = 'ID_FAM')
