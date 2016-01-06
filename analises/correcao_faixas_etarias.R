# Corrigindo inconsistências nas idades#
#
# Idade será NA quando for homem ou mulher, chefe de família (SIT_FAM=1) e com idade até 10 anos (FX_ET_1)
#
od <- od  %>%
  mutate(IDADE=ifelse(
    SIT_FAM==1 & FX_ET_0==1,
    NA,
    IDADE
  ))
od <- od  %>%
  mutate(IDADE=ifelse(
    SIT_FAM==1 & FX_ET_1==1,
    NA,
    IDADE
  ))

# Idade será NA quando for homem ou mulher, cônjuge (SIT_FAM=2) e com idade até 10 anos (FX_ET_1)
#
od <- od  %>%
  mutate(IDADE=ifelse(
    SIT_FAM==2 & FX_ET_0==1,
    NA,
    IDADE
  ))
od <- od  %>%
  mutate(IDADE=ifelse(
    SIT_FAM==2 & FX_ET_1==1,
    NA,
    IDADE
  ))

# Corrigindo a variável FX_ET_0 e FX_ET_1 para 'falso' (=0) nos casos em que a idade for NA
#
od <- od  %>%
  mutate(FX_ET_0=ifelse(
    is.na(IDADE),
    0,
    FX_ET_0
  ))

od <- od  %>%
  mutate(FX_ET_1=ifelse(
    is.na(IDADE),
    0,
    FX_ET_1
  ))

# Corrigindo a variável FAIXA_ETARIA para NA nos casos em que a idade for NA
#
od <- od  %>%
  mutate(FAIXA_ETARIA=ifelse(
    is.na(IDADE),
    NA,
    FAIXA_ETARIA
  ))
