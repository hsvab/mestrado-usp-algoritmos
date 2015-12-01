# Criando novas variáveis com contagem dos motivos de viagem, por pessoa
# 
# 0 -> não fez viagem
# PESS_PER_MADRUG
# PESS_PER_COM_MAN
# PESS_PER_MANHA
# PESS_PER_MEIODIA
# PESS_PER_TARDE
# PESS_PER_COM_NOI
# PESS_PER_NOITE
# PESS_NO_PERIODOS conta quantos periodos diferentes foram utilizados, por pessoa, de acordo com estas 7 categorias

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_PER_MADRUG
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_PER_MADRUG) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_PER_MADRUG = sum(VIAG_PER_MADRUG), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_PER_MADRUG=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_PER_MADRUG), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_PER_COM_MAN
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_PER_COM_MAN) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_PER_COM_MAN = sum(VIAG_PER_COM_MAN), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_PER_COM_MAN=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_PER_COM_MAN), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_PER_MANHA
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_PER_MANHA) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_PER_MANHA = sum(VIAG_PER_MANHA), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_PER_MANHA=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_PER_MANHA), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_PER_MEIODIA
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_PER_MEIODIA) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_PER_MEIODIA = sum(VIAG_PER_MEIODIA), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_PER_MEIODIA=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_PER_MEIODIA), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_PER_TARDE
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_PER_TARDE) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_PER_TARDE = sum(VIAG_PER_TARDE), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_PER_TARDE=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_PER_TARDE), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_PER_COM_NOI
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_PER_COM_NOI) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_PER_COM_NOI = sum(VIAG_PER_COM_NOI), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_PER_COM_NOI=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_PER_COM_NOI), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_PER_NOITE
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_PER_NOITE) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_PER_NOITE = sum(VIAG_PER_NOITE), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_PER_NOITE=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_PER_NOITE), by = 'ID_PESS')

od$PESS_NO_PERIODOS = 0
od <- od  %>%  
  # Analisando PESS_NO_PERIODOS
  mutate(PESS_NO_PERIODOS=ifelse(
    (PESS_PER_MADRUG!=0)
    ,
    PESS_NO_PERIODOS+1,
    PESS_NO_PERIODOS
  )) %>%
  mutate(PESS_NO_PERIODOS=ifelse(
    (PESS_PER_COM_MAN!=0)
    ,
    PESS_NO_PERIODOS+1,
    PESS_NO_PERIODOS
  )) %>%
  mutate(PESS_NO_PERIODOS=ifelse(
    (PESS_PER_MANHA!=0)
    ,
    PESS_NO_PERIODOS+1,
    PESS_NO_PERIODOS
  )) %>%  
  mutate(PESS_NO_PERIODOS=ifelse(
    (PESS_PER_MEIODIA!=0)
    ,
    PESS_NO_PERIODOS+1,
    PESS_NO_PERIODOS
  )) %>%
  mutate(PESS_NO_PERIODOS=ifelse(
    (PESS_PER_TARDE!=0)
    ,
    PESS_NO_PERIODOS+1,
    PESS_NO_PERIODOS
  )) %>%
  mutate(PESS_NO_PERIODOS=ifelse(
    (PESS_PER_COM_NOI!=0)
    ,
    PESS_NO_PERIODOS+1,
    PESS_NO_PERIODOS
  )) %>%
  mutate(PESS_NO_PERIODOS=ifelse(
    (PESS_PER_NOITE!=0)
    ,
    PESS_NO_PERIODOS+1,
    PESS_NO_PERIODOS
  ))
