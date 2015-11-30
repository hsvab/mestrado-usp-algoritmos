# Criando uma nova variável com faixas horárias:
# Considerando horário de término da viagem (proxy para o inicio da atividade)
# valor | label
# 0 -> não fez viagem
# 1 -> madrugada (entre 0h01 e 5h00)
# 2 -> começo da manhã (entre 5h01 e 9h00)
# 3 -> manhã (entre 9h01 e 12h)
# 4 -> meio-dia tarde (entre 12h01 e 14h)
# 5 -> tarde (entre 14h01 e 17h)
# 6 -> começo da noite (17h01 e 22h)
# 7 -> noite (22h01 e 0h)

od <- od  %>%
  #Inicializando a variável FAIXA_HORARIA
  mutate(FAIXA_HORARIA=0) %>%
  mutate(FAIXA_HORARIA=ifelse(
    ((H_CHEG*60)+MIN_CHEG) >=0 & ((H_CHEG*60)+MIN_CHEG) <= 300
    ,
    1,
    FAIXA_HORARIA
  )) %>%
  mutate(FAIXA_HORARIA=ifelse(
    ((H_CHEG*60)+MIN_CHEG) >300 & ((H_CHEG*60)+MIN_CHEG) <= 540
    ,
    2,
    FAIXA_HORARIA
  )) %>%  
  mutate(FAIXA_HORARIA=ifelse(
    ((H_CHEG*60)+MIN_CHEG) >540 & ((H_CHEG*60)+MIN_CHEG) <= 720
    ,
    3,
    FAIXA_HORARIA
  )) %>%  
  mutate(FAIXA_HORARIA=ifelse(
    ((H_CHEG*60)+MIN_CHEG) >720 & ((H_CHEG*60)+MIN_CHEG) <= 840
    ,
    4,
    FAIXA_HORARIA
  )) %>%
  mutate(FAIXA_HORARIA=ifelse(
    ((H_CHEG*60)+MIN_CHEG) >840 & ((H_CHEG*60)+MIN_CHEG) <= 1020
    ,
    5,
    FAIXA_HORARIA
  )) %>%  
  mutate(FAIXA_HORARIA=ifelse(
    ((H_CHEG*60)+MIN_CHEG) >1020 & ((H_CHEG*60)+MIN_CHEG) <= 1320
    ,
    6,
    FAIXA_HORARIA
  )) %>%  
  mutate(FAIXA_HORARIA=ifelse(
    ((H_CHEG*60)+MIN_CHEG) >1320 & ((H_CHEG*60)+MIN_CHEG) <= 1440
    ,
    7,
    FAIXA_HORARIA
  )) %>%  
  mutate(FAIXA_HORARIA=ifelse(
    DURACAO==0
    ,
    0,
    FAIXA_HORARIA
  ))