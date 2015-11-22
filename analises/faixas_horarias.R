# Criando uma nova variável com faixas horarias:
# Considerando horário de início da viagem + 50% da duração
# valor | label
# 0 -> não fez viagem
# 1 -> madrugada (entre 0h e 5:59h)
# 2 -> manhã (entre 6h e 11:59h)
# 3 -> tarde (entre 12h e 17:59h)
# 4 -> noitre (entre 18h e 23:59h)

od <- od  %>%
  #Inicializando a variável FAIXA_HORARIA
  mutate(FAIXA_HORARIA=0) %>%
  mutate(FAIXA_HORARIA=ifelse(
    ((H_SAIDA*60)+MIN_SAIDA +(DURACAO*0.5)) >=0 & ((H_SAIDA*60)+MIN_SAIDA +(DURACAO*0.5)) <360
    ,
    1,
    FAIXA_HORARIA
  )) %>%
  mutate(FAIXA_HORARIA=ifelse(
    ((H_SAIDA*60)+MIN_SAIDA +(DURACAO*0.5)) >=360 & ((H_SAIDA*60)+MIN_SAIDA +(DURACAO*0.5)) <720
    ,
    2,
    FAIXA_HORARIA
  )) %>%  
  mutate(FAIXA_HORARIA=ifelse(
    ((H_SAIDA*60)+MIN_SAIDA +(DURACAO*0.5)) >=720 & ((H_SAIDA*60)+MIN_SAIDA +(DURACAO*0.5)) <1080    
    ,
    3,
    FAIXA_HORARIA
  )) %>%  
  mutate(FAIXA_HORARIA=ifelse(
    ((H_SAIDA*60)+MIN_SAIDA +(DURACAO*0.5)) >=1080 & ((H_SAIDA*60)+MIN_SAIDA +(DURACAO*0.5)) <1440
    ,
    4,
    FAIXA_HORARIA
  )) %>%
  mutate(FAIXA_HORARIA=ifelse(
    DURACAO==0
    ,
    0,
    FAIXA_HORARIA
  ))