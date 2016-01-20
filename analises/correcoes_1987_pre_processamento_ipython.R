od87_original <- fread(file.path(
                        .dirBasesSeparadas,
                        'od_1987_consolidado_v0.csv'
                      ),
                      sep = ';', dec = ',', header = TRUE, data.table = FALSE,
                      colClasses = c(
                        'ID_PESS'='character', 'ID_VIAG'='character',
                        'ID_DOM'='character', 'ID_FAM'='character'
                      )
                 )

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

write.table(od87_consolidado_01, file=file.path(.dirBasesSeparadas,
                                             'od_1987_consolidado_v1.csv'),
            row.names=FALSE, sep=';', dec=',')

# Passando consolidado_01 pelo ipython notebook

od87_processado_01 <- fread(file.path(.dirBasesSeparadas,
                                   'od_1987_processado_v1.csv'),
                            sep=';', dec=',', header=TRUE,
                            colClasses = c(
                              'ID_PESS'='character',
                              'ID_VIAG'='character',
                              'ID_DOM'='character',
                              'ID_FAM'='character')
                      )

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
