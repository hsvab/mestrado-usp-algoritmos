# Criando uma nova variável com faixas de salários mínimos, seguindo a classificação do IBGE para as classes econômicas (em 2007)
# Valores para Salários mínimos do DIEESE: http://www.dieese.org.br/anuario/2001/3/pg48-50.pdf
# Lei do salário mínimo de 1997: https://www.planalto.gov.br/ccivil_03/Leis/L9971.htm
# Lei do salário mínimo de 2007: https://www.planalto.gov.br/ccivil_03/_Ato2007-2010/2007/Lei/L11498.htm
# Definição de Classe Econômica – Fonte: http://www.sae.gov.br/wp-content/uploads/ebook_ClasseMedia1.pdf. 
# Relação entre a quantidade de Salários Mínimos e as classes econômicas (ABCDE): IBGE.
# 
# Faixas de Renda Familiar:
# valor & label
# 0 -> sem renda
# até R$760 (exclusive) -> Classe E (até 2 SM)
# de R$760 (inclusive) até R$1520 (exclusive) -> Classe D (de 2 a 4 SM)
# de R$1520 (inclusive) até R$3800 (exclusive) -> Classe C (de 4 a 10 SM)
# de R$3800 (inclusive) até R$7600 (exclusive) -> Classe B (de 10 a 20 SM)
# mais de R$7600 (inclusive) -> Classe A (mais de 20 SM)

SM <- 380
od <- od  %>%
  #Inicializando a variável FAIXA_REN_FAM
  mutate(FAIXA_REN_FAM=99) %>%
  mutate(FAIXA_REN_FAM=ifelse(
    REN_FAM ==0,
    0,
    FAIXA_REN_FAM
  )) %>%
  mutate(FAIXA_REN_FAM=ifelse(
    REN_FAM >0& REN_FAM <2*SM,
    1,
    FAIXA_REN_FAM
  )) %>%
  mutate(FAIXA_REN_FAM=ifelse(
    REN_FAM >=2*SM& REN_FAM <4*SM,
    2,
    FAIXA_REN_FAM
  )) %>%
  mutate(FAIXA_REN_FAM=ifelse(
    REN_FAM >=4*SM & REN_FAM <10*SM,
    3,
    FAIXA_REN_FAM
  )) %>%
  mutate(FAIXA_REN_FAM=ifelse(
    REN_FAM >=10*SM & REN_FAM <20*SM,
    4,
    FAIXA_REN_FAM
  )) %>%
  mutate(FAIXA_REN_FAM=ifelse(
    REN_FAM >=20*SM,
    5,
    FAIXA_REN_FAM
  ))

# Faixas de Renda Individual:
# valor & label
# 0 -> sem renda
# até R$380 (exclusive) -> até 1 SM
# de R$380 (inclusive) até R$760 (exclusive) -> de 1 a 2 SM
# de R$760 (inclusive) até R$1140 (exclusive) -> de 2 a 3 SM
# de R$1140 (inclusive) até R$1900 (exclusive) -> de 3 a 5 SM
# de R$1900 (inclusive) até R$3800 (exclusive) -> de 5 a 10 SM
# de R$3800 (inclusive) até R$5700 (exclusive) -> de 10 a 15 SM
# mais de R$5700 (inclusive) -> mais de 15 SM

od <- od  %>%
  #Inicializando a variável FAIXA_REN_IND
  mutate(FAIXA_REN_IND=99) %>%
  mutate(FAIXA_REN_IND=ifelse(
    REN_IND ==0,
    0,
    FAIXA_REN_IND
  )) %>%
  mutate(FAIXA_REN_IND=ifelse(
    REN_IND >0*SM& REN_IND <1*SM,
    1,
    FAIXA_REN_IND
      )) %>%
  mutate(FAIXA_REN_IND=ifelse(
    REN_IND >=1*SM& REN_IND <2*SM,
    2,
    FAIXA_REN_IND
  )) %>%
  mutate(FAIXA_REN_IND=ifelse(
    REN_IND >=2*SM & REN_IND <3*SM,
    3,
    FAIXA_REN_IND
  )) %>%
  mutate(FAIXA_REN_IND=ifelse(
    REN_IND >=3*SM & REN_IND <5*SM,
    4,
    FAIXA_REN_IND
  )) %>%
  mutate(FAIXA_REN_IND=ifelse(
    REN_IND >=5*SM & REN_IND <10*SM,
    5,
    FAIXA_REN_IND
  )) %>%
  mutate(FAIXA_REN_IND=ifelse(
    REN_IND >=10*SM & REN_IND <15*SM,
    6,
    FAIXA_REN_IND
  )) %>%
  mutate(FAIXA_REN_IND=ifelse(
    REN_IND >=15*SM,
    7,
    FAIXA_REN_IND
  ))