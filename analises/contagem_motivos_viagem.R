# Criando novas variáveis com contagem (dummy) dos motivos destino, por viagem
# 
# 0 -> não fez viagem
# VIAG_MOTIVO_TRAB é marcador da viagem motivo destino trabalho (1 - indústria, 2 - comércio ou 3 - serviços)
# VIAG_MOTIVO_EDUC é marcador da viagem motivo destino educação (4 - educação)
# VIAG_MOTIVO_RES é marcador da viagem motivo destino residência (8 - residência)
# VIAG_MOTIVO_OUTROS é marcador da viagem motivo destino uotros (5 - compras, 6 - saúde, 7 - lazer, 9 - outros)

od <- od  %>%
  
  # Inicializando as variáveis de MOTIVO para VIAGENS
  mutate(VIAG_MOTIVO_TRAB=0) %>%
  mutate(VIAG_MOTIVO_EDUC=0) %>%
  mutate(VIAG_MOTIVO_RES=0) %>%
  mutate(VIAG_MOTIVO_OUTROS=0)
  
od <- od  %>%
  # Analisando VIAG_MOTIVO_TRAB
  mutate(VIAG_MOTIVO_TRAB=ifelse(
    (MOTIVO_DEST==1 | MOTIVO_DEST==2 | MOTIVO_DEST==3) & !is.na(MOTIVO_DEST)
    ,
    VIAG_MOTIVO_TRAB+1,
    VIAG_MOTIVO_TRAB
  )) 

od <- od  %>%
  # Analisando VIAG_MOTIVO_EDUC
  mutate(VIAG_MOTIVO_EDUC=ifelse(
    (MOTIVO_DEST==4) & !is.na(MOTIVO_DEST)
    ,
    VIAG_MOTIVO_EDUC+1,
    VIAG_MOTIVO_EDUC
  ))

od <- od  %>%
  # Analisando VIAG_MOTIVO_RES
  mutate(VIAG_MOTIVO_RES=ifelse(
    (MOTIVO_DEST==8) & !is.na(MOTIVO_DEST)
    ,
    VIAG_MOTIVO_RES+1,
    VIAG_MOTIVO_RES
  ))

od <- od  %>%
  # Analisando VIAG_MOTIVO_OUTROS
  mutate(VIAG_MOTIVO_OUTROS=ifelse(
    (MOTIVO_DEST==5 | MOTIVO_DEST==6 | MOTIVO_DEST==7 | MOTIVO_DEST==9) & !is.na(MOTIVO_DEST)
    ,
    VIAG_MOTIVO_OUTROS+1,
    VIAG_MOTIVO_OUTROS
  ))
