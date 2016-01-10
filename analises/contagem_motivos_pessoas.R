# Criando novas variáveis com contagem dos motivos de viagem, por pessoa
# 
# 0 -> não fez viagem
# PESS_MOTIVO_MOTIVO_SERV_PAS
# PESS_MOTIVO_TRAB
# PESS_MOTIVO_EDUC
# PESS_MOTIVO_RES
# PESS_MOTIVO_MANUT_COMPRAS
# PESS_MOTIVO_LAZER_OUTROS
# PESS_NO_MOTIVOS conta quantos motivos diferentes foram utilizados, por pessoa, de acordo com estas 4 categorias

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MOTIVO_TRAB
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MOTIVO_TRAB) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MOTIVO_TRAB = sum(VIAG_MOTIVO_TRAB), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MOTIVO_TRAB=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MOTIVO_TRAB), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MOTIVO_EDUC
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MOTIVO_EDUC) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MOTIVO_EDUC = sum(VIAG_MOTIVO_EDUC), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MOTIVO_EDUC=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MOTIVO_EDUC), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MOTIVO_RES
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MOTIVO_RES) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MOTIVO_RES = sum(VIAG_MOTIVO_RES), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MOTIVO_RES=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MOTIVO_RES), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MOTIVO_SERV_PAS
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MOTIVO_SERV_PAS) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MOTIVO_SERV_PAS = sum(VIAG_MOTIVO_SERV_PAS), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MOTIVO_SERV_PAS=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MOTIVO_SERV_PAS), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MOTIVO_MANUT_COMPRAS
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MOTIVO_MANUT_COMPRAS) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MOTIVO_MANUT_COMPRAS = sum(VIAG_MOTIVO_MANUT_COMPRAS), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MOTIVO_MANUT_COMPRAS=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MOTIVO_MANUT_COMPRAS), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MOTIVO_LAZER_OUTROS
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MOTIVO_LAZER_OUTROS) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MOTIVO_LAZER_OUTROS = sum(VIAG_MOTIVO_LAZER_OUTROS), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MOTIVO_LAZER_OUTROS=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MOTIVO_LAZER_OUTROS), by = 'ID_PESS')

od$PESS_NO_MOTIVOS = 0
od <- od  %>%  
  # Analisando PESS_NO_MOTIVOS
  mutate(PESS_NO_MOTIVOS=ifelse(
    (PESS_MOTIVO_TRAB!=0)
    ,
    PESS_NO_MOTIVOS+1,
    PESS_NO_MOTIVOS
  )) %>%
  mutate(PESS_NO_MOTIVOS=ifelse(
    (PESS_MOTIVO_EDUC!=0)
    ,
    PESS_NO_MOTIVOS+1,
    PESS_NO_MOTIVOS
  )) %>%
  mutate(PESS_NO_MOTIVOS=ifelse(
    (PESS_MOTIVO_RES!=0)
    ,
    PESS_NO_MOTIVOS+1,
    PESS_NO_MOTIVOS
  )) %>%  
  mutate(PESS_NO_MOTIVOS=ifelse(
    (PESS_MOTIVO_SERV_PAS!=0)
    ,
    PESS_NO_MOTIVOS+1,
    PESS_NO_MOTIVOS
  )) %>%
  mutate(PESS_NO_MOTIVOS=ifelse(
    (PESS_MOTIVO_MANUT_COMPRAS!=0)
    ,
    PESS_NO_MOTIVOS+1,
    PESS_NO_MOTIVOS
  )) %>%  
  mutate(PESS_NO_MOTIVOS=ifelse(
    (PESS_MOTIVO_LAZER_OUTROS!=0)
    ,
    PESS_NO_MOTIVOS+1,
    PESS_NO_MOTIVOS
  ))
    

