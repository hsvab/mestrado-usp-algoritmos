# Criando uma nova variável com faixas etárias, seguindo a classificação do IBGE
# Faixas Etárias:
# valor | label
# 0 -> 0 a 4 anos
# 1 -> 5 a 9 anos
# 2 -> 10 a 14 anos
# 3 -> 15 a 19 anos
# 4 -> 20 a 24 anos
# 5 -> 25 a 29 anos
# 6 -> 30 a 39 anos
# 7 -> 40 a 44 anos
# 8 -> 45 a 49 anos
# 9 -> 50 a 54 anos
# 10 -> 55 a 59 anos
# 11 -> 60 a 64 anos
# 12 -> 65 a 69 anos
# 13 -> 70 a 74 anos
# 14 -> 75 a 79 anos
# 15 -> 80 a 84 anos
# 16 -> 85 a 89 anos
# 17 -> 90 a 94 anos
# 18 -> 95 a 99 anos
# 19 -> mais de 100 anos
LABELS_FAIXAS_ETARIAS <- c('0 a 4 anos',
                          '5 a 9 anos',
                          '10 a 14 anos',
                          '15 a 19 anos',
                          '20 a 24 anos',
                          '25 a 29 anos',
                          '30 a 34 anos',
                          '35 a 39 anos',
                          '40 a 44 anos',
                          '45 a 49 anos',
                          '50 a 54 anos',
                          '55 a 59 anos',
                          '60 a 64 anos',
                          '65 a 69 anos',
                          '70 a 74 anos',
                          '75 a 79 anos',
                          '80 a 84 anos',
                          '85 a 89 anos',
                          '90 a 94 anos',
                          '95 a 99 anos',
                          'mais de 100 anos')
LEVELS_FAIXAS_ETARIAS <- c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,30)

od <- od  %>%
    #Inicializando a variável FAIXA_ETARIA
    mutate(FAIXA_ETARIA=99) %>%
    mutate(FAIXA_ETARIA=factor(FAIXA_ETARIA,
                               levels=LEVELS_FAIXAS_ETARIAS,
                               labels=LABELS_FAIXAS_ETARIAS)) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=0 | IDADE <=4,
        0,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=5 | IDADE <=9,
        1,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=10 | IDADE <=14,
        2,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=15 | IDADE <=19,
        3,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=20 | IDADE <=24,
        4,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=25 | IDADE <=29,
        5,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=30 | IDADE <=34,
        6,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=35 | IDADE <=39,
        7,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=40 | IDADE <=44,
        8,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=45 | IDADE <=49,
        9,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=50 | IDADE <=54,
        10,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=55 | IDADE <=59,
        11,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=60 | IDADE <=64,
        12,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=65 | IDADE <=69,
        13,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=70 | IDADE <=74,
        14,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=75 | IDADE <=79,
        15,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=80 | IDADE <=84,
        16,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=85 | IDADE <=89,
        17,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=90 | IDADE <=94,
        18,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE >=95 | IDADE <=99,
        19,
        FAIXA_ETARIA
    )) %>%
    mutate(FAIXA_ETARIA=ifelse(
        IDADE > 99,
        20,
        FAIXA_ETARIA
    ))