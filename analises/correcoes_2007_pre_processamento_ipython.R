od07_original <- fread(file.path(
                        .dirBasesSeparadas,
                        'od_2007_consolidado_v0.csv'
                      ),
                      sep=';', dec=',', header=TRUE, data.table = FALSE,
                      colClasses = c(
                        'ID_PESS'='character',
                        'ID_VIAG'='character',
                        'ID_DOM'='character',
                        'ID_FAM'='character')
                  )

od07 <- od07_original

# Criando variável temporária com ID de cada linha
od07$ID_ORIGINAL <- row.names(od07)

# Criando variável temporária para ajudar a remover registros inválidos
od07$REMOVER <- FALSE

######
## Correções de dados incorretos
#
# Quase certeza que são gêmeos, mas a primeira linha do segundo ficou trocada
# com a segunda do primeiro. Ou acertamos a ordem ou removemos um dos pares de
# registros (33285 e 33286)
od07 <- troca_linhas(od07, 33285)

# Removendo registros marcados para remoção
od07 <- od07 %>% filter(REMOVER==FALSE)

######
## Exluindo variável temporária já utilizada
od07$REMOVER <- NULL

od07$ID_CONSOLIDADO_01 <- row.names(od07)

od07_consolidado_01 <- od07

write.table(od07_consolidado_01,
            file=file.path(.dirBasesSeparadas,'od_2007_consolidado_v1.csv'),
            row.names=FALSE, sep=';', dec=',')

# Passando consolidado_01 pelo ipython notebook

od07_processado_01 <- fread(file.path(
                                  .dirBasesSeparadas,
                                  'od_2007_processado_v1.csv'
                            ),
                            sep=';', dec=',', header=TRUE, data.table = FALSE,
                            colClasses = c(
                              'ID_PESS'='character',
                              'ID_VIAG'='character',
                              'ID_DOM'='character',
                              'ID_FAM'='character')
                      )

od07_processado_01$ID_PROC_01 <- row.names(od07_processado_01)
od07_processado_01$ID_ORIGINAL <- od07_consolidado_01$ID_ORIGINAL

casos.com.problema.07.01 <- od07_processado_01 %>% group_by(ID_PESS) %>%
  summarise(
    ID_FAM=unique(ID_FAM),
    idades=length(unique(IDADE)),
    sit_fams=length(unique(SIT_FAM)),
    sexos=length(unique(SEXO)),
    ID_de_troca=max(ID_PROC_01)
  ) %>%
  filter( idades>1 | sexos>1 | sit_fams>1 ) %>%
  ungroup()
