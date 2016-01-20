# Criando novas variáveis com contagem (dummy) dos periodos (marcados pelo horário de chegada), por viagem
#
# 0 -> não fez viagem
# VIAG_PER_MADRUG é marcador da viagem que terminou entre 0h01 e 5h00
# VIAG_PER_COM_MAN é marcador da viagem que terminou entre 5h01 e 9h00
# VIAG_PER_MANHA é marcador da viagem que terminou entre 9h01 e 12h
# VIAG_PER_MEIODIA é marcador da viagem que terminou entre 12h01 e 14h
# VIAG_PER_TARDE é marcador da viagem que terminou entre 14h01 e 17h
# VIAG_PER_COM_NOI é marcador da viagem que terminou 17h01 e 22h
# VIAG_PER_NOITE é marcador da viagem que terminou 22h01 e 0h

od <- od  %>%

  # Inicializando as variáveis de PERIODO para VIAGENS
  mutate(VIAG_PER_MADRUG=0) %>%
  mutate(VIAG_PER_COM_MAN=0) %>%
  mutate(VIAG_PER_MANHA=0) %>%
  mutate(VIAG_PER_MEIODIA=0) %>%
  mutate(VIAG_PER_TARDE=0) %>%
  mutate(VIAG_PER_COM_NOI=0) %>%
  mutate(VIAG_PER_NOITE=0)

od <- od  %>%
  # Analisando VIAG_PER_MADRUG
  mutate(VIAG_PER_MADRUG=ifelse(
    (FAIXA_HORARIA==1 & !is.na(FAIXA_HORARIA)),
    VIAG_PER_MADRUG+1,
    VIAG_PER_MADRUG
  ))

od <- od  %>%
  # Analisando VIAG_PER_COM_MAN
  mutate(VIAG_PER_COM_MAN=ifelse(
    (FAIXA_HORARIA==2 & !is.na(FAIXA_HORARIA)),
    VIAG_PER_COM_MAN+1,
    VIAG_PER_COM_MAN
  ))

od <- od  %>%
  # Analisando VIAG_PER_MANHA
  mutate(VIAG_PER_MANHA=ifelse(
    (FAIXA_HORARIA==3 & !is.na(FAIXA_HORARIA)),
    VIAG_PER_MANHA+1,
    VIAG_PER_MANHA
  ))

od <- od  %>%
  # Analisando VIAG_PER_MEIODIA
  mutate(VIAG_PER_MEIODIA=ifelse(
    (FAIXA_HORARIA==4 & !is.na(FAIXA_HORARIA)),
    VIAG_PER_MEIODIA+1,
    VIAG_PER_MEIODIA
  ))

od <- od  %>%
  # Analisando VIAG_PER_TARDE
  mutate(VIAG_PER_TARDE=ifelse(
    (FAIXA_HORARIA==5 & !is.na(FAIXA_HORARIA)),
    VIAG_PER_TARDE+1,
    VIAG_PER_TARDE
  ))

od <- od  %>%
  # Analisando VIAG_PER_COM_NOI
  mutate(VIAG_PER_COM_NOI=ifelse(
    (FAIXA_HORARIA==6 & !is.na(FAIXA_HORARIA)),
    VIAG_PER_COM_NOI+1,
    VIAG_PER_COM_NOI
  ))

od <- od  %>%
  # Analisando VIAG_PER_NOITE
  mutate(VIAG_PER_NOITE=ifelse(
    (FAIXA_HORARIA==7 & !is.na(FAIXA_HORARIA)),
    VIAG_PER_NOITE+1,
    VIAG_PER_NOITE
  ))
