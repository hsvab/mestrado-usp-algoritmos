od_label <- .mestrado.aplica.labels(od)

slice_break <- function(text) {
  gsub('/','\n',text)
}
label_MARGIN_ALL <- function(value) {
  value[value=="(all)"] <- "Todos"
  value
}

###############################################################################
# NÚMERO DE VIAGENS DA PESSOA
###############################################################################
# Estatíistica descritiva quanti sem expansão

# od_filtrado deve estar filtrado por pessoa (F_PESS=1)
od_filtrado <- od %>% filter(F_PESS==1)

# Retorna estatísticas descritivas (para variaveis métricas) do banco completo, por ano.
quanti.por.grupo(DF=od_filtrado, VARIAVEL='TOT_VIAG')

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo)
describe.by(group=select(od_filtrado, ANO, SEXO), x=od_filtrado$TOT_VIAG)

# Criando vetores expandidos
TOT_VIAG_EXPAND_PESS=rep(od_filtrado$TOT_VIAG, times=round(od_filtrado$FE_PESS, 0))
SEXO_EXPAND_PESS=rep(od_filtrado$SEXO, times=round(od_filtrado$FE_PESS, 0))
ANO_EXPAND_PESS=rep(od_filtrado$ANO, times=round(od_filtrado$FE_PESS, 0))

# Unindo os vetores
df_TOT_VIAG = as.data.frame(cbind(TOT_VIAG_EXPAND_PESS, SEXO_EXPAND_PESS, ANO_EXPAND_PESS))

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo)
describe.by(group=select(df_TOT_VIAG, ANO_EXPAND_PESS), x=df_TOT_VIAG$TOT_VIAG_EXPAND_PESS)
describe.by(group=select(df_TOT_VIAG, ANO_EXPAND_PESS, SEXO_EXPAND_PESS), x=df_TOT_VIAG$TOT_VIAG_EXPAND_PESS)

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo), excluindo quem não fez viagens
describe.by(group=select(filter(df_TOT_VIAG, TOT_VIAG_EXPAND_PESS>0), ANO_EXPAND_PESS), x=filter(df_TOT_VIAG, TOT_VIAG_EXPAND_PESS>0)$TOT_VIAG_EXPAND_PESS)
describe.by(group=select(filter(df_TOT_VIAG, TOT_VIAG_EXPAND_PESS>0), ANO_EXPAND_PESS, SEXO_EXPAND_PESS), x=filter(df_TOT_VIAG, TOT_VIAG_EXPAND_PESS>0)$TOT_VIAG_EXPAND_PESS)

# Fazendo teste t para averiguar se as médias entre homens e mulheres são estatisticamente diferentes, para o mesmo ano
# 1977
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==1, SEXO_EXPAND_PESS==1), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==1, SEXO_EXPAND_PESS==0), TOT_VIAG_EXPAND_PESS))
# 1987
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==2, SEXO_EXPAND_PESS==1), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==2, SEXO_EXPAND_PESS==0), TOT_VIAG_EXPAND_PESS))
# 1997
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==3, SEXO_EXPAND_PESS==1), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==3, SEXO_EXPAND_PESS==0), TOT_VIAG_EXPAND_PESS))
# 2007
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==4, SEXO_EXPAND_PESS==1), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==4, SEXO_EXPAND_PESS==0), TOT_VIAG_EXPAND_PESS))

# Fazendo teste t para averiguar se as médias entre mulheres são estatisticamente diferentes entre os anos
# Mulher de 1977 e Mulher de 1987
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==1, SEXO_EXPAND_PESS==1), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==2, SEXO_EXPAND_PESS==1), TOT_VIAG_EXPAND_PESS))
# Mulher de 1987 e Mulher de 1997
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==2, SEXO_EXPAND_PESS==1), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==3, SEXO_EXPAND_PESS==1), TOT_VIAG_EXPAND_PESS))
# Mulher de 1997 e Mulher de 2007
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==3, SEXO_EXPAND_PESS==1), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==4, SEXO_EXPAND_PESS==1), TOT_VIAG_EXPAND_PESS))
# Homem de 1977 e Homem de 1987
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==1, SEXO_EXPAND_PESS==0), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==2, SEXO_EXPAND_PESS==0), TOT_VIAG_EXPAND_PESS))
# Homem de 1987 e Homem de 1997
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==2, SEXO_EXPAND_PESS==0), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==3, SEXO_EXPAND_PESS==0), TOT_VIAG_EXPAND_PESS))
# Homem de 1997 e Homem de 2007
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==3, SEXO_EXPAND_PESS==0), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==4, SEXO_EXPAND_PESS==0), TOT_VIAG_EXPAND_PESS))

# Fazendo teste t para averiguar se as médias entre homens e mulheres são estatisticamente diferentes, para o mesmo ano (SÓ PARA QUEM FEZ VIAGEM)
# 1977
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==1, SEXO_EXPAND_PESS==1, TOT_VIAG_EXPAND_PESS>0), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==1, SEXO_EXPAND_PESS==0, TOT_VIAG_EXPAND_PESS>0), TOT_VIAG_EXPAND_PESS))
# 1987
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==2, SEXO_EXPAND_PESS==1, TOT_VIAG_EXPAND_PESS>0), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==2, SEXO_EXPAND_PESS==0, TOT_VIAG_EXPAND_PESS>0), TOT_VIAG_EXPAND_PESS))
# 1997
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==3, SEXO_EXPAND_PESS==1, TOT_VIAG_EXPAND_PESS>0), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==3, SEXO_EXPAND_PESS==0, TOT_VIAG_EXPAND_PESS>0), TOT_VIAG_EXPAND_PESS))
# 2007
t.test(select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==4, SEXO_EXPAND_PESS==1, TOT_VIAG_EXPAND_PESS>0), TOT_VIAG_EXPAND_PESS),
       select(filter(df_TOT_VIAG, ANO_EXPAND_PESS==4, SEXO_EXPAND_PESS==0, TOT_VIAG_EXPAND_PESS>0), TOT_VIAG_EXPAND_PESS))

########## GRÁFICOS ############

>>> INSERIR CÒDIGO DIEGO AQUI

rm(df_TOT_VIAG)

###############################################################################
# NÚMERO DE VIAGENS DA FAMÍLIA
###############################################################################
# Estatíistica descritiva quanti sem expansão

# od_filtrado deve estar filtrado por pessoa (F_FAM=1)
od_filtrado <- od %>% filter(F_FAM==1)

# Retorna estatísticas descritivas (para variaveis métricas) do banco completo, por ano.
quanti.por.grupo(DF=od_filtrado, VARIAVEL='FAM_VIAG_TOT')

# Criando vetores expandidos
TOT_VIAG_EXPAND_FAM=rep(od_filtrado$FAM_VIAG_TOT, times=round(od_filtrado$FE_FAM, 0))
ANO_EXPAND_FAM=rep(od_filtrado$ANO, times=round(od_filtrado$FE_FAM, 0))

# Unindo os vetores
df_TOT_VIAG = as.data.frame(cbind(TOT_VIAG_EXPAND_FAM, ANO_EXPAND_FAM))

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados
describe.by(group=select(df_TOT_VIAG, ANO_EXPAND_FAM), x=df_TOT_VIAG$TOT_VIAG_EXPAND_FAM)

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano), excluindo famílias que não fizeram viagens
describe.by(group=select(filter(df_TOT_VIAG, TOT_VIAG_EXPAND_FAM>0), ANO_EXPAND_FAM), x=filter(df_TOT_VIAG, TOT_VIAG_EXPAND_FAM>0)$TOT_VIAG_EXPAND_FAM)

rm(df_TOT_VIAG)

###############################################################################
# DURAÇÃO DAS VIAGENS
###############################################################################

# od_filtrado deve estar filtrado por viagem (F_VIAG=1)
od_filtrado <- od %>% filter(F_VIAG==1)

# Retorna estatísticas descritivas (para variaveis métricas) do banco completo, por ano.
quanti.por.grupo(DF=od_filtrado, VARIAVEL='DURACAO')

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo)
describe.by(group=select(od_filtrado, ANO, SEXO), x=od_filtrado$DURACAO)

# Criando vetores expandidos
DURACAO_EXPAND_VIAG=rep(od_filtrado$DURACAO, times=round(od_filtrado$FE_VIAG, 0))
SEXO_EXPAND_VIAG=rep(od_filtrado$SEXO, times=round(od_filtrado$FE_VIAG, 0))
ANO_EXPAND_VIAG=rep(od_filtrado$ANO, times=round(od_filtrado$FE_VIAG, 0))

# Unindo os vetores
df_DURACAO = as.data.frame(cbind(DURACAO_EXPAND_VIAG, SEXO_EXPAND_VIAG, ANO_EXPAND_VIAG))

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo)
describe.by(group=select(df_DURACAO, ANO_EXPAND_VIAG), x=df_DURACAO$DURACAO_EXPAND_VIAG)
describe.by(group=select(df_DURACAO, ANO_EXPAND_VIAG, SEXO_EXPAND_VIAG), x=df_DURACAO$DURACAO_EXPAND_VIAG)

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo), excluindo quem não fez viagens
describe.by(group=select(filter(df_DURACAO, DURACAO_EXPAND_VIAG>0), ANO_EXPAND_VIAG), x=filter(df_DURACAO, DURACAO_EXPAND_VIAG>0)$DURACAO_EXPAND_VIAG)
describe.by(group=select(filter(df_DURACAO, DURACAO_EXPAND_VIAG>0), ANO_EXPAND_VIAG, SEXO_EXPAND_VIAG), x=filter(df_DURACAO, DURACAO_EXPAND_VIAG>0)$DURACAO_EXPAND_VIAG)

# Fazendo teste t para averiguar se as médias entre homens e mulheres são estatisticamente diferentes, para o mesmo ano
# 1977
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==1, SEXO_EXPAND_VIAG==1), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==1, SEXO_EXPAND_VIAG==0), DURACAO_EXPAND_VIAG))
# 1987
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==1), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==0), DURACAO_EXPAND_VIAG))
# 1997
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==1), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==0), DURACAO_EXPAND_VIAG))
# 2007
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==4, SEXO_EXPAND_VIAG==1), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==4, SEXO_EXPAND_VIAG==0), DURACAO_EXPAND_VIAG))

# Fazendo teste t para averiguar se as médias entre mulheres são estatisticamente diferentes entre os anos
# Mulher de 1977 e Mulher de 1987
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==1, SEXO_EXPAND_VIAG==1), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==1), DURACAO_EXPAND_VIAG))
# Mulher de 1987 e Mulher de 1997
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==1), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==1), DURACAO_EXPAND_VIAG))
# Mulher de 1997 e Mulher de 2007
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==1), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==4, SEXO_EXPAND_VIAG==1), DURACAO_EXPAND_VIAG))
# Homem de 1977 e Homem de 1987
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==1, SEXO_EXPAND_VIAG==0), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==0), DURACAO_EXPAND_VIAG))
# Homem de 1987 e Homem de 1997
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==0), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==0), DURACAO_EXPAND_VIAG))
# Homem de 1997 e Homem de 2007
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==0), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==4, SEXO_EXPAND_VIAG==0), DURACAO_EXPAND_VIAG))

# Fazendo teste t para averiguar se as médias entre homens e mulheres são estatisticamente diferentes, para o mesmo ano (SÓ PARA QUEM FEZ VIAGEM)
# 1977
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==1, SEXO_EXPAND_VIAG==1, DURACAO_EXPAND_VIAG>4), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==1, SEXO_EXPAND_VIAG==0, DURACAO_EXPAND_VIAG>4), DURACAO_EXPAND_VIAG))
# 1987
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==1, DURACAO_EXPAND_VIAG>4), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==0, DURACAO_EXPAND_VIAG>4), DURACAO_EXPAND_VIAG))
# 1997
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==1, DURACAO_EXPAND_VIAG>4), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==0, DURACAO_EXPAND_VIAG>4), DURACAO_EXPAND_VIAG))
# 2007
t.test(select(filter(df_DURACAO, ANO_EXPAND_VIAG==4, SEXO_EXPAND_VIAG==1, DURACAO_EXPAND_VIAG>4), DURACAO_EXPAND_VIAG),
       select(filter(df_DURACAO, ANO_EXPAND_VIAG==4, SEXO_EXPAND_VIAG==0, DURACAO_EXPAND_VIAG>4), DURACAO_EXPAND_VIAG))

###############################################################################
# DURAÇÃO DAS VIAGENS DA PESSOA --> não utilizado
###############################################################################
# Estatíistica descritiva quanti sem expansão

# od_filtrado deve estar filtrado por pessoa (F_PESS=1)
# Retorna estatísticas descritivas (para variaveis métricas) do banco completo, por ano.
quanti.por.grupo(DF=od_filtrado, VARIAVEL='PESS_DURACAO_MED')

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo)
describe.by(group=select(od_filtrado, ANO, SEXO), x=od_filtrado$PESS_DURACAO_MED)

# Criando vetores expandidos
DURACAO_EXPAND_PESS=rep(od_filtrado$PESS_DURACAO_MED, times=round(od_filtrado$FE_PESS, 0))
SEXO_EXPAND_PESS=rep(od_filtrado$SEXO, times=round(od_filtrado$FE_PESS, 0))
ANO_EXPAND_PESS=rep(od_filtrado$ANO, times=round(od_filtrado$FE_PESS, 0))

# Unindo os vetores
df_DURACAO = as.data.frame(cbind(DURACAO_EXPAND_PESS, SEXO_EXPAND_PESS, ANO_EXPAND_PESS))

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo)
describe.by(group=select(df_DURACAO, ANO_EXPAND_PESS), x=df_DURACAO$DURACAO_EXPAND_PESS)
describe.by(group=select(df_DURACAO, ANO_EXPAND_PESS, SEXO_EXPAND_PESS), x=df_DURACAO$DURACAO_EXPAND_PESS)

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo), excluindo quem não fez viagens
describe.by(group=select(filter(df_DURACAO, DURACAO_EXPAND_PESS>4), ANO_EXPAND_PESS), x=filter(df_DURACAO, DURACAO_EXPAND_PESS>4)$DURACAO_EXPAND_PESS)
describe.by(group=select(filter(df_DURACAO, DURACAO_EXPAND_PESS>4), ANO_EXPAND_PESS, SEXO_EXPAND_PESS), x=filter(df_DURACAO, DURACAO_EXPAND_PESS>4)$DURACAO_EXPAND_PESS)

###############################################################################
# DURAÇÃO DAS VIAGENS DA FAMÌLIA --> não utilizado
###############################################################################
# Estatíistica descritiva quanti sem expansão

# od_filtrado deve estar filtrado por pessoa (F_FAM=1)
# Retorna estatísticas descritivas (para variaveis métricas) do banco completo, por ano.
quanti.por.grupo(DF=od_filtrado, VARIAVEL='FAM_DURACAO_TOT')

# Criando vetores expandidos
DURACAO_EXPAND_FAM=rep(od_filtrado$FAM_DURACAO_TOT, times=round(od_filtrado$FE_FAM, 0))
ANO_EXPAND_FAM=rep(od_filtrado$ANO, times=round(od_filtrado$FE_FAM, 0))

# Unindo os vetores
df_DURACAO = as.data.frame(cbind(DURACAO_EXPAND_FAM, ANO_EXPAND_FAM))

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados
describe.by(group=select(df_DURACAO, ANO_EXPAND_FAM), x=df_DURACAO$DURACAO_EXPAND_FAM)

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano), excluindo famílias que não fizeram viagens
describe.by(group=select(filter(df_DURACAO, DURACAO_EXPAND_FAM>4), ANO_EXPAND_FAM), x=filter(df_DURACAO, DURACAO_EXPAND_FAM>4)$DURACAO_EXPAND_FAM)

rm(df_DURACAO)

###############################################################################
# MODOS DAS VIAGENS
###############################################################################

# Estatísticas descritivas do número de modos, expandindo por FE_VIAG
for(i in c(1,2,3,4)){

  # Serão apresentadas as estatíticas de duração para cada ano
  od_filtrado <- od %>% filter(ANO==i)

  # Criando vetores expandidos
  NO_MODOS_EXPAND_VIAG=rep(od_filtrado$VIAG_NO_MODOS, times=round(od_filtrado$FE_VIAG, 0))
  SEXO_EXPAND_VIAG=rep(od_filtrado$SEXO, times=round(od_filtrado$FE_VIAG, 0))
  ANO_EXPAND_VIAG=rep(od_filtrado$ANO, times=round(od_filtrado$FE_VIAG, 0))

  # Unindo os vetores
  df_NO_MODOS = as.data.frame(cbind(NO_MODOS_EXPAND_VIAG, SEXO_EXPAND_VIAG, ANO_EXPAND_VIAG))

  # Retorna estatisticas descritivas (para variáveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo)
  print(paste('Todos registros de viagem do ANO =', i))
  print(describe(filter(df_NO_MODOS, NO_MODOS_EXPAND_VIAG>0)$NO_MODOS_EXPAND_VIAG))
  print(paste('Todos registros de viagem, por sexo, do ANO=',i))
  print(describe.by(group=select(filter(df_NO_MODOS, NO_MODOS_EXPAND_VIAG>0), SEXO_EXPAND_VIAG), x=filter(df_NO_MODOS, NO_MODOS_EXPAND_VIAG>0)$NO_MODOS_EXPAND_VIAG))

  rm(df_NO_MODOS)
}

describe(filter(od, F_VIAG==1)$VIAG_NO_MODOS)


###############################################################################
# DSITANCIAS DAS VIAGENS
###############################################################################

# od_filtrado deve estar filtrado por viagem (F_VIAG=1)
od_filtrado <- od %>% filter(F_VIAG==1, DIST_VIAG>0)

# Retorna estatísticas descritivas (para variaveis métricas) do banco completo, por ano.
quanti.por.grupo(DF=od_filtrado, VARIAVEL='DIST_VIAG')

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo)
describe.by(group=select(od_filtrado, ANO, SEXO), x=od_filtrado$DIST_VIAG)

# Criando vetores expandidos
DIST_VIAG_EXPAND_VIAG=rep(od_filtrado$DIST_VIAG, times=round(od_filtrado$FE_VIAG, 0))
SEXO_EXPAND_VIAG=rep(od_filtrado$SEXO, times=round(od_filtrado$FE_VIAG, 0))
ANO_EXPAND_VIAG=rep(od_filtrado$ANO, times=round(od_filtrado$FE_VIAG, 0))

# Unindo os vetores
df_DIST_VIAG = as.data.frame(cbind(DIST_VIAG_EXPAND_VIAG, SEXO_EXPAND_VIAG, ANO_EXPAND_VIAG))

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo)
describe.by(group=select(df_DIST_VIAG, ANO_EXPAND_VIAG), x=df_DIST_VIAG$DIST_VIAG_EXPAND_VIAG)
describe.by(group=select(df_DIST_VIAG, ANO_EXPAND_VIAG, SEXO_EXPAND_VIAG), x=df_DIST_VIAG$DIST_VIAG_EXPAND_VIAG)

# Retorna estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos grupos indicados (ano e sexo), excluindo quem não fez viagens
describe.by(group=select(filter(df_DIST_VIAG, DIST_VIAG_EXPAND_VIAG>0), ANO_EXPAND_VIAG), x=filter(df_DIST_VIAG, DIST_VIAG_EXPAND_VIAG>0)$DIST_VIAG_EXPAND_VIAG)
describe.by(group=select(filter(df_DIST_VIAG, DIST_VIAG_EXPAND_VIAG>0), ANO_EXPAND_VIAG, SEXO_EXPAND_VIAG), x=filter(df_DIST_VIAG, DIST_VIAG_EXPAND_VIAG>0)$DIST_VIAG_EXPAND_VIAG)

# Fazendo teste t para averiguar se as médias entre homens e mulheres são estatisticamente diferentes, para o mesmo ano
# 1977
t.test(select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==1, SEXO_EXPAND_VIAG==1), DIST_VIAG_EXPAND_VIAG),
       select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==1, SEXO_EXPAND_VIAG==0), DIST_VIAG_EXPAND_VIAG))
# 1987
t.test(select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==1), DIST_VIAG_EXPAND_VIAG),
       select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==0), DIST_VIAG_EXPAND_VIAG))
# 1997
t.test(select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==1), DIST_VIAG_EXPAND_VIAG),
       select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==0), DIST_VIAG_EXPAND_VIAG))
# 2007
t.test(select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==4, SEXO_EXPAND_VIAG==1), DIST_VIAG_EXPAND_VIAG),
       select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==4, SEXO_EXPAND_VIAG==0), DIST_VIAG_EXPAND_VIAG))

# Fazendo teste t para averiguar se as médias entre mulheres são estatisticamente diferentes entre os anos
# Mulher de 1977 e Mulher de 1987
t.test(select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==1, SEXO_EXPAND_VIAG==1), DIST_VIAG_EXPAND_VIAG),
       select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==1), DIST_VIAG_EXPAND_VIAG))
# Mulher de 1987 e Mulher de 1997
t.test(select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==1), DIST_VIAG_EXPAND_VIAG),
       select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==1), DIST_VIAG_EXPAND_VIAG))
# Mulher de 1997 e Mulher de 2007
t.test(select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==1), DIST_VIAG_EXPAND_VIAG),
       select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==4, SEXO_EXPAND_VIAG==1), DIST_VIAG_EXPAND_VIAG))
# Homem de 1977 e Homem de 1987
t.test(select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==1, SEXO_EXPAND_VIAG==0), DIST_VIAG_EXPAND_VIAG),
       select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==0), DIST_VIAG_EXPAND_VIAG))
# Homem de 1987 e Homem de 1997
t.test(select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==2, SEXO_EXPAND_VIAG==0), DIST_VIAG_EXPAND_VIAG),
       select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==0), DIST_VIAG_EXPAND_VIAG))
# Homem de 1997 e Homem de 2007
t.test(select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==3, SEXO_EXPAND_VIAG==0), DIST_VIAG_EXPAND_VIAG),
       select(filter(df_DIST_VIAG, ANO_EXPAND_VIAG==4, SEXO_EXPAND_VIAG==0), DIST_VIAG_EXPAND_VIAG))
