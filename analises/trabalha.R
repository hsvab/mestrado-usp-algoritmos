############################################
##### VERIFICANDO SE A PESSOA TRABALHA #####
############################################

# Usando variável auxiliar AUX1 para verificar se a pessoa trabalha
AUX1 <- od %>% select(ANO, ID_PESS, OCUP) %>%
  group_by(ID_PESS) %>%
  summarise(TRABALHA = ifelse(any(OCUP==1),
                                       1,
                                       0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$TRABALHA=NULL
od <- left_join(od, select(AUX1, ID_PESS, TRABALHA), by = 'ID_PESS')


###########################################################
##### VERIFICANDO SE EXISTE TRABALHADOR(A) NA FAMÍLIA #####
###########################################################

# Usando variável auxiliar AUX1 para agrupar por familia e marcar se existe trabalhador na família
AUX1 <- od %>% select(ANO, ID_FAM, TRABALHA) %>%
  group_by(ID_FAM) %>%
  summarise(FAM_PRESENCA_TRAB = ifelse(any(TRABALHA==1),
                                   1,
                                   0
  ))
# Unindo resultado da variável AUX1 no dataframe od original
od$FAM_PRESENCA_TRAB=NULL
od <- left_join(od, select(AUX1, ID_FAM, FAM_PRESENCA_TRAB), by = 'ID_FAM')


########################################################################
##### VERIFICANDO QUANTOS(AS) TRABALHADORES(AS) EXISTEM NA FAMÍLIA #####
########################################################################

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de FAM_QTDE_TRAB
AUX1 <- od %>% filter (F_PESS==1) %>% select(TRABALHA, ID_FAM) %>% group_by(ID_FAM) %>% summarise(FAM_QTDE_TRAB = sum(TRABALHA))

# Unindo resultado da variável AUX1 no dataframe od original
od$FAM_QTDE_TRAB=NULL
od <- left_join(od, select(AUX1, ID_FAM, FAM_QTDE_TRAB), by = 'ID_FAM')
