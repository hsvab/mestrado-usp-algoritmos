#
# Criando nova variável para armazenar duração total dispendida em viagem/deslocamento por pessoa
#

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de DURACAO
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, DURACAO) %>% 
  mutate(DURACAO = ifelse(is.na(DURACAO),0,DURACAO)) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_DURACAO_TOT = sum(DURACAO), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_DURACAO_TOT=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_DURACAO_TOT), by = 'ID_PESS')

# Criando nova variável para armazenar duração média de viagem de cada pessoa
od <- od %>% mutate(PESS_DURACAO_MED = PESS_DURACAO_TOT / TOT_VIAG)

#
# Criando nova variável para armazenar duração total dispendida em viagem/deslocamento por família
#

# Usando variável auxiliar AUX2 para agrupar por familia e fazer somatório de DURACAO
AUX2 <- od %>% select(ANO, F_FAM, ID_FAM, DURACAO) %>% 
               mutate(DURACAO = ifelse(is.na(DURACAO),0,DURACAO)) %>% 
               group_by(ID_FAM) %>% 
               summarise(FAM_DURACAO_TOT = sum(DURACAO), ANO = unique(ANO))

# Unindo resultado da variável AUX2 no dataframe od original
od$FAM_DURACAO_TOT=NULL
od <- left_join(od, select(AUX2, ID_FAM, FAM_DURACAO_TOT), by = 'ID_FAM')

# Usando variável auxiliar AUX3 para agrupar por familia e fazer somatório de TOT_VIAG
AUX3 <- od %>% filter(F_PESS==1) %>% 
               group_by(ID_FAM) %>% 
               summarise(FAM_VIAG_TOT = sum(TOT_VIAG), ANO = unique(ANO))

# Unindo resultado da variável AUX3 no dataframe od original
od$FAM_VIAG_TOT=NULL
od <- left_join(od, select(AUX3, ID_FAM, FAM_VIAG_TOT), by = 'ID_FAM')

# Criando nova variável para armazenar duração média de viagem de cada família
od <- od %>% mutate(FAM_DURACAO_MED = FAM_DURACAO_TOT / FAM_VIAG_TOT )
