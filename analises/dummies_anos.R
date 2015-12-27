# Criando novas variaveis com marcação do ano, para posterior regressão linear
#
# Anos
# valor & label
# 1 -> 1977
# 2 -> 1987
# 3 -> 1997
# 4 -> 2007

library(dplyr)

od <- od  %>%
  
  # Inicializando as variáveis para cada FX etaria
  mutate(ANO_77=0) %>%
  mutate(ANO_87=0) %>%
  mutate(ANO_97=0) %>%
  mutate(ANO_07=0)

od <- od  %>%
  mutate(ANO_77 = ifelse(
    ANO==1,
    1,
    ANO_77
  ))

od <- od  %>%
  mutate(ANO_87 = ifelse(
    ANO==2,
    1,
    ANO_87
  ))

od <- od  %>%
  mutate(ANO_97 = ifelse(
    ANO==3,
    1,
    ANO_97
  ))

od <- od  %>%
  mutate(ANO_07 = ifelse(
    ANO==4,
    1,
    ANO_07
  ))