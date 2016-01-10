# Correção da variável SERV_PAS nos bancos de dados

od <- od  %>%
   mutate(SERV_PAS_ORIG=ifelse(
     ANO==2,
     NA,
     SERV_PAS_ORIG
   ))

od <- od  %>%
  mutate(SERV_PAS_DEST=ifelse(
    ANO==2,
    NA,
    SERV_PAS_DEST
  ))