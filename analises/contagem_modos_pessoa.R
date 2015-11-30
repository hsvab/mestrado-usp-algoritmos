# Criando novas variáveis com contagem da utilização dos modos, por pessoa
# 
# 0 -> não fez viagem
# PESS_MODO_ONIBUS considera todas viagens feitas por ônibus de linha (municipal ou
# intermuniciapl), ônibus escolar, ônibus de empersa, lotação e van
# PESS_MODO_DIRIG considera todas viagens feitas por automóvel com a pessoa dirigindo
# PESS_MODO_PASS considera todas viagens feitas por automóvel com a pessoa como passageiro,
# incluindo as viagens de táxi
# PESS_MODO_TREM considera todas viagens feitas por metrô ou trem
# PESS_MODO_MOTO considera todas viagens feitas por motocicleta
# PESS_MODO_BICI considera todas viagens feitas por bicicleta
# PESS_MODO_APE considera todas viagens feitas a pé
# PESS_MODO_OUTROS considera todas viagens não contempladas pelas categorias anteriores

# PESS_NO_MODOS conta quantos modos diferentes fora utilizados, por viagem, de acordo com estas 8 categorias

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MODO_ONIBUS
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MODO_ONIBUS) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MODO_ONIBUS = sum(VIAG_MODO_ONIBUS), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MODO_ONIBUS=NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MODO_ONIBUS), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MODO_DIRIG 
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MODO_DIRIG ) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MODO_DIRIG = sum(VIAG_MODO_DIRIG), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MODO_DIRIG =NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MODO_DIRIG), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MODO_PASS 
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MODO_PASS ) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MODO_PASS = sum(VIAG_MODO_PASS), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MODO_PASS =NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MODO_PASS), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MODO_TREM 
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MODO_TREM ) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MODO_TREM = sum(VIAG_MODO_TREM), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MODO_TREM =NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MODO_TREM), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MODO_MOTO 
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MODO_MOTO ) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MODO_MOTO = sum(VIAG_MODO_MOTO), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MODO_MOTO =NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MODO_MOTO), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MODO_BICI 
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MODO_BICI ) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MODO_BICI = sum(VIAG_MODO_BICI), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MODO_BICI =NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MODO_BICI), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MODO_APE 
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MODO_APE ) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MODO_APE = sum(VIAG_MODO_APE), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MODO_APE =NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MODO_APE), by = 'ID_PESS')

# Usando variável auxiliar AUX1 para agrupar por pessoa e fazer somatório de VIAG_MODO_OUTROS 
AUX1 <- od %>% select(ANO, F_PESS, ID_PESS, VIAG_MODO_OUTROS ) %>% 
  group_by(ID_PESS) %>% 
  summarise(PESS_MODO_OUTROS = sum(VIAG_MODO_OUTROS), ANO = unique(ANO))

# Unindo resultado da variável AUX1 no dataframe od original
od$PESS_MODO_OUTROS =NULL
od <- left_join(od, select(AUX1, ID_PESS, PESS_MODO_OUTROS), by = 'ID_PESS')

od$PESS_NO_MODOS = 0
od <- od  %>%  
  # Analisando PESS_NO_MODOS
  mutate(PESS_NO_MODOS=ifelse(
    (PESS_MODO_ONIBUS!=0)
    ,
    PESS_NO_MODOS+1,
    PESS_NO_MODOS
  )) %>%
  mutate(PESS_NO_MODOS=ifelse(
    (PESS_MODO_DIRIG!=0)
    ,
    PESS_NO_MODOS+1,
    PESS_NO_MODOS
  )) %>%
  mutate(PESS_NO_MODOS=ifelse(
    (PESS_MODO_PASS!=0)
    ,
    PESS_NO_MODOS+1,
    PESS_NO_MODOS
  )) %>%  
  mutate(PESS_NO_MODOS=ifelse(
    (PESS_MODO_TREM!=0)
    ,
    PESS_NO_MODOS+1,
    PESS_NO_MODOS
  )) %>%    
  mutate(PESS_NO_MODOS=ifelse(
    (PESS_MODO_MOTO!=0)
    ,
    PESS_NO_MODOS+1,
    PESS_NO_MODOS
  )) %>%    
  mutate(PESS_NO_MODOS=ifelse(
    (PESS_MODO_BICI!=0)
    ,
    PESS_NO_MODOS+1,
    PESS_NO_MODOS
  )) %>%    
  mutate(PESS_NO_MODOS=ifelse(
    (PESS_MODO_APE!=0)
    ,
    PESS_NO_MODOS+1,
    PESS_NO_MODOS
  )) %>%    
  mutate(PESS_NO_MODOS=ifelse(
    (PESS_MODO_OUTROS!=0)
    ,
    PESS_NO_MODOS+1,
    PESS_NO_MODOS
  ))



