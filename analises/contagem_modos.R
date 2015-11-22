# Criando novas variaveis com contagem da utilização dos modos, por viagem
# 
# 0 -> não fez viagem
# VIAG_MODO_ONIBUS considera todas viagens feitas por ônibus de linha (municipal ou
# intermuniciapl), ônibus escolar, ônibus de empersa, lotação e van
# VIAG_MODO_DIRIG considera todas viagens feitas por automóvel com a pessoa dirigindo
# VIAG_MODO_PASS considera todas viagens feitas por automóvel com a pessoa como passageiro,
# incluindo as viagens de táxi
# VIAG_MODO_TREM considera todas viagens feitas por metrô ou trem
# VIAG_MODO_MOTO considera todas viagens feitas por motocicleta
# VIAG_MODO_BICI considera todas viagens feitas por bicicleta
# VIAG_MODO_APE considera todas viagens feitas a pé
# VIAG_MODO_OUTROS considera todas viagens não contempladas pelas categorias anteriores
# VIAG_NO_MODOS conta quantos modos diferentes fora utilizados, por viagem, de acordo com estas 8 categorias

od <- od  %>%
  
  # Inicializando as variáveis de MODO para VIAGENS
  mutate(VIAG_MODO_ONIBUS=0) %>%
  mutate(VIAG_MODO_DIRIG=0) %>%
  mutate(VIAG_MODO_PASS=0) %>%
  mutate(VIAG_MODO_TREM=0) %>%
  mutate(VIAG_MODO_MOTO=0) %>%
  mutate(VIAG_MODO_BICI=0) %>%
  mutate(VIAG_MODO_APE=0) %>%
  mutate(VIAG_MODO_OUTROS=0) %>%
  mutate(VIAG_NO_MODOS=0)

od <- od  %>%
  # Analisando VIAG_MODO_ONIBUS
  mutate(VIAG_MODO_ONIBUS=ifelse(
    (MODO1==1 | MODO1==2 | MODO1==6) & !is.na(MODO1)
    ,
    VIAG_MODO_ONIBUS+1,
    VIAG_MODO_ONIBUS
  )) %>%
  mutate(VIAG_MODO_ONIBUS=ifelse(
    (MODO2==1 | MODO2==2 | MODO2==6) & !is.na(MODO2)
    ,
    VIAG_MODO_ONIBUS+1,
    VIAG_MODO_ONIBUS
  )) %>%  
  mutate(VIAG_MODO_ONIBUS=ifelse(
    (MODO3==1 | MODO3==2 | MODO3==6) & !is.na(MODO3)
    ,
    VIAG_MODO_ONIBUS+1,
    VIAG_MODO_ONIBUS
  )) %>%  
  mutate(VIAG_MODO_ONIBUS=ifelse(
    (MODO4==1 | MODO4==2 | MODO4==6) & !is.na(MODO4)
    ,
    VIAG_MODO_ONIBUS+1,
    VIAG_MODO_ONIBUS
  )) 

od <- od  %>%
  # Analisando VIAG_MODO_DIRIG
  mutate(VIAG_MODO_DIRIG=ifelse(
    (MODO1==3) & !is.na(MODO1)
    ,
    VIAG_MODO_DIRIG+1,
    VIAG_MODO_DIRIG
  )) %>%
  mutate(VIAG_MODO_DIRIG=ifelse(
    (MODO2==3) & !is.na(MODO2)
    ,
    VIAG_MODO_DIRIG+1,
    VIAG_MODO_DIRIG
  )) %>%  
  mutate(VIAG_MODO_DIRIG=ifelse(
    (MODO3==3) & !is.na(MODO3)
    ,
    VIAG_MODO_DIRIG+1,
    VIAG_MODO_DIRIG
  )) %>%  
  mutate(VIAG_MODO_DIRIG=ifelse(
    (MODO4==3) & !is.na(MODO4)
    ,
    VIAG_MODO_DIRIG+1,
    VIAG_MODO_DIRIG
  ))

od <- od  %>%  
  # Analisando VIAG_MODO_PASS
  mutate(VIAG_MODO_PASS=ifelse(
    (MODO1==4 | MODO1==5) & !is.na(MODO1)
    ,
    VIAG_MODO_PASS+1,
    VIAG_MODO_PASS
  )) %>%
  mutate(VIAG_MODO_PASS=ifelse(
    (MODO2==4 | MODO2==5) & !is.na(MODO2)
    ,
    VIAG_MODO_PASS+1,
    VIAG_MODO_PASS
  )) %>%  
  mutate(VIAG_MODO_PASS=ifelse(
    (MODO3==4 | MODO3==5) & !is.na(MODO3)
    ,
    VIAG_MODO_PASS+1,
    VIAG_MODO_PASS
  )) %>%  
  mutate(VIAG_MODO_PASS=ifelse(
    (MODO4==4 | MODO4==5) & !is.na(MODO4)
    ,
    VIAG_MODO_PASS+1,
    VIAG_MODO_PASS
  ))

od <- od  %>%  
  # Analisando VIAG_MODO_TREM
  mutate(VIAG_MODO_TREM=ifelse(
    (MODO1==7 | MODO1==8) & !is.na(MODO1)
    ,
    VIAG_MODO_TREM+1,
    VIAG_MODO_TREM
  )) %>%
  mutate(VIAG_MODO_TREM=ifelse(
    (MODO2==7 | MODO2==8) & !is.na(MODO2)
    ,
    VIAG_MODO_TREM+1,
    VIAG_MODO_TREM
  )) %>%  
  mutate(VIAG_MODO_TREM=ifelse(
    (MODO3==7 | MODO3==8) & !is.na(MODO3)
    ,
    VIAG_MODO_TREM+1,
    VIAG_MODO_TREM
  )) %>%  
  mutate(VIAG_MODO_TREM=ifelse(
    (MODO4==7 | MODO4==8) & !is.na(MODO4)
    ,
    VIAG_MODO_TREM+1,
    VIAG_MODO_TREM
  ))

od <- od  %>%  
  # Analisando VIAG_MODO_MOTO
  mutate(VIAG_MODO_MOTO=ifelse(
    (MODO1==9) & !is.na(MODO1)
    ,
    VIAG_MODO_MOTO+1,
    VIAG_MODO_MOTO
  )) %>%
  mutate(VIAG_MODO_MOTO=ifelse(
    (MODO2==9) & !is.na(MODO2)
    ,
    VIAG_MODO_MOTO+1,
    VIAG_MODO_MOTO
  )) %>%  
  mutate(VIAG_MODO_MOTO=ifelse(
    (MODO3==9) & !is.na(MODO3)
    ,
    VIAG_MODO_MOTO+1,
    VIAG_MODO_MOTO
  )) %>%  
  mutate(VIAG_MODO_MOTO=ifelse(
    (MODO4==9) & !is.na(MODO4)
    ,
    VIAG_MODO_MOTO+1,
    VIAG_MODO_MOTO
  ))

od <- od  %>%
  # Analisando VIAG_MODO_BICI
  mutate(VIAG_MODO_BICI=ifelse(
    (MODO1==10) & !is.na(MODO1)
    ,
    VIAG_MODO_BICI+1,
    VIAG_MODO_BICI
  )) %>%
  mutate(VIAG_MODO_BICI=ifelse(
    (MODO2==10) & !is.na(MODO2)
    ,
    VIAG_MODO_BICI+1,
    VIAG_MODO_BICI
  )) %>%  
  mutate(VIAG_MODO_BICI=ifelse(
    (MODO3==10) & !is.na(MODO3)
    ,
    VIAG_MODO_BICI+1,
    VIAG_MODO_BICI
  )) %>%  
  mutate(VIAG_MODO_BICI=ifelse(
    (MODO4==10) & !is.na(MODO4)
    ,
    VIAG_MODO_BICI+1,
    VIAG_MODO_BICI
  ))

od <- od  %>%  
  # Analisando VIAG_MODO_APE
  mutate(VIAG_MODO_APE=ifelse(
    (MODO1==11) & !is.na(MODO1)
    ,
    VIAG_MODO_APE+1,
    VIAG_MODO_APE
  )) %>%
  mutate(VIAG_MODO_APE=ifelse(
    (MODO2==11) & !is.na(MODO2)
    ,
    VIAG_MODO_APE+1,
    VIAG_MODO_APE
  )) %>%  
  mutate(VIAG_MODO_APE=ifelse(
    (MODO3==11) & !is.na(MODO3)
    ,
    VIAG_MODO_APE+1,
    VIAG_MODO_APE
  )) %>%  
  mutate(VIAG_MODO_APE=ifelse(
    (MODO4==11) & !is.na(MODO4)
    ,
    VIAG_MODO_APE+1,
    VIAG_MODO_APE
  ))

od <- od  %>%  
  # Analisando VIAG_MODO_OUTROS
  mutate(VIAG_MODO_OUTROS=ifelse(
    (MODO1==12) & !is.na(MODO1)
    ,
    VIAG_MODO_OUTROS+1,
    VIAG_MODO_OUTROS
  )) %>%
  mutate(VIAG_MODO_OUTROS=ifelse(
    (MODO2==12) & !is.na(MODO2)
    ,
    VIAG_MODO_OUTROS+1,
    VIAG_MODO_OUTROS
  )) %>%  
  mutate(VIAG_MODO_OUTROS=ifelse(
    (MODO3==12) & !is.na(MODO3)
    ,
    VIAG_MODO_OUTROS+1,
    VIAG_MODO_OUTROS
  )) %>%  
  mutate(VIAG_MODO_OUTROS=ifelse(
    (MODO4==12) & !is.na(MODO4)
    ,
    VIAG_MODO_OUTROS+1,
    VIAG_MODO_OUTROS
  ))


od <- od  %>%  
  # Analisando VIAG_NO_MODOS
  mutate(VIAG_NO_MODOS=ifelse(
    (VIAG_MODO_ONIBUS!=0)
    ,
    VIAG_NO_MODOS+1,
    VIAG_NO_MODOS
  )) %>%
  mutate(VIAG_NO_MODOS=ifelse(
    (VIAG_MODO_DIRIG!=0)
    ,
    VIAG_NO_MODOS+1,
    VIAG_NO_MODOS
  )) %>%
  mutate(VIAG_NO_MODOS=ifelse(
    (VIAG_MODO_PASS!=0)
    ,
    VIAG_NO_MODOS+1,
    VIAG_NO_MODOS
  )) %>%  
  mutate(VIAG_NO_MODOS=ifelse(
    (VIAG_MODO_TREM!=0)
    ,
    VIAG_NO_MODOS+1,
    VIAG_NO_MODOS
  )) %>%    
  mutate(VIAG_NO_MODOS=ifelse(
    (VIAG_MODO_MOTO!=0)
    ,
    VIAG_NO_MODOS+1,
    VIAG_NO_MODOS
  )) %>%    
  mutate(VIAG_NO_MODOS=ifelse(
    (VIAG_MODO_BICI!=0)
    ,
    VIAG_NO_MODOS+1,
    VIAG_NO_MODOS
  )) %>%    
  mutate(VIAG_NO_MODOS=ifelse(
    (VIAG_MODO_APE!=0)
    ,
    VIAG_NO_MODOS+1,
    VIAG_NO_MODOS
  )) %>%    
  mutate(VIAG_NO_MODOS=ifelse(
    (VIAG_MODO_OUTROS!=0)
    ,
    VIAG_NO_MODOS+1,
    VIAG_NO_MODOS
  ))
