#
# Criando nova variável para armazenar distância total percorrida por pessoa
#

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de DIST_VIAG
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, DIST_VIAG) %>% 
            mutate(DIST_VIAG = ifelse(is.na(DIST_VIAG),0,DIST_VIAG)) %>% 
            group_by(ID_PESS) %>% 
            summarise(PESS_DIST_TOT = sum(DIST_VIAG), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od <- left_join(od, select(AUX1, ID_PESS, PESS_DIST_TOT), by = 'ID_PESS')

# Criando nova variável para armazenar distância média de viagem de cada pessoa
od <- od %>% mutate(PESS_DIST_MED = PESS_DIST_TOT / TOT_VIAG)

#
# Criando nova variável para armazenar distância total percorrida por família
#

# Usando variável auxiliar AUX2 para agrupar por familia e fazer somatório de DIST_VIAG
AUX2 <- od %>% select(ANO, F_FAM, ID_FAM, DIST_VIAG) %>% 
  mutate(DIST_VIAG = ifelse(is.na(DIST_VIAG),0,DIST_VIAG)) %>% 
  group_by(ID_FAM) %>% 
  summarise(FAM_DIST_TOT = sum(DIST_VIAG), ANO = unique(ANO))

# Unindo resultado da variável AUX2 no dataframe od original
od <- left_join(od, select(AUX2, ID_FAM, FAM_DIST_TOT), by = 'ID_FAM')

# Usando variável auxiliar AUX3 para agrupar por familia e fazer somatório de TOT_VIAG
AUX3 <- od %>% filter(F_PESS==1) %>% 
               group_by(ID_FAM) %>% 
               summarise(FAM_VIAG_TOT = sum(TOT_VIAG), ANO = unique(ANO))

# Unindo resultado da variável AUX3 no dataframe od original
od <- left_join(od, select(AUX3, ID_FAM, FAM_VIAG_TOT), by = 'ID_FAM')

# Criando nova variável para armazenar distância média de viagem de cada família
od <- od %>% mutate(FAM_DIST_MED = FAM_DIST_TOT / FAM_VIAG_TOT )





