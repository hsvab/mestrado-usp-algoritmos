troca.linhas <- function(df, linhaA, linhaB=NULL) {
  # Troca a linhaA com a linha seguinte
  # e retorna o dataframe modificado
  linhaA = as.integer(linhaA)
  if (is.null(linhaB)) {
    linhaB = as.integer(linhaA) + 1
  }
  tempA <- df[linhaA,]
  tempB <- df[linhaB,]
  df[linhaA,] <- tempB
  df[linhaB,] <- tempA
  return(df)
}

od77_original <- fread(file.path(
                            .dirBasesSeparadas,
                            'od_1977_consolidado_v0.csv'
                      ),
                      sep=';', dec=',', header=TRUE, data.table = FALSE,
                      colClasses = c(
                        'ID_PESS'='character',
                        'ID_VIAG'='character',
                        'ID_DOM'='character',
                        'ID_FAM'='character')
                      )

od77 <- od77_original

# Criando variável temporária com ID de cada linha
od77$ID_ORIGINAL <- row.names(od77)

# Criando variável temporária para ajudar a remover registros inválidos
od77$REMOVER <- FALSE

######
## Correções de dados incorretos

# od77 %>% filter(FE_FAM==55.53,
#                 round(REN_FAM,2)==round(1393.32/0.422345901,2),
#                 IDADE==19)
#Alterar F_DOM para 1 e F_FAM para 1
od77[7070,'SIT_FAM'] = 1
od77[7070,'SEXO'] = 1

# od77 %>% filter(ID_DOM==6930005060401)
# od77 %>% mutate(F_FAM = ifelse( ID_DOM==6930005060401 & H_CHEG==8,
#                                 1,
#                                 F_FAM)) %>%
#          mutate(F_FAM = ifelse( ID_DOM==6930005060401 & H_CHEG==9,
#                                 0,
#                                 F_FAM))
od77[59702,'F_FAM'] = 1
od77[59703,'F_FAM'] = 0

# od77 %>% filter(FE_FAM==48.75,
#                 round(REN_FAM,2)==round(9129.85/0.422345901,2),
#                 SEXO==0)
# Alterar SEXO para 1 e SIT_FAM para 1
od77[80135,'SEXO'] = 1
od77[80135,'SIT_FAM'] = 1

# Atribuir 1 em F_DOM
od77[90307,'F_DOM'] = 1

# od77_original %>% filter( FE_DOM==10,
#                           round(REN_IND,2)==round(451.91/0.422345901,2),
#                           IDADE==66)
# Atribuir 1 a F_DOM
od77[117516,'F_DOM'] = 1

# od77 %>% filter(ID_DOM == 16720011030101)
# Atribuir 1 a F_PESS
od77[156883,'F_PESS'] = 1

# Correção de SIT_FAM e IDADE
od77[189592,'SIT_FAM'] = 1
od77[189592,'IDADE'] = 46

######
### Trocas de linhas

# Trocar as duas linhas
od77 <- troca.linhas(od77, 29736)

# Trocar as duas linhas
od77 <- troca.linhas(od77, 111595)

# Trocar as duas linhas
od77 <- troca.linhas(od77, 180455, 180453)

# Trocar as duas linhas
od77 <- troca.linhas(od77, 210077)

od77 <- troca.linhas(od77, 79488)

## Corrigindo familias embaralhadas
## As trocas devem ocorrer na exata ordem que está abaixo
od77 <- troca.linhas(od77,79458 )
od77 <- troca.linhas(od77,79457 )
od77 <- troca.linhas(od77,79460 )
od77 <- troca.linhas(od77,79459 )
od77 <- troca.linhas(od77,79458 )
od77 <- troca.linhas(od77,79462 )
od77 <- troca.linhas(od77,79461 )
od77 <- troca.linhas(od77,79460 )
od77 <- troca.linhas(od77,79459 )
od77 <- troca.linhas(od77,79463 )
od77 <- troca.linhas(od77,79462 )
od77 <- troca.linhas(od77,79461 )
od77 <- troca.linhas(od77,79460 )
od77 <- troca.linhas(od77,79477 )
od77 <- troca.linhas(od77,79479 )
od77 <- troca.linhas(od77,79478 )
od77 <- troca.linhas(od77,79480 )
od77 <- troca.linhas(od77,79479 )
od77 <- troca.linhas(od77,79482 )
od77 <- troca.linhas(od77,79481 )
od77 <- troca.linhas(od77,79480 )
od77 <- troca.linhas(od77,79483 )
od77 <- troca.linhas(od77,79482 )
od77 <- troca.linhas(od77,79481 )
od77 <- troca.linhas(od77,79458 )
od77 <- troca.linhas(od77,79469 )
od77$ID_ANTES_DE_REMOVER <- row.names(od77)

######
## Linhas a serem removidas

# od77_original %>% filter( FE_DOM==27.41,
#                           round(REN_FAM,1)==round(1393.32/0.422345901,1))
# APAGAR todos os 5 registros
od77[21618:21622,'REMOVER'] = TRUE

# od77 %>% filter(FE_FAM==20.7,
#                 round(REN_FAM,2)==round(1882.82/0.422345901,2),
#                 COND_MORA==5,
#                 SUBZONA_DOM==88)
# Excluir todos os 6 registros
od77[111969:111974,'REMOVER'] = TRUE

# od77 %>% filter(FE_FAM==30.75,
#                 round(REN_FAM,2)==round(0/0.422345901,2))
# Excluir todos os 5 registros
od77[114451:114455,'REMOVER'] = TRUE

# od77 %>% filter(FE_FAM==1.18,
#                 round(REN_FAM,2)==round(0/0.422345901,2))
# Excluir todos os registros
od77[142706:142709,'REMOVER'] = TRUE

# Marcando para remoção os registros com
# sexo NA ou sexo igual a zero
od77 <- od77 %>% mutate(REMOVER=ifelse(
                    is.na(SEXO) | SEXO==0,
                    TRUE,
                    REMOVER
                )
              )

# Removendo registros marcados para remoção
od77 <- od77 %>% filter(REMOVER==FALSE)

######
## Exluindo variável temporária já utilizada
od77$REMOVER <- NULL

od77$ID_CONSOLIDADO_01 <- row.names(od77)

od77_consolidado_01 <- od77

write.table(od77_consolidado_01, file=file.path(.dirBasesSeparadas,
                                             'od_1977_consolidado_v1.csv'),
            row.names=FALSE, sep=';', dec=',')

# Passando consolidado_01 pelo ipython notebook

od77_processado_01 <- fread( file.path(.dirBasesSeparadas,
                                    'od_1977_processado_v1.csv'),
                          sep=';', dec=',', header=TRUE, data.table=FALSE,
                          colClasses = c(
                            'ID_PESS'='character',
                            'ID_VIAG'='character',
                            'ID_DOM'='character',
                            'ID_FAM'='character')
) %>% as.data.frame()

od77_processado_01$ID_PROC_01 <- row.names(od77_processado_01)
od77_processado_01$ID_CONSOLIDADO_01 <- od77_consolidado_01$ID_CONSOLIDADO_01
od77_processado_01$ID_ORIGINAL <- od77_consolidado_01$ID_ORIGINAL

casos.com.mais.de.uma.idade <- od77_processado_01 %>% group_by(ID_PESS) %>%
  summarise(
    ID_FAM=unique(ID_FAM),
    idades=length(unique(IDADE)),
    sit_fams=length(unique(SIT_FAM)),
    sexos=length(unique(SEXO)),
    ID_de_troca=max(ID_PROC_01)
  ) %>%
  filter( idades>1 | sexos>1 | sit_fams>1 ) %>%
  ungroup()

od77_consolidado_02 <- od77_consolidado_01

# Trocando linhas claramente invertidas
for( linha in casos.com.mais.de.uma.idade$ID_de_troca ) {
  od77_consolidado_02 <- troca.linhas(od77_consolidado_02, linha)
}

od77_consolidado_02$ID_CONSOLIDADO_02 <- row.names(od77_consolidado_02)

write.table(od77_consolidado_02, file=file.path(.dirBasesSeparadas,
                                             'od_1977_consolidado_v2.csv'),
            row.names=FALSE, sep=';', dec=',')

# Passando consolidado_02 pelo ipython notebook

od77_processado_02 <- fread(file.path(.dirBasesSeparadas,
                                   'od_1977_processado_v2.csv'),
                          sep=';', dec=',', header=TRUE, data.table=FALSE,
                          colClasses = c(
                            'ID_PESS'='character',
                            'ID_VIAG'='character',
                            'ID_DOM'='character',
                            'ID_FAM'='character')
                      )

all.equal(
  select(od77_processado_02,FE_DOM,IDADE,H_CHEG,F_PESS),
  select(od77_consolidado_02,FE_DOM,IDADE,H_CHEG,F_PESS)
)

od77_processado_02$ID_PROC_02 <- row.names(od77_processado_02)
od77_processado_02$ID_ORIGINAL <- od77_consolidado_02$ID_ORIGINAL

casos.com.mais.de.uma.idade.02 <- od77_processado_02 %>% group_by(ID_PESS) %>%
  summarise(
    ID_FAM=unique(ID_FAM),
    idades=length(unique(IDADE)),
    sit_fams=length(unique(SIT_FAM)),
    sexos=length(unique(SEXO)),
    ID_de_troca=max(ID_PROC_02)
  ) %>%
  filter( idades>1 | sexos>1 | sit_fams>1 ) %>%
  ungroup()
