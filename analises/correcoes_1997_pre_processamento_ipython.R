od97_original <- fread(file.path(
                          .dirBasesSeparadas,
                          'od_1997_consolidado_v0.csv'
                        ),
                        sep = ';', dec = ',', header = TRUE, data.table = FALSE,
                        colClasses = c(
                          'ID_PESS'='character', 'ID_VIAG'='character',
                          'ID_DOM'='character', 'ID_FAM'='character'
                        )
                  )

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

write.table(od97_consolidado_01,
            file=file.path(.dirBasesSeparadas,'od_1997_consolidado_v1.csv'),
            row.names=FALSE, sep=';', dec=',')

# Passando consolidado_01 pelo ipython notebook

od97_processado_01 <- fread(file.path(
                                    .dirBasesSeparadas,
                                    'od_1997_processado_v1.csv'
                            ),
                            sep=';', dec=',', header=TRUE, data.table = FALSE,
                            colClasses = c(
                              'ID_PESS'='character',
                              'ID_VIAG'='character',
                              'ID_DOM'='character',
                              'ID_FAM'='character')
                      )

od97_processado_01$ID_PROC_01 <- row.names(od97_processado_01)
od97_processado_01$ID_CONSOLIDADO_01 <- od97_consolidado_01$ID_CONSOLIDADO_01
od97_processado_01$ID_ORIGINAL <- od97_consolidado_01$ID_ORIGINAL

casos.com.erro.97 <- od97_processado_01 %>% group_by(ID_PESS) %>%
  summarise(
    ID_FAM=unique(ID_FAM),
    idades=length(unique(IDADE)),
    sit_fams=length(unique(SIT_FAM)),
    sexos=length(unique(SEXO)),
    ID_de_troca=max(ID_PROC_01)
  ) %>%
  filter( idades>1 | sexos>1 | sit_fams>1 ) %>%
  ungroup()
