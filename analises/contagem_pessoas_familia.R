# Criando variável tamanho da família (ou total de pessoas na família)

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MOTIVO_SERV_PAS
AUX1 <- od %>% select(NO_PESS, ID_FAM) %>% group_by(ID_FAM) %>% summarise(TOT_PESS = max(NO_PESS))

# Unindo resultado da variável AUX1 no dataframe od original
od$TOT_PESS=NULL
od <- left_join(od, select(AUX1, ID_FAM, TOT_PESS), by = 'ID_FAM')