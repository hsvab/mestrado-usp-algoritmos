# Criando novas variáveis com contagem (dummy) dos motivos destino, por viagem
#
# 0 -> não fez viagem
# VIAG_MOTIVO_SERV_PAS é marcador da viagem cujo motivo é servir passageiro
# VIAG_MOTIVO_TRAB é marcador da viagem motivo destino trabalho (1 - indústria, 2 - comércio ou 3 - serviços)
# VIAG_MOTIVO_EDUC é marcador da viagem motivo destino educação (4 - educação)
# VIAG_MOTIVO_RES é marcador da viagem motivo destino residência (8 - residência)
# VIAG_MOTIVO_MANUT_COMPRAS é marcador da viagem motivo manutenção da casa (5 - compras) ou da família (6 - saúde)
# VIAG_MOTIVO_LAZER_OUTROS é marcador da viagem motivo destino lazer ou outros (7 - lazer e 9 - outros)

od <- od  %>%

  # Inicializando as variáveis de MOTIVO para VIAGENS
  mutate(VIAG_MOTIVO_SERV_PAS=0) %>%
  mutate(VIAG_MOTIVO_TRAB=0) %>%
  mutate(VIAG_MOTIVO_EDUC=0) %>%
  mutate(VIAG_MOTIVO_RES=0) %>%
  mutate(VIAG_MOTIVO_MANUT_COMPRAS=0) %>%
  mutate(VIAG_MOTIVO_LAZER_OUTROS=0)

od <- od  %>%
  # Analisando VIAG_MOTIVO_TRAB
  mutate(VIAG_MOTIVO_TRAB=ifelse(
    (MOTIVO_DEST==1 | MOTIVO_DEST==2 | MOTIVO_DEST==3) & !is.na(MOTIVO_DEST) & (SERV_PAS_DEST==0 | is.na(SERV_PAS_DEST))
    ,
    VIAG_MOTIVO_TRAB+1,
    VIAG_MOTIVO_TRAB
  ))

od <- od  %>%
  # Analisando VIAG_MOTIVO_EDUC
  mutate(VIAG_MOTIVO_EDUC=ifelse(
    (MOTIVO_DEST==4) & !is.na(MOTIVO_DEST) & (SERV_PAS_DEST==0 | is.na(SERV_PAS_DEST))
    ,
    VIAG_MOTIVO_EDUC+1,
    VIAG_MOTIVO_EDUC
  ))

od <- od  %>%
  # Analisando VIAG_MOTIVO_RES
  mutate(VIAG_MOTIVO_RES=ifelse(
    (MOTIVO_DEST==8) & !is.na(MOTIVO_DEST) & (SERV_PAS_DEST==0 | is.na(SERV_PAS_DEST))
    ,
    VIAG_MOTIVO_RES+1,
    VIAG_MOTIVO_RES
  ))

od <- od  %>%
  # Analisando MOTIVO_MANUT_COMPRAS
  mutate(VIAG_MOTIVO_MANUT_COMPRAS=ifelse(
    (MOTIVO_DEST==5 | MOTIVO_DEST==6) & !is.na(MOTIVO_DEST) & (SERV_PAS_DEST==0 | is.na(SERV_PAS_DEST))
    ,
    VIAG_MOTIVO_MANUT_COMPRAS+1,
    VIAG_MOTIVO_MANUT_COMPRAS
  ))

od <- od  %>%
  # Analisando VIAG_MOTIVO_LAZER_OUTROS
  mutate(VIAG_MOTIVO_LAZER_OUTROS=ifelse(
    (MOTIVO_DEST==7 | MOTIVO_DEST==9) & !is.na(MOTIVO_DEST) & (SERV_PAS_DEST==0 | is.na(SERV_PAS_DEST))
    ,
    VIAG_MOTIVO_LAZER_OUTROS+1,
    VIAG_MOTIVO_LAZER_OUTROS
  ))

od <- od  %>%
  # Analisando VIAG_MOTIVO_SERV_PAS
  mutate(VIAG_MOTIVO_SERV_PAS=ifelse(
    (SERV_PAS_DEST==1 & !is.na(SERV_PAS_DEST))
    ,
    VIAG_MOTIVO_SERV_PAS+1,
    VIAG_MOTIVO_SERV_PAS
  ))
