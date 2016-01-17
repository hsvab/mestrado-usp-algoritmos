od97_original <- fread('../../bases/bancos-separados/OD_1997_consolidado.csv',
                      sep=';', dec=',', header=TRUE,
                      colClasses = c(
                        'ID_PESS'='character',
                        'ID_VIAG'='character',
                        'ID_DOM'='character',
                        'ID_FAM'='character')
                      ) %>% as.data.frame()

od97 <- od97_original

# Criando variável temporária com ID de cada linha
od97$ID_ORIGINAL <- row.names(od97)

# Criando variável temporária para ajudar a remover registros inválidos
od97$REMOVER <- FALSE

######
## Correções de dados incorretos
od97[6763,'REMOVER'] = TRUE
od97[171984,'REMOVER'] = TRUE
od97[171986,'REMOVER'] = TRUE
od97[90388,'REMOVER'] = TRUE
od97[90390,'REMOVER'] = TRUE
od97[171916,'REMOVER'] = TRUE
od97[171918,'REMOVER'] = TRUE

# Removendo registros marcados para remoção
od97 <- od97 %>% filter(REMOVER==FALSE)

######
## Exluindo variável temporária já utilizada
od97$REMOVER <- NULL

od97$ID_CONSOLIDADO_01 <- row.names(od97)

od97_consolidado_01 <- od97

write.table(od97_consolidado_01, file='od_1997_consolidado_01_v2.csv',
            row.names=FALSE, sep=';', dec=',')

# Passando consolidado_01 pelo ipython notebook

od97_processado_01 <- fread('od_1997_processado_01_v2.csv',
                            sep=';', dec=',', header=TRUE,
                            colClasses = c(
                              'ID_PESS'='character',
                              'ID_VIAG'='character',
                              'ID_DOM'='character',
                              'ID_FAM'='character')
) %>% as.data.frame()

od97_processado_01$ID_PROC_01 <- row.names(od97_processado_01)
od97_processado_01$ID_ORIGINAL <- od97_consolidado_01$ID_ORIGINAL

casos97 <- od97_processado_01 %>% group_by(ID_PESS) %>%
  summarise(
    ID_FAM=unique(ID_FAM),
    idades=length(unique(IDADE)),
    sit_fams=length(unique(SIT_FAM)),
    sexos=length(unique(SEXO)),
    ID_de_troca=max(ID_PROC_01)
  ) %>%
  filter( idades>1 | sexos>1 | sit_fams>1 ) %>%
  ungroup()

# ids.originais.com.problema <- od97_processado %>%
#                     filter(ID_PROC %in% casos.com.mais.de.uma.idade$ID_de_troca) %>%
#                     select(ID_ORIGINAL)

od97_consolidado_02 <- od97_consolidado_01

# Trocando linhas claramente invertidas
for( linha in casos.com.mais.de.uma.idade$ID_de_troca ) {
  od97_consolidado_02 <- troca_linhas(od97_consolidado_02, linha)
}

od97_consolidado_02$ID_CONSOLIDADO_02 <- row.names(od97_consolidado_02)

write.table(od97_consolidado_02, file='od_1997_consolidado_02.csv',
            row.names=FALSE, sep=';', dec=',')

# Passando consolidado_02 pelo ipython notebook

od97_processado_02 <- fread('od_1997_processado_02_v3.csv',
                          sep=';', dec=',', header=TRUE,
                          colClasses = c(
                            'ID_PESS'='character',
                            'ID_VIAG'='character',
                            'ID_DOM'='character',
                            'ID_FAM'='character')
) %>% as.data.frame()

all.equal(select(od97_processado_02,FE_DOM,IDADE,H_CHEG,F_PESS), select(od97_consolidado_02,FE_DOM,IDADE,H_CHEG,F_PESS))

od97_processado_02$ID_PROC_02 <- row.names(od97_processado_02)
od97_processado_02$ID_ORIGINAL <- od97_consolidado_02$ID_ORIGINAL

casos.com.mais.de.uma.idade.02 <- od97_processado_02 %>% group_by(ID_PESS) %>%
  summarise(
    ID_FAM=unique(ID_FAM),
    idades=length(unique(IDADE)),
    sit_fams=length(unique(SIT_FAM)),
    sexos=length(unique(SEXO)),
    ID_de_troca=max(ID_PROC_02)
  ) %>%
  filter( idades>1 | sexos>1 | sit_fams>1 ) %>%
  ungroup()





















































troca_linhas <- function(df, linhaA, linhaB=NULL) {
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

resumo.original <- function(df, linhaInicio, linhaFim=NULL) {
  if ( !is.null(linhaFim) ) {
    df[as.integer(linhaInicio):as.integer(linhaFim), c('ID_DOM','F_DOM','FE_DOM','ID_FAM','F_FAM','FE_FAM','REN_FAM','ID_PESS','F_PESS','FE_PESS','IDADE','SEXO','SIT_FAM','REN_IND','ID_VIAG','F_VIAG','FE_VIAG','DURACAO','H_SAIDA','MIN_SAIDA', 'H_CHEG','MIN_CHEG')]
  } else {
    df[as.integer(linhaInicio), c('ID_DOM','F_DOM','FE_DOM','ID_FAM','F_FAM','FE_FAM','REN_FAM','ID_PESS','F_PESS','FE_PESS','IDADE','SEXO','SIT_FAM','REN_IND','ID_VIAG','F_VIAG','FE_VIAG','DURACAO','H_SAIDA','MIN_SAIDA', 'H_CHEG','MIN_CHEG')]
  }
}
resumo.limpo <- function(df, linhaInicio, linhaFim=NULL) {
  if ( !is.null(linhaFim) ) {
    df[as.integer(linhaInicio):as.integer(linhaFim), c('ID_DOM','F_DOM','FE_DOM','ID_FAM','F_FAM','FE_FAM','REN_FAM','ID_PESS','F_PESS','FE_PESS','IDADE','SEXO','SIT_FAM','REN_IND','ID_VIAG','F_VIAG','FE_VIAG','DURACAO','H_CHEG', 'ID_ORIGINAL','ID_NOVO')]
  } else {
    df[as.integer(linhaInicio), c('ID_DOM','F_DOM','FE_DOM','ID_FAM','F_FAM','FE_FAM','REN_FAM','ID_PESS','F_PESS','FE_PESS','IDADE','SEXO','SIT_FAM','REN_IND','ID_VIAG','F_VIAG','FE_VIAG','DURACAO','H_CHEG', 'ID_ORIGINAL','ID_NOVO')]
  }
}
resumo.processado <- function(df, linhaInicio, linhaFim=NULL) {
  if ( !is.null(linhaFim) ) {
    df[as.integer(linhaInicio):as.integer(linhaFim), c('ID_DOM','F_DOM','FE_DOM','ID_FAM','F_FAM','FE_FAM','REN_FAM','ID_PESS','F_PESS','FE_PESS','IDADE','SEXO','SIT_FAM','REN_IND','ID_VIAG','F_VIAG','FE_VIAG','DURACAO','H_CHEG')]
  } else {
    df[as.integer(linhaInicio), c('ID_DOM','F_DOM','FE_DOM','ID_FAM','F_FAM','FE_FAM','REN_FAM','ID_PESS','F_PESS','FE_PESS','IDADE','SEXO','SIT_FAM','REN_IND','ID_VIAG','F_VIAG','FE_VIAG','DURACAO','H_CHEG')]
  }
}
