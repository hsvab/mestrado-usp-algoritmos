
od_filtrado <- od %>% filter(F_FAM==1)

quanti_por_grupo(DF = od_filtrado, VARIAVEL = 'FAM_VIAG_TOT', AGRUPA_POR = 'ANO', IMPRIME = FALSE,
                      RETORNA = FALSE, NOME_ARQUIVO = 'quanti-por-grupo-ANO-FAM_VIAG_TOT')

xtabs(~ FAM_VIAG_TOT + ANO, data = od_filtrado)


quanti_por_grupo(DF = od_filtrado, VARIAVEL = 'FAM_DURACAO_TOT', AGRUPA_POR = 'ANO', IMPRIME = FALSE,
                 RETORNA = FALSE, NOME_ARQUIVO = 'quanti-por-grupo-ANO-FAM_DURACAO_TOT')

xtabs(~ I(round(FAM_DURACAO_TOT/60 , 0)) + ANO, data = od_filtrado)


quanti_por_grupo(DF = od_filtrado, VARIAVEL = 'FAM_DURACAO_MED', AGRUPA_POR = 'ANO', IMPRIME = FALSE,
                 RETORNA = FALSE, NOME_ARQUIVO = 'quanti-por-grupo-ANO-FAM_DURACAO_MED')

xtabs(~ I(round(FAM_DURACAO_MED/15 , 0)) + ANO, data = od_filtrado)



od_filtrado <- od %>% filter(F_FAM==1, FAM_DIST_TOT>0)

quanti_por_grupo(DF = od_filtrado, VARIAVEL = 'FAM_DIST_TOT', AGRUPA_POR = 'ANO', IMPRIME = FALSE,
                 RETORNA = FALSE, NOME_ARQUIVO = 'quanti-por-grupo-ANO-FAM_DIST_TOT')

xtabs(~ I(round(FAM_DIST_TOT/10000 , 0)) + ANO, data = od_filtrado)


od_filtrado <- od %>% filter(F_FAM==1, FAM_DIST_MED>0)

quanti_por_grupo(DF = od_filtrado, VARIAVEL = 'FAM_DIST_MED', AGRUPA_POR = 'ANO', IMPRIME = FALSE,
                 RETORNA = FALSE, NOME_ARQUIVO = 'quanti-por-grupo-ANO-FAM_DIST_MED')

xtabs(~ I(round(FAM_DIST_MED/1000 , 0)) + ANO, data = od_filtrado)

