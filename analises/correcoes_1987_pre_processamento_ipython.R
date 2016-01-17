od87_original <- fread('../../bases/bancos-separados/OD_1987_consolidado.csv',
                      sep=';', dec=',', header=TRUE,
                      colClasses = c(
                        'ID_PESS'='character',
                        'ID_VIAG'='character',
                        'ID_DOM'='character',
                        'ID_FAM'='character')
                  ) %>% as.data.frame()

od87 <- od87_original

# Criando variável temporária com ID de cada linha
od87$ID_ORIGINAL <- row.names(od87)

# Criando variável temporária para ajudar a remover registros inválidos
od87$REMOVER <- FALSE

######
## Correções de dados incorretos

# Removendo registros marcados para remoção
od87 <- od87 %>% filter(REMOVER==FALSE)

######
## Exluindo variável temporária já utilizada
od87$REMOVER <- NULL

od87$ID_CONSOLIDADO_01 <- row.names(od87)

od87_consolidado_01 <- od87

write.table(od87_consolidado_01, file='od_1987_consolidado_01.csv',
            row.names=FALSE, sep=';', dec=',')

# Passando consolidado_01 pelo ipython notebook

od87_processado_01 <- fread('../../bases/bancos-separados/OD_1987_processado.csv',
                            sep=';', dec=',', header=TRUE,
                            colClasses = c(
                              'ID_PESS'='character',
                              'ID_VIAG'='character',
                              'ID_DOM'='character',
                              'ID_FAM'='character')
) %>% as.data.frame()

od87_processado_01$ID_PROC_01 <- row.names(od87_processado_01)
od87_processado_01$ID_ORIGINAL <- od87_consolidado_01$ID_ORIGINAL

casos.com.mais.de.uma.idade <- od87_processado_01 %>% group_by(ID_PESS) %>%
  summarise(
    ID_FAM=unique(ID_FAM),
    idades=length(unique(IDADE)),
    sit_fams=length(unique(SIT_FAM)),
    sexos=length(unique(SEXO)),
    ID_de_troca=max(ID_PROC_01)
  ) %>%
  filter( idades>1 | sexos>1 | sit_fams>1 ) %>%
  ungroup()

# ids.originais.com.problema <- od87_processado %>%
#                     filter(ID_PROC %in% casos.com.mais.de.uma.idade$ID_de_troca) %>%
#                     select(ID_ORIGINAL)

od87_consolidado_02 <- od87_consolidado_01

# Trocando linhas claramente invertidas
for( linha in casos.com.mais.de.uma.idade$ID_de_troca ) {
  od87_consolidado_02 <- troca_linhas(od87_consolidado_02, linha)
}

od87_consolidado_02$ID_CONSOLIDADO_02 <- row.names(od87_consolidado_02)

write.table(od87_consolidado_02, file='od_1987_consolidado_02.csv',
            row.names=FALSE, sep=';', dec=',')

# Passando consolidado_02 pelo ipython notebook

od87_processado_02 <- fread('od_1987_processado_02_v3.csv',
                          sep=';', dec=',', header=TRUE,
                          colClasses = c(
                            'ID_PESS'='character',
                            'ID_VIAG'='character',
                            'ID_DOM'='character',
                            'ID_FAM'='character')
) %>% as.data.frame()

all.equal(select(od87_processado_02,FE_DOM,IDADE,H_CHEG,F_PESS), select(od87_consolidado_02,FE_DOM,IDADE,H_CHEG,F_PESS))

od87_processado_02$ID_PROC_02 <- row.names(od87_processado_02)
od87_processado_02$ID_ORIGINAL <- od87_consolidado_02$ID_ORIGINAL

casos.com.mais.de.uma.idade.02 <- od87_processado_02 %>% group_by(ID_PESS) %>%
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
