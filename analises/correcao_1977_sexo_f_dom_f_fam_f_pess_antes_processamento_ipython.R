od_cons <- read.table('../../mestrado-usp-ODs/bancos-separados/OD_1977_consolidado.csv.bz2', sep=';', dec=',', header=TRUE,
                 colClasses = c(
                     'ID_PESS'='character',
                     'ID_VIAG'='character',
                     'ID_DOM'='character',
                     'ID_FAM'='character')
)

od_cons$ID <- row.names(od_cons)

#od_cons %>% filter(FE_DOM==10, round(REN_IND,2)==round(451.91/0.422345901,2), IDADE==66)
#Atribuir 1 a F_DOM
od_cons[117516,'F_DOM'] = 1

#od_cons %>% filter(FE_FAM==48.75, round(REN_FAM,2)==round(9129.85/0.422345901,2), SEXO==0)
#Alterar SEXO para 1 e SIT_FAM para 1
od_cons[80135,'SEXO'] = 1
od_cons[80135,'SIT_FAM'] = 1

#od_cons %>% filter(FE_FAM==55.53, round(REN_FAM,2)==round(1393.32/0.422345901,2), IDADE==19)
#Alterar F_DOM para 1 e F_FAM para 1
od_cons[7071,'F_DOM'] = 1
od_cons[7071,'F_FAM'] = 1

# Atribuir 1 em F_DOM
od[90307,'F_DOM'] = 1

# Trocar as duas linhas
temp1 <- od_cons[180453,]
temp2 <- od_cons[180454,]
od_cons[180454,] <- temp1
od_cons[180453,] <- temp2

# Trocar as duas linhas
temp1 <- od_cons[111595,]
temp2 <- od_cons[111596,]
od_cons[111596,] <- temp1
od_cons[111595,] <- temp2

# Trocar as duas linhas
temp1 <- od_cons[210077,]
temp2 <- od_cons[210078,]
od_cons[210078,] <- temp1
od_cons[210077,] <- temp2

# Trocar as duas linhas
temp1 <- od_cons[29736,]
temp2 <- od_cons[29737,]
od_cons[29737,] <- temp1
od_cons[29736,] <- temp2

#Criando variável temporária para ajudar a remover registros inválidos
od_cons$REMOVER <- FALSE

#od_cons %>% filter(FE_DOM==27.41, round(REN_FAM,1)==round(1393.32/0.422345901,1))
# APAGAR todos os 5 registros
od_cons <- od_cons %>%
    mutate(REMOVER = ifelse(
        FE_DOM==27.41 &
        round(REN_FAM,1)==round(1393.32/0.422345901,1),
        TRUE,
        REMOVER
        )
    )

#od_cons %>% filter(FE_FAM==20.7, round(REN_FAM,2)==round(1882.82/0.422345901,2), COND_MORA==5, SUBZONA_DOM==88)
#Excluir todos os 6 registros
od_cons <- od_cons %>%
    mutate(REMOVER = ifelse(
            FE_DOM==20.7 &
            round(REN_FAM,2)==round(1882.82/0.422345901,2) &
            COND_MORA==5 &
            SUBZONA_DOM==88,
            TRUE,
            REMOVER
        )
    )

#od_cons %>% filter(FE_FAM==30.75, round(REN_FAM,2)==round(0/0.422345901,2))
#Excluir todos os 5 registros
od_cons <- od_cons %>%
    mutate(REMOVER = ifelse(
            FE_DOM==30.75 &
            round(REN_FAM,2)==round(0/0.422345901,2),
            TRUE,
            REMOVER
    )
    )

od_cons %>% filter(FE_FAM==1.18, round(REN_FAM,2)==round(0/0.422345901,2))
#Excluir todos os registros
od_cons <- od_cons %>%
    mutate(REMOVER = ifelse(
            FE_DOM==1.18 &
            round(REN_FAM,2)==round(0/0.422345901,2),
            TRUE,
            REMOVER
        )
    )

od_cons_limpo <- od_cons %>% filter(REMOVER==FALSE)

od_cons_limpo <- od_cons_limpo %>% filter(!is.na(SEXO) | SEXO!=0)

od_cons_limpo <- od_cons_limpo %>% filter(SEXO != 0)

od_cons_limpo$REMOVER <- NULL
od_cons_limpo$ID <- NULL

od_cons_limpo %>% filter(F_FAM==1, F_PESS==0)

od_cons_limpo %>% filter(ID_DOM==6930005060401)
od_cons_limpo %>% filter(ID_DOM==16720011030101)

od_cons_limpo <- od_cons_limpo %>% mutate(F_PESS = ifelse(ID_DOM==16720011030101, 1, F_PESS))

od_cons_limpo <- od_cons_limpo %>%
    mutate(F_DOM = ifelse(ID_DOM==6930005060401 & H_CHEG==8, 1, F_DOM)) %>%
    mutate(F_FAM = ifelse(ID_DOM==6930005060401 & H_CHEG==8, 1, F_FAM)) %>%
    mutate(F_FAM = ifelse(ID_DOM==6930005060401 & H_CHEG==9, 0, F_FAM))

write.csv(od_cons_limpo, file='od_1977_consolidado_limpo.csv', row.names=FALSE)
