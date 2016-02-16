od_label <- .mestrado.aplica.labels(od)

#### RECURSOS DE ESTILO DO GGPLOT ####
# Para alterar o tamanho do título do gráfico:
#   theme(plot.title = element_text(size="26"))
#
# Para alterar o tamanho do texto dos valores dos dois eixos:
#   theme(axis.text = element_text(size="20"))
#
# Para alterar o tamanho dos títulos dos dois eixos:
#   theme(axis.title = element_text(size="24"))
#
# Para alterar a inclinação dos valores apenas do eixo X:
#   theme(axis.text.x = element_text(angle=45))
#

#### FUNÇÕES AUXILIARES ####
slice_break <- function(text) {
  # Substitui a barra '/' por uma quebra de linha.
  # Serve para melhorar a apresentação de labels no gráfico
  gsub('/','\n',text)
}

label_MARGIN_ALL <- function(valor) {
  # Ajuste do título do facet quando utilizado o parâmetro
  # margins (que calcula o total da linha ou da coluna)
  # O padrão é aparecer (all)
  # Função para ser utilizada como labeller
  valor[valor=="(all)"] <- "Todos"
  valor
}

#==============================================================================#
####                               FE_DOM                                   ####
#==============================================================================#
# > Gráfico por ano ----
png(file.path(.dirResultados, "freq-abs-fe-dom.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
ggplot( data = filter( od_label, F_DOM==1, !is.na(FE_DOM) ),
        aes( x = FE_DOM, fill = ANO ) ) +
  facet_grid( ANO ~ . )+
  geom_histogram( binwidth = 10, alpha = 0.5, show.legend = FALSE,
                  position = "identity" )+
  scale_x_continuous("FE_DOM", breaks = seq(0,550, 50),
                     expand = c(0.02, 0), limits = c(0,550)) +
  ylab('Frequência Absoluta')
dev.off()

#==============================================================================#
####                            TOT_FAM                                     ####
#==============================================================================#
# > Gráfico por ano ponderado (BoxPlot) ----
# BOXPLOT (filtrada por domicílio)
png(file.path(.dirResultados, "box-plot-tot-fam.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
od_label %>% filter( F_DOM==1 ) %>%
  ggplot( aes( x = ANO, y = TOT_FAM, colour = ANO, weight = FE_DOM ) ) +
  geom_boxplot(alpha=0.5, show.legend = F) + xlab('Ano')
scale_y_continuous('Total de Famílias por domicílio', breaks = seq(0,80,10)) +
  dev.off()

#==============================================================================#
####                                  REN_FAM                               ####
#==============================================================================#
# > Gráficos: ----
# >> Frequência relativa (expandida) ----
## Frequência relativa
png(file.path(.dirResultados, "freq-rel-ren-fam.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
ggplot() + facet_wrap(~ANO, nrow = 4) +
  # Distribuição 1977
  geom_line(  data=filter(od_label, F_FAM==1, ANO=="1977"),
              aes(x=REN_FAM, colour=ANO, weight=FE_FAM_SCALED ),
              stat='density', alpha=0.5, na.rm = T, size=1) +
  # média 1977
  geom_vline( data=filter(od_label, F_FAM==1, ANO=="1977"),
              aes(xintercept = mean(REN_FAM, na.rm=T),
                  colour=ANO, linetype="Média"),
              alpha=0.5, na.rm = T, size=1) +
  # mediana 1977
  geom_vline( data=filter(od_label, F_FAM==1, ANO=="1977"),
              aes(xintercept = median(REN_FAM, na.rm=T),
                  colour=ANO, linetype="Mediana"),
              alpha=0.5, na.rm = T, size=1) +
  # Distribuição 1987
  geom_line(  data=filter(od_label, F_FAM==1, ANO=="1987"),
              aes(x=REN_FAM, colour=ANO, weight=FE_FAM_SCALED ),
              stat='density', alpha=0.5, na.rm = T, size=1) +
  # média 1987
  geom_vline( data=filter(od_label, F_FAM==1, ANO=="1987"),
              aes(xintercept = mean(REN_FAM, na.rm=T),
                  colour=ANO, linetype="Média"),
              alpha=0.5, na.rm = T, size=1) +
  # mediana 1987
  geom_vline( data=filter(od_label, F_FAM==1, ANO=="1987"),
              aes(xintercept = median(REN_FAM, na.rm=T),
                  colour=ANO, linetype="Mediana"),
              alpha=0.5, na.rm = T, size=1) +
  # Distribuição 1997
  geom_line(  data=filter(od_label, F_FAM==1, ANO=="1997"),
              aes(x=REN_FAM, colour=ANO, weight=FE_FAM_SCALED ),
              stat='density', alpha=0.5, na.rm = T, size=1) +
  # média 1997
  geom_vline( data=filter(od_label, F_FAM==1, ANO=="1997"),
              aes(xintercept = mean(REN_FAM, na.rm=T),
                  colour=ANO, linetype="Média"),
              alpha=0.5, na.rm = T, size=1) +
  geom_vline( data=filter(od_label, F_FAM==1, ANO=="1997"),
              aes(xintercept = median(REN_FAM, na.rm=T),
                  colour=ANO, linetype="Mediana"),
              alpha=0.5, na.rm = T, size=1) +
  # Distribuição 2007
  geom_line(  data=filter(od_label, F_FAM==1, ANO=="2007"),
              aes(x=REN_FAM, colour=ANO, weight=FE_FAM_SCALED ),
              stat='density', alpha=0.5, na.rm = T, size=1) +
  # média 2007
  geom_vline( data=filter(od_label, F_FAM==1, ANO=="2007"),
              aes(xintercept = mean(REN_FAM, na.rm=T),
                  colour=ANO, linetype="Média"),
              alpha=0.5, na.rm = T, size=1) +
  # mediana 2007
  geom_vline( data=filter(od_label, F_FAM==1, ANO=="2007"),
              aes(xintercept = median(REN_FAM, na.rm=T),
                  colour=ANO, linetype="Mediana"),
              alpha=0.5, na.rm = T, size=1) +
  scale_y_continuous('Frequência relativa', labels=scales::percent)+
  scale_x_continuous('Renda Familiar', limits = c(1, 10000),
                     breaks=c(seq(500,2500,500), seq(3000,10000,1000)) ) +
  labs(linetype='Marcadores') +
  theme(strip.background = element_blank(), strip.text = element_blank(),
        axis.text.x = element_text(angle = 45, hjust=1, vjust = 1))
dev.off()

# >> Histograma (absoluto) (expandida) ----
## Histograma - valores absolutos
od_label %>%
  filter( F_FAM==1, !is.na(REN_FAM), REN_FAM>0 ) %>%
  ggplot( aes(x=REN_FAM, fill=ANO, weight=FE_FAM) ) +
  facet_grid( ANO ~ . )+
  geom_histogram( binwidth = 250, alpha=0.5, position="identity",
                  show.legend = FALSE) + ylab('Frequência absoluta') +
  scale_x_continuous( 'REN_FAM',
                      limits = .mestrado.outliers.por.grupo(od_label,
                                                            'ANO','REN_FAM'),
                      expand = c(0, 0), breaks = function(limits){
                        return(seq(limits[1],limits[2],500))})

# >> Frequência violino (expandida) ----
## Frequências em forma de violino
od_label %>%
  filter( F_FAM==1, !is.na(REN_FAM) ) %>%
  ggplot( aes( x=ANO, y=REN_FAM, fill=ANO, weight=FE_FAM_SCALED ) ) +
  geom_violin(alpha=0.5, na.rm = T, show.legend = F) +
  scale_y_continuous('Frequência relativa',
                     breaks = c(1,seq(500,5000,500), seq(6000,12000,1000)),
                     limits = .mestrado.outliers.por.grupo(od_label,
                                                           'ANO','REN_FAM',
                                                           zero_in=T) ) +
  xlab('REN_FAM')

#==============================================================================#
#                          Faixa de Renda Familiar                          ####
#==============================================================================#
# > Gráfico por ano ponderado ----
png(file.path(.dirResultados, "class-econ-ren-fam.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
od_label %>%
  filter( F_FAM==1, FAIXA_REN_FAM!="Sem renda", !is.na(FAIXA_REN_FAM) ) %>%
  ggplot( aes( x=FAIXA_REN_FAM, fill=ANO, weight=FE_FAM ) ) +
  facet_grid( ANO ~ . ) +
  geom_bar( aes( y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..] ),
            alpha=0.5, show.legend = FALSE) +
  stat_count( aes( y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..],
                   label = paste0( round( 100 * (..count..) /
                                     tapply(..count..,..PANEL..,sum)[..PANEL..],
                                     2), '%') ),
              geom="text", vjust=-0.5, size=2.5) +
  scale_y_continuous('Frequência relativa', labels=scales::percent) +
  xlab('Classificação Econômica da Renda Familiar') +
  coord_cartesian(ylim=c(0,0.45))
dev.off()

#==============================================================================#
#                             SIT_FAM x SEXO x QT_AUTO                      ####
#==============================================================================#
# > Gráfico por ano ponderado ----
png(file.path(.dirResultados, "autos-sit-fam-sexo.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
od_label %>%
  select(ANO, ID_FAM, FE_FAM, QT_AUTO, SIT_FAM, F_PESS, SEXO) %>%
  filter(F_PESS==1, as.integer(SIT_FAM)==1) %>%
  group_by(ID_FAM) %>%
  summarise(
    chefe.sexo = first(unique(SEXO)),
    ANO = unique(ANO),
    FE_FAM = first(unique(FE_FAM)),
    QT_AUTO = unique(ifelse(QT_AUTO==0,0,ifelse(QT_AUTO==1,1,2)))
  ) %>% ungroup() %>% as.data.frame() %>% group_by(ANO, chefe.sexo) %>%
  summarise(
    QT0 = round( sum( ifelse( QT_AUTO==0, FE_FAM, 0), na.rm=T ) /
                   sum( FE_FAM, na.rm=T ), 4 ),
    QT1 = round( sum( ifelse( QT_AUTO==1, FE_FAM, 0), na.rm=T ) /
                   sum( FE_FAM, na.rm= T), 4 ),
    QT2 = round( sum( ifelse( QT_AUTO==2, FE_FAM, 0), na.rm=T ) /
                   sum( FE_FAM, na.rm=T ), 4 )
  ) %>% ungroup() %>% as.data.frame() %>%
  melt(id.vars = c("ANO","chefe.sexo")) %>% na.omit() %>%
  ggplot( aes( x=as.integer(ANO), y=value, color=variable ) ) +
  geom_line( aes( linetype=chefe.sexo ), size=0.9, alpha=0.5 ) +
  geom_point( size=2, alpha=0.5 ) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Frequência relativa", labels=scales::percent) +
  scale_color_hue("Posse de auto\nda família",
                  labels=c("Sem automóvel", "1 automóvel", "2 ou mais")) +
  scale_linetype_manual(values = c('dotted','solid')) +
  labs(shape="Sexo do chefe\nda família", linetype="Sexo do chefe\nda família")
dev.off()

#==============================================================================#
#                                TOT_PESS                                   ####
#==============================================================================#
# > Gráfico por ano ponderado (Boxplot) ----
# BOXPLOT (filtrada por domicílio)
png(file.path(.dirResultados, "box-plot-tot-pess.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
od_label %>%
  filter(F_FAM==1) %>%
  ggplot( aes( x = ANO, y = TOT_PESS, colour = ANO, weight = FE_FAM_SCALED ) ) +
  geom_boxplot(alpha=0.5, show.legend = F ) + #Plotando o boxplot em si
  scale_y_continuous('Total de Pessoas por Família', breaks = seq(0,20,5)) +
  xlab('Ano')
dev.off()

#==============================================================================#
#                    ANO x PRESENCAS_CRIANCAS E IDOSOS                      ####
#==============================================================================#
# > Gráfico por ano ponderado ----
png(file.path(.dirResultados, "pres-flh-idoso-fam.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
od_label %>% filter( F_FAM==1 ) %>% group_by( ANO ) %>%
  summarise(
    C0 = round( sum( ifelse( PRESENCA_FILH_ate4==1 | PRESENCA_FILH_5a9==1,
                             FE_FAM_SCALED, 0 ), na.rm=T ) /
                  sum( FE_FAM_SCALED, na.rm=T ), 3 ),
    C1 = round( sum( ifelse( PRESENCA_FILH_10a14==1 | PRESENCA_FILH_15a19==1,
                             FE_FAM_SCALED, 0 ), na.rm=T ) /
                  sum( FE_FAM_SCALED, na.rm=T ), 3 ),
    I60a70 = round( sum( ifelse( PRESENCA_IDOSO_60_70==1,
                                 FE_FAM_SCALED, 0 ), na.rm=T ) /
                      sum( FE_FAM_SCALED, na.rm=T ), 3 ),
    I70 = round( sum( ifelse( PRESENCA_IDOSO_70==1,
                              FE_FAM_SCALED, 0 ), na.rm=T ) /
                   sum( FE_FAM_SCALED, na.rm=T ), 3 )
  ) %>% ungroup() %>% as.data.frame() %>% melt(id.var = "ANO") %>% na.omit() %>%
  ggplot(aes(x=as.integer(ANO), y=value, color=variable)) +
  geom_line( size=0.9, alpha=0.5) +
  geom_point( size=2, alpha=0.5) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Percentual de famílias", labels=scales::percent) +
  scale_color_hue("Presença na família\nde pessoas de",
                  labels=c( "0 a 9 anos", "10 a 19 anos",
                            "60 a 70 anos", "70 anos ou mais"))
dev.off()

#==============================================================================#
#                                Faixa Etária                               ####
#==============================================================================#
# > Pirâmide Etária expandida ----
## Pirâmide etária
png(file.path(.dirResultados, "idade.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura*1.3)
ggplot( filter( od_label, F_PESS==1, !is.na(FAIXA_ETARIA) ),
        aes(x = FAIXA_ETARIA, fill = rev(SEXO), weight = FE_PESS ) ) +
  facet_wrap( ~ ANO, nrow = 2 ) +
  geom_bar(
    data=filter( od_label, F_PESS==1, SEXO=="Masculino", !is.na(FAIXA_ETARIA) ),
    aes( y = ..count.. * (-1) ), alpha=0.5, position = "identity" ) +
  geom_bar(
    data=filter( od_label, F_PESS==1, SEXO=="Feminino", !is.na(FAIXA_ETARIA) ),
    alpha = 0.5, position = "identity" ) +
  coord_flip() +
  scale_y_continuous("Pessoas (mil)", breaks = seq(-1000000, 1000000, 200000),
                     labels = as.character(
                       c(rev(seq(200,1000,200)), seq(0,1000,200) ))) +
  scale_fill_hue("Sexo", h.start = 180) + xlab("Faixa Etária") +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust=1, vjust = 1))
dev.off()

#==============================================================================#
#                                   SIT_FAM                                 ####
#==============================================================================#
# > Gráfico por ano e sexo ponderado ----
png(file.path(.dirResultados, "sit-fam.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
od_label %>%
  filter( F_PESS==1, !is.na(SIT_FAM) ) %>%
  ggplot( aes( x=SIT_FAM, fill=SEXO, weight=FE_PESS_SCALED ) ) +
  facet_grid( ANO ~ SEXO ) +
  geom_bar( aes( y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..] ),
            alpha=0.5, show.legend = FALSE) +
  stat_count( aes( y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..],
                   label = paste0( round( 100 * (..count..) /
                                     tapply(..count..,..PANEL..,sum)[..PANEL..],
                                     2), '%') ),
              geom="text", vjust=-0.2, size=2.5) +
  scale_x_discrete('Situação Familiar', label=slice_break) +
  scale_y_continuous('Frequência relativa', labels=scales::percent,
                     breaks=seq(0,.6,.15)) +
  coord_cartesian(ylim=c(0,0.6)) +
  theme(axis.text.x = element_text(angle = 55, hjust=1, vjust = 1))
dev.off()

#==============================================================================#
#                                 GRAU_INSTR                                ####
#==============================================================================#
# > Gráfico por ano e sexo ponderado ----
png(file.path(.dirResultados, "grau-instr.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
od_label %>%
  filter(F_PESS==1, !is.na(GRAU_INSTR)) %>%
  ggplot( aes( x=GRAU_INSTR, fill=SEXO, weight=FE_PESS_SCALED ) ) +
  facet_grid(ANO ~ SEXO) +
  geom_bar( aes( y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..] ),
            alpha=0.5, show.legend = FALSE) +
  stat_count( aes( y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..],
                   label = paste0( round( 100 * (..count..) /
                                     tapply(..count..,..PANEL..,sum)[..PANEL..],
                                     2), '%') ),
              geom="text", vjust=-0.2, size=2.5) +
  scale_x_discrete('Grau de Instrução', label=slice_break) +
  scale_y_continuous('Frequência relativa', labels=scales::percent) +
  coord_cartesian(ylim=c(0, 0.9)) +
  theme(axis.text.x = element_text(angle = 45, hjust=1, vjust = 1))
dev.off()

#==============================================================================#
#                         Faixa de Renda Individual                         ####
#==============================================================================#
# > Gráfico por ano e sexo ponderado ----
png(file.path(.dirResultados, "clas-econ-ren-ind.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
od_label %>%
  filter(F_PESS==1, FAIXA_REN_IND!="Sem renda", !is.na(FAIXA_REN_IND)) %>%
  ggplot(
    aes(x=FAIXA_REN_IND, fill=SEXO, weight=FE_PESS_SCALED)
  ) +
  facet_grid(ANO ~ SEXO) +
  geom_bar( aes( y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..] ),
            alpha=0.5, show.legend = FALSE) +
  stat_count( aes( y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..],
                   label = paste0( round( 100 * (..count..) /
                                     tapply(..count..,..PANEL..,sum)[..PANEL..],
                                     2), '%') ),
              geom="text", vjust=-0.3, size=2.5) +
  scale_y_continuous('Frequência relativa',
                     labels=scales::percent, limits=c(0,0.55)) +
  xlab('Classificação Econômica da Renda Individual') +
  coord_cartesian(ylim=c(0,0.6)) +
  theme(axis.text.x = element_text(angle = 45, hjust=1, vjust = 1))
dev.off()

#==============================================================================#
#                          NÚMERO DE VIAGENS DA PESSOA                      ####
#==============================================================================#
# > Estatísticas: ----
# >> Média por ano, expandida (Bate com a OD) ----
# *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* #
# =*=*=*=*=*=     DADO QUE BATE COM O RELATÓRIO DA PESQUISA OD     =*=*=*=*=*= #
# VIAGENS ~ FE_VIAG/(FE_PESS*F_PESS) + ANO #
od_label %>% group_by(ANO) %>%
  summarise( med_viag = sum(FE_VIAG, na.rm=T)/sum(FE_PESS*F_PESS, na.rm=T) )
#  ANO med_viag
# 1977 2.073649
# 1987 2.063444
# 1997 1.871714
# 2007 1.950096
#
# =*=*=*=*=*=     DADO QUE BATE COM O RELATÓRIO DA PESQUISA OD     =*=*=*=*=*= #
# *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* #
# Estatística descritiva quanti sem expansão

# >> Por ano, sem ponderação ----
# Retorna estatísticas descritivas (para variaveis métricas) do banco completo,
# por ano.
.mestrado.quanti.por.grupo(DF=filter(od_label, F_PESS==1), VARIAVEL='TOT_VIAG')

# >> Por ano e sexo sem ponderação ----
# Estatisticas descritivas (para variaveis métricas) do banco,
# segmentando pelos grupos indicados (ano e sexo)
describeBy( group = select( filter( od_label, F_PESS==1 ), ANO, SEXO ),
            x = filter( od_label, F_PESS==1 )$TOT_VIAG, mat = TRUE, digits=2 )

# >> Por ano com ponderação ----
# Estatisticas descritivas (para variaveis métricas) do banco,
# segmentando pelos grupos indicados (ano e ano+sexo), expandida por FE_PESS
.mestrado.describeByPond(data = filter(od_label, F_PESS==1),
                         VARIAVEL = "TOT_VIAG", GRUPOS = "ANO",
                         FE = "FE_PESS", mat = TRUE, digits=2 )

# >> Por ano e sexo com ponderação ----
.mestrado.describeByPond(data = filter(od_label, F_PESS==1),
                         VARIAVEL = "TOT_VIAG", GRUPOS = c("ANO", "SEXO"),
                         FE = "FE_PESS", mat = TRUE, digits=2 )

# >> Por ano, c/ viagem, com ponderação ----
# Estatisticas descritivas (para variaveis métricas) do banco,
# segmentando pelos grupos indicados (ano e sexo),
# excluindo quem não fez viagens e ponderando por FE_PESS
.mestrado.describeByPond(data = filter(od_label, F_PESS==1, TOT_VIAG>0),
                         VARIAVEL = "TOT_VIAG", GRUPOS = "ANO",
                         FE = "FE_PESS", mat = TRUE, digits=2 )

# >> Testes (T) ----
# Fazendo teste t para averiguar se as médias entre homens e mulheres são
# estatisticamente diferentes, para o mesmo ano

# Gerando dataframe expandido
df_TOT_VIAG <- od_label %>% filter(F_PESS==1) %>%
    select(ANO, SEXO, TOT_VIAG, FE_PESS) %>%
    {.mestrado.expande.DF.por(data=(.), 'FE_PESS')} %>% as.data.frame()
# 1977
t.test( select(filter(df_TOT_VIAG, ANO=="1977", SEXO=="Feminino"), TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="1977", SEXO=="Masculino"), TOT_VIAG))
# 1987
t.test( select(filter(df_TOT_VIAG, ANO=="1987", SEXO=="Feminino"), TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="1987", SEXO=="Masculino"), TOT_VIAG))
# 1997
t.test( select(filter(df_TOT_VIAG, ANO=="1997", SEXO=="Feminino"), TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="1997", SEXO=="Masculino"), TOT_VIAG))
# 2007
t.test( select(filter(df_TOT_VIAG, ANO=="2007", SEXO=="Feminino"), TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="2007", SEXO=="Masculino"), TOT_VIAG))

# Fazendo teste t para averiguar se as médias entre mulheres são
# estatisticamente diferentes entre os anos
# Mulher de 1977 e Mulher de 1987
t.test( select(filter(df_TOT_VIAG, ANO=="1977", SEXO=="Feminino"), TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="1987", SEXO=="Feminino"), TOT_VIAG))
# Mulher de 1987 e Mulher de 1997
t.test( select(filter(df_TOT_VIAG, ANO=="1987", SEXO=="Feminino"), TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="1997", SEXO=="Feminino"), TOT_VIAG))
# Mulher de 1997 e Mulher de 2007
t.test( select(filter(df_TOT_VIAG, ANO=="1997", SEXO=="Feminino"), TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="2007", SEXO=="Feminino"), TOT_VIAG))
# Homem de 1977 e Homem de 1987
t.test( select(filter(df_TOT_VIAG, ANO=="1977", SEXO=="Masculino"), TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="1987", SEXO=="Masculino"), TOT_VIAG))
# Homem de 1987 e Homem de 1997
t.test( select(filter(df_TOT_VIAG, ANO=="1987", SEXO=="Masculino"), TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="1997", SEXO=="Masculino"), TOT_VIAG))
# Homem de 1997 e Homem de 2007
t.test( select(filter(df_TOT_VIAG, ANO=="1997", SEXO=="Masculino"), TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="2007", SEXO=="Masculino"), TOT_VIAG))

# Fazendo teste t para averiguar se as médias entre homens e mulheres são
# estatisticamente diferentes, para o mesmo ano (SÓ PARA QUEM FEZ VIAGEM)
# 1977
t.test( select(filter(df_TOT_VIAG, ANO=="1977", SEXO=="Feminino", TOT_VIAG>0),
               TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="1977", SEXO=="Masculino", TOT_VIAG>0),
               TOT_VIAG))
# 1987
t.test( select(filter(df_TOT_VIAG, ANO=="1987", SEXO=="Feminino", TOT_VIAG>0),
               TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="1987", SEXO=="Masculino", TOT_VIAG>0),
               TOT_VIAG))
# 1997
t.test( select(filter(df_TOT_VIAG, ANO=="1997", SEXO=="Feminino", TOT_VIAG>0),
               TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="1997", SEXO=="Masculino", TOT_VIAG>0),
               TOT_VIAG))
# 2007
t.test( select(filter(df_TOT_VIAG, ANO=="2007", SEXO=="Feminino", TOT_VIAG>0),
               TOT_VIAG),
        select(filter(df_TOT_VIAG, ANO=="2007", SEXO=="Masculino", TOT_VIAG>0),
               TOT_VIAG))

# > Gráficos: ----
# >> Ano e Sexo ponderando por FE_PESS ----
# =========== #
# Versão 01 -
# =========== #
png(file.path(.dirResultados, "tot-viag-pess.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura)
ggplot( data = filter(od_label, F_PESS==1, !is.na(TOT_VIAG)),
        aes(x=TOT_VIAG, fill=SEXO, weight=FE_PESS_SCALED) ) +
  facet_grid(ANO ~ SEXO) +
  geom_bar( aes( y = ..prop..), alpha=0.5, show.legend = FALSE ) +
  stat_count(aes(y = ..prop.. , label=paste0( round( ..prop..*100, 2), '%')) ,
             geom="text", vjust=-0.3, size=2.5) +
  scale_y_continuous( name='Frequência relativa', labels=scales::percent,
                      limits = c(0,.6), breaks = seq(0,1,.1)) +
  scale_x_discrete( name='Total de viagens por pessoa',
                    breaks = as.character(seq(0,6,1)),
                    limits = c(seq(0,6,1)), expand = c(0.09, 0),
                    labels = as.character(seq(0,6,1))
  ) +
  coord_cartesian(xlim=c(0,6), ylim=c(0,0.64))
dev.off()

# >> Ano e Sexo pond. por FE_VIAG e FE_PESS ----
# =========== #
# Versão 02 - Número médio de viagens expandido por FE_VIAG e FE_PESS
# Não funcionou ...... tem algo errado em especial com 1987
# =========== #
od_label %>% group_by(ANO, ID_PESS) %>%
  summarise(
    SEXO = unique(SEXO),
    tot_viag = round(sum(FE_VIAG, na.rm=T) / max(FE_PESS),0)
  ) %>%
  ungroup() %>% as.data.frame() %>% na.omit() %>%
  ggplot( aes( x=tot_viag ) ) + facet_grid(ANO~SEXO) +
  geom_bar( aes( y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..] ),
            alpha=0.5, show.legend = FALSE) +
  stat_count( aes( y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..],
                   label = paste0( round( 100 * (..count..) /
                                     tapply(..count..,..PANEL..,sum)[..PANEL..],
                                     2), '%') ),
              geom="text", vjust=-0.3, size=2.5) +
  scale_x_discrete( name='Total de viagens por pessoa',
                    breaks = as.character(seq(0,6,1)),
                    limits = c(seq(0,6,1)), expand = c(0.09, 0),
                    labels = as.character(seq(0,6,1))) +
  scale_y_continuous( name='Frequência relativa', labels=scales::percent,
                      limits = c(0,.6), breaks = seq(0,1,.1)) +
  coord_cartesian(xlim=c(0,6))

rm(df_TOT_VIAG)

#==============================================================================#
####                FAM_VIAG_TOT - N. DE VIAGENS DA FAMÍLIA                 ####
#==============================================================================#
# > Estatísticas: ----
# >> Por ano ----
# Estatísticas descritivas (para variaveis métricas) do banco completo, por ano.
.mestrado.quanti.por.grupo(DF=filter(od_label, F_FAM==1),
                           VARIAVEL='FAM_VIAG_TOT')

# >> Por ano expandido ----
# Estatisticas descritivas (para variaveis métricas) do banco,
# segmentando pelos grupos indicados
.mestrado.describeByPond(data = filter(od_label, F_FAM==1),
                         VARIAVEL = "FAM_VIAG_TOT", GRUPOS = "ANO",
                         FE = "FE_FAM", mat = TRUE, digits=2)

# >> Por ano, expandido, apenas com viagens ----
# Estatisticas descritivas (para variaveis métricas) do banco,
# segmentando pelos grupos indicados (ano),
# excluindo famílias que não fizeram viagens
.mestrado.describeByPond(data = filter(od_label, F_FAM==1, FAM_VIAG_TOT > 0),
                         VARIAVEL = "FAM_VIAG_TOT", GRUPOS = "ANO",
                         FE = "FE_FAM", mat = TRUE, digits=2)

#==============================================================================#
#                    DURAÇÃO DAS VIAGENS - Estatísticas                     ####
#==============================================================================#
# > Estatísticas: ----
# deve estar filtrado por viagem (F_VIAG=1)

# >> Descritiva da variável ----
# Retorna estatísticas descritivas (para variaveis métricas) do banco completo,
# por ano.
.mestrado.quanti.por.grupo(DF=filter(od_label, F_VIAG==1), VARIAVEL='DURACAO')

# >> Descritiva por ano e por sexo ----
# Estatisticas descritivas (para variaveis métricas) do banco,
# segmentando pelos grupos indicados (ano e sexo)
describeBy(group=select(filter(od_label, F_VIAG==1), ANO, SEXO),
           x=filter(od_label, F_VIAG==1)$DURACAO, mat=T) %>%
  arrange(group2, group1)

# Estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos
# grupos indicados (ano e sexo)
# >> Descritiva por ano expandida ----
.mestrado.describeByPond(data = filter(od_label, F_VIAG==1),
                         VARIAVEL = "DURACAO", GRUPOS = c("ANO"),
                         FE = "FE_VIAG", mat = TRUE, digits=2)
# >> Descritiva por ano e por sexo expandida ----
.mestrado.describeByPond(data = filter(od_label, F_VIAG==1),
                         VARIAVEL = "DURACAO", GRUPOS = c("ANO", "SEXO"),
                         FE = "FE_VIAG", mat = TRUE, digits=2)

# Estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos
# grupos indicados (ano e sexo), excluindo quem não fez viagens
# >> Descritiva por ano expandida (>0) ----
.mestrado.describeByPond(data = filter(od_label, F_VIAG==1, DURACAO>0),
                         VARIAVEL = "DURACAO", GRUPOS = c("ANO"),
                         FE = "FE_VIAG", mat = TRUE, digits=2)
# >> Descritiva por ano e sexo expandida (>0) ----
.mestrado.describeByPond(data = filter(od_label, F_VIAG==1, DURACAO>0),
                         VARIAVEL = "DURACAO", GRUPOS = c("ANO", "SEXO"),
                         FE = "FE_VIAG", mat = TRUE, digits=2)

# > Testes estatísticos (T) ----
# Fazendo teste t para averiguar se as médias entre homens e mulheres são
# estatisticamente diferentes, para o mesmo ano
# Gerando dataframe expandido
df_DURACAO <- od_label %>% filter(F_VIAG==1) %>%
  select(ANO, SEXO, DURACAO, FE_VIAG) %>%
  {.mestrado.expande.DF.por(data=(.), 'FE_VIAG')} %>% as.data.frame()
# 1977
t.test( select(filter(df_DURACAO, ANO=="1977", SEXO=="Feminino"), DURACAO),
        select(filter(df_DURACAO, ANO=="1977", SEXO=="Masculino"), DURACAO))
# 1987
t.test( select(filter(df_DURACAO, ANO=="1987", SEXO=="Feminino"), DURACAO),
        select(filter(df_DURACAO, ANO=="1987", SEXO=="Masculino"), DURACAO))
# 1997
t.test( select(filter(df_DURACAO, ANO=="1997", SEXO=="Feminino"), DURACAO),
        select(filter(df_DURACAO, ANO=="1997", SEXO=="Masculino"), DURACAO))
# 2007
t.test( select(filter(df_DURACAO, ANO=="2007", SEXO=="Feminino"), DURACAO),
        select(filter(df_DURACAO, ANO=="2007", SEXO=="Masculino"), DURACAO))

# Fazendo teste t para averiguar se as médias entre mulheres são
# estatisticamente diferentes entre os anos
# Mulher de 1977 e Mulher de 1987
t.test( select(filter(df_DURACAO, ANO=="1977", SEXO=="Feminino"), DURACAO),
        select(filter(df_DURACAO, ANO=="1987", SEXO=="Feminino"), DURACAO))
# Mulher de 1987 e Mulher de 1997
t.test( select(filter(df_DURACAO, ANO=="1987", SEXO=="Feminino"), DURACAO),
        select(filter(df_DURACAO, ANO=="1997", SEXO=="Feminino"), DURACAO))
# Mulher de 1997 e Mulher de 2007
t.test( select(filter(df_DURACAO, ANO=="1997", SEXO=="Feminino"), DURACAO),
        select(filter(df_DURACAO, ANO=="2007", SEXO=="Feminino"), DURACAO))
# Homem de 1977 e Homem de 1987
t.test( select(filter(df_DURACAO, ANO=="1977", SEXO=="Masculino"), DURACAO),
        select(filter(df_DURACAO, ANO=="1987", SEXO=="Masculino"), DURACAO))
# Homem de 1987 e Homem de 1997
t.test( select(filter(df_DURACAO, ANO=="1987", SEXO=="Masculino"), DURACAO),
        select(filter(df_DURACAO, ANO=="1997", SEXO=="Masculino"), DURACAO))
# Homem de 1997 e Homem de 2007
t.test( select(filter(df_DURACAO, ANO=="1997", SEXO=="Masculino"), DURACAO),
        select(filter(df_DURACAO, ANO=="2007", SEXO=="Masculino"), DURACAO))

# Fazendo teste t para averiguar se as médias entre homens e mulheres são
# estatisticamente diferentes, para o mesmo ano (SÓ PARA QUEM FEZ VIAGEM)
# 1977
t.test( select(filter(df_DURACAO, ANO=="1977", SEXO=="Feminino", DURACAO>4),
               DURACAO),
        select(filter(df_DURACAO, ANO=="1977", SEXO=="Masculino", DURACAO>4),
               DURACAO))
# 1987
t.test( select(filter(df_DURACAO, ANO=="1987", SEXO=="Feminino", DURACAO>4),
               DURACAO),
        select(filter(df_DURACAO, ANO=="1987", SEXO=="Masculino", DURACAO>4),
               DURACAO))
# 1997
t.test( select(filter(df_DURACAO, ANO=="1997", SEXO=="Feminino", DURACAO>4),
               DURACAO),
        select(filter(df_DURACAO, ANO=="1997", SEXO=="Masculino", DURACAO>4),
               DURACAO))
# 2007
t.test( select(filter(df_DURACAO, ANO=="2007", SEXO=="Feminino", DURACAO>4),
               DURACAO),
        select(filter(df_DURACAO, ANO=="2007", SEXO=="Masculino", DURACAO>4),
               DURACAO))

rm(df_DURACAO)

#==============================================================================#
#                               DURACAO                                     ####
#==============================================================================#
# > Estatísticas: ----
# >> Por ano expandida ----
filter(od_label, F_VIAG==1, DURACAO>0) %>%
{describeByPond((.)$DURACAO, (.)$ANO, (.)$FE_VIAG, mat=TRUE, digits=2)}

# >> Por ano e sexo expandida ----
filter(od_label, F_VIAG==1, DURACAO>0) %>%
{describeByPond( (.)$DURACAO, list((.)$ANO, (.)$SEXO),
                 (.)$FE_VIAG, mat=TRUE, digits=2)}

#==============================================================================#
#                             PESS_DURACAO_MED                              ####
#==============================================================================#
# > Gráfico: ----
# >> Por ano e sexo ----
png(file.path(.dirResultados, "pess-duracao-med.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
ggplot( data = filter(od_label, F_PESS==1,
                      !is.na(PESS_DURACAO_MED), PESS_DURACAO_MED > 0),
        aes( x=PESS_DURACAO_MED, fill=SEXO, weight=FE_PESS_SCALED ) ) +
  facet_grid( ANO ~ SEXO ) +
  geom_histogram( binwidth = 5, alpha = 0.5, show.legend = FALSE,
                  position = "identity") +
  scale_y_continuous( name = 'Frequência relativa', labels = scales::percent,
                      limits = c(0,0.05), breaks = seq(0,1,.01)) +
  scale_x_discrete( name='Duração média da viagem da pessoa',
                    breaks = as.character(c(5,seq(15,90, 15), seq(120,240,30))),
                    limits = c(5,seq(15,90, 15), seq(120,240,30)),
                    labels = as.character(c(5,seq(15,90, 15), seq(120,240,30))),
                    expand = c(0.02, 0)) +
  coord_cartesian(xlim=c(0,240)) + theme(axis.text.x = element_text(size="8"))
dev.off()

#==============================================================================#
#                         DURACAO-SEXO-MODO1                                ####
#==============================================================================#
# > Gráfico: ----
# >> Por ano e sexo ----
png(file.path(.dirResultados, "duracao-coletivo.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura*0.9)
od_label %>% filter(F_VIAG==1) %>% group_by(ANO, SEXO, MODO1) %>%
  filter( as.integer(MODO1) %in% c(1,2,6,7,8) ) %>%
  mutate( CAPACIDADE = ifelse( as.integer(MODO1)==7 | as.integer(MODO1)==8,
                               'Alta Capacidade', 'Média Capacidade' )) %>%
  summarise(
    CAPACIDADE = first(CAPACIDADE),
    value = round( weighted.mean( DURACAO, FE_VIAG, na.rm=T ) , 2 )
  ) %>% ungroup() %>% as.data.frame() %>%
  # select(-CAPACIDADE) %>% spread(MODO1, value) %>% arrange(SEXO, ANO) #sumário
  ggplot(
    aes( x=as.integer(ANO), y=value,
         color=MODO1, linetype=SEXO, shape=MODO1 ) ) +
  geom_line( size=0.9, alpha=0.5 ) +
  geom_point( size=3, alpha=0.5 ) +
  facet_grid(~CAPACIDADE) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Duração média de viagem (min)",
                     breaks=seq(0,100,10)) +
  scale_linetype_manual("Sexo", values = c('dotted','solid')) +
  theme( legend.position ="bottom", legend.title.align = 1,
         strip.background = element_blank(), strip.text = element_blank()) +
  guides( linetype = guide_legend( order=1 ),
          color = guide_legend( title="Modo\n(Coletivos)", order=2),
          shape = guide_legend( title="Modo\n(Coletivos)", order=2))
dev.off()

#==============================================================================#
#                             DURACAO-SEXO-TIPO_VIAG                        ####
#==============================================================================#
# > Gráfico: ----
# >> Por ano e sexo ----
png(file.path(.dirResultados, "duracao-modo.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura*0.9)
od_label %>% filter( F_VIAG==1, as.integer(TIPO_VIAG)!= 4 ) %>%
  group_by(ANO, SEXO, TIPO_VIAG) %>% summarise(
    value = round( weighted.mean( DURACAO, FE_VIAG, na.rm=T ) , 2 ) ) %>%
  ungroup() %>% as.data.frame() %>%
  # spread(TIPO_VIAG, value) %>% arrange(SEXO, ANO)
  ggplot( aes( x=as.integer(ANO), y=value,
               color=TIPO_VIAG, linetype=SEXO, shape=TIPO_VIAG ) ) +
  geom_line( size=0.9, alpha=0.5 ) +
  geom_point( size=3, alpha=0.5 ) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Duração média de viagem (min)",
                     limits=c(0,70), breaks=seq(0,100,10)) +
  scale_linetype_manual("Sexo", values = c('dotted','solid')) +
  labs(color="Modo\n(Agregado)", shape="Modo\n(Agregado)")
dev.off()

#==============================================================================#
#                             DURACAO-SEXO-MOTIVO                           ####
#==============================================================================#
# > Gráfico: ----
# >> Por ano e sexo ----
png(file.path(.dirResultados, "duracao-motivo.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura*0.9)
od_label %>% filter( F_VIAG==1, !VIAG_MOTIVO_RES ) %>%
  mutate( MOTIVO = ifelse( VIAG_MOTIVO_SERV_PAS, 1,
                           ifelse(VIAG_MOTIVO_TRAB, 2,
                                  ifelse(VIAG_MOTIVO_EDUC, 3,
                                         ifelse(VIAG_MOTIVO_MANUT_COMPRAS,
                                                4, 5 ))))) %>%
  mutate( MOTIVO = factor(MOTIVO, levels = c(1,2,3,4,5),
                          labels=c('Servir Passageiro', 'Trabalho',
                                   'Educação', 'Manutenção e compras',
                                   'Lazer e outros')) ) %>%
  group_by(ANO, SEXO, MOTIVO) %>%
  summarise(
    value = round( weighted.mean( DURACAO, FE_VIAG, na.rm=T ) , 2 ) ) %>%
  ungroup() %>% as.data.frame() %>%
  #spread(MOTIVO, value) %>% arrange(SEXO, ANO)
  ggplot( aes( x=as.integer(ANO), y=value,
               color=MOTIVO, linetype=SEXO, shape=MOTIVO ) ) +
  geom_line( size=0.9, alpha=0.5 ) +
  geom_point( size=3, alpha=0.5 ) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Duração média de viagem (min)",
                     limits=c(0,50), breaks=seq(0,100,10)) +
  scale_linetype_manual("Sexo", values = c('dotted','solid')) +
  labs(color="Motivo", shape="Motivo")
dev.off()

#==============================================================================#
#                                   DISTANCIA                               ####
#==============================================================================#
# > Estatísticas: ----
# >> Por ano ----
# Estatísticas descritivas (para variaveis métricas) do banco completo, por ano.
.mestrado.quanti.por.grupo(DF=filter(od_label, F_VIAG==1, DIST_VIAG>0),
                           VARIAVEL='DIST_VIAG')

# >> Por ano e sexo ----
# Estatisticas descritivas (para variaveis métricas) do banco, segmentando pelos
#  grupos indicados (ano e sexo)
describe.by(group=select(filter(od_label, F_VIAG==1, DIST_VIAG>0), ANO, SEXO),
            x=filter(od_label, F_VIAG==1, DIST_VIAG>0)$DIST_VIAG)

# >> Por ano expandida ----
filter(od_label, F_VIAG==1, DIST_VIAG>0) %>%
{describeByPond((.)$DIST_VIAG/1000, (.)$ANO, (.)$FE_VIAG, mat=TRUE, digits=2)}

# >> Por ano e sexo expandida ----
filter(od_label, F_VIAG==1, DIST_VIAG>0) %>%
{describeByPond( (.)$DIST_VIAG/1000, list((.)$ANO, (.)$SEXO),
                 (.)$FE_VIAG, mat=TRUE, digits=2)}
# >> Testes (T)
# Fazendo teste t para averiguar se as médias entre homens e mulheres são
# estatisticamente diferentes, para o mesmo ano
# Gerando dataframe expandido
df_DIST_VIAG <- od_label %>% filter(F_VIAG==1, DIST_VIAG>0) %>%
  select(ANO, SEXO, DIST_VIAG, FE_VIAG) %>%
  {.mestrado.expande.DF.por(data=(.), 'FE_VIAG')} %>% as.data.frame()
# 1977
t.test( select(filter(df_DIST_VIAG, ANO=="1977", SEXO=="Feminino"), DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="1977", SEXO=="Masculino"), DIST_VIAG))
# 1987
t.test( select(filter(df_DIST_VIAG, ANO=="1987", SEXO=="Feminino"), DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="1987", SEXO=="Masculino"), DIST_VIAG))
# 1997
t.test( select(filter(df_DIST_VIAG, ANO=="1997", SEXO=="Feminino"), DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="1997", SEXO=="Masculino"), DIST_VIAG))
# 2007
t.test( select(filter(df_DIST_VIAG, ANO=="2007", SEXO=="Feminino"), DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="2007", SEXO=="Masculino"), DIST_VIAG))

# Fazendo teste t para averiguar se as médias entre mulheres são
# estatisticamente diferentes entre os anos
# Mulher de 1977 e Mulher de 1987
t.test( select(filter(df_DIST_VIAG, ANO=="1977", SEXO=="Feminino"), DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="1987", SEXO=="Feminino"), DIST_VIAG))
# Mulher de 1987 e Mulher de 1997
t.test( select(filter(df_DIST_VIAG, ANO=="1987", SEXO=="Feminino"), DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="1997", SEXO=="Feminino"), DIST_VIAG))
# Mulher de 1997 e Mulher de 2007
t.test( select(filter(df_DIST_VIAG, ANO=="1997", SEXO=="Feminino"), DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="2007", SEXO=="Feminino"), DIST_VIAG))
# Homem de 1977 e Homem de 1987
t.test( select(filter(df_DIST_VIAG, ANO=="1977", SEXO=="Masculino"), DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="1987", SEXO=="Masculino"), DIST_VIAG))
# Homem de 1987 e Homem de 1997
t.test( select(filter(df_DIST_VIAG, ANO=="1987", SEXO=="Masculino"), DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="1997", SEXO=="Masculino"), DIST_VIAG))
# Homem de 1997 e Homem de 2007
t.test( select(filter(df_DIST_VIAG, ANO=="1997", SEXO=="Masculino"), DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="2007", SEXO=="Masculino"), DIST_VIAG))

# Fazendo teste t para averiguar se as médias entre homens e mulheres são
# estatisticamente diferentes, para o mesmo ano (SÓ PARA QUEM FEZ VIAGEM)
# 1977
t.test( select(filter(df_DIST_VIAG, ANO=="1977", SEXO=="Feminino", DIST_VIAG>4),
               DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="1977", SEXO=="Masculino", DIST_VIAG>4),
               DIST_VIAG))
# 1987
t.test( select(filter(df_DIST_VIAG, ANO=="1987", SEXO=="Feminino", DIST_VIAG>4),
               DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="1987", SEXO=="Masculino", DIST_VIAG>4),
               DIST_VIAG))
# 1997
t.test( select(filter(df_DIST_VIAG, ANO=="1997", SEXO=="Feminino", DIST_VIAG>4),
               DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="1997", SEXO=="Masculino", DIST_VIAG>4),
               DIST_VIAG))
# 2007
t.test( select(filter(df_DIST_VIAG, ANO=="2007", SEXO=="Feminino", DIST_VIAG>4),
               DIST_VIAG),
        select(filter(df_DIST_VIAG, ANO=="2007", SEXO=="Masculino", DIST_VIAG>4),
               DIST_VIAG))

rm(df_DIST_VIAG)

#==============================================================================#
#                            DISTANCIA-SEXO-MODO1                           ####
#==============================================================================#
# > Gráfico: ----
# >> Por ano e sexo ----
png(file.path(.dirResultados, "distancia-coletivo.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura*0.9)
od_label %>% filter(F_VIAG==1, DIST_VIAG>0) %>% group_by(ANO, SEXO, MODO1) %>%
  filter( as.integer(MODO1) %in% c(1,2,6,7,8) ) %>%
  mutate( CAPACIDADE = ifelse( as.integer(MODO1)==7 | as.integer(MODO1)==8,
                               'Alta Capacidade', 'Média Capacidade' )) %>%
  summarise(
    CAPACIDADE = first(CAPACIDADE),
    value = round( weighted.mean( DIST_VIAG, FE_VIAG, na.rm=T )/1000 , 2 )
  ) %>% ungroup() %>% as.data.frame() %>%
  #select(-CAPACIDADE) %>% spread(MODO1, value) %>% arrange(SEXO, ANO)
  ggplot( aes( x=as.integer(ANO), y=value,
               color=MODO1, linetype=SEXO, shape=MODO1 ) ) +
  geom_line( size=0.9, alpha=0.5 ) +
  geom_point( size=3, alpha=0.5 ) +
  facet_grid(~CAPACIDADE) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Distância média de viagem (km)",
                     limits=c(0,21), breaks=seq(0,20,5) ) +
  scale_linetype_manual("Sexo", values = c('dotted','solid')) +
  theme(  legend.position ="bottom", legend.title.align = 1,
          strip.background = element_blank(), strip.text = element_blank()) +
  guides( linetype= guide_legend( order=1 ),
          color = guide_legend( title="Modo\n(Coletivos)", order=2),
          shape = guide_legend( title="Modo\n(Coletivos)", order=2))
dev.off()

#==============================================================================#
#                             DISTANCIA-SEXO-TIPO_VIAG                      ####
#==============================================================================#
# > Gráfico: ----
# >> Por ano e sexo ----
png(file.path(.dirResultados, "distancia-modo.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura*0.9)
od_label %>% filter( F_VIAG==1, as.integer(TIPO_VIAG)!= 4, DIST_VIAG>0 ) %>%
  # viagens com motivo residência renivudi da análise
  group_by(ANO, SEXO, TIPO_VIAG) %>% summarise(
    value = round( weighted.mean( DIST_VIAG, FE_VIAG, na.rm=T )/1000 , 2 )
  ) %>% ungroup() %>% as.data.frame() %>%
  #spread(TIPO_VIAG, value) %>% arrange(SEXO, ANO)
  ggplot( aes( x=as.integer(ANO), y=value,
               color=TIPO_VIAG, linetype=SEXO, shape=TIPO_VIAG ) ) +
  geom_line( size=0.9, alpha=0.5 ) +
  geom_point( size=3, alpha=0.5 ) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Distância média de viagem (km)",
                     limits=c(0,11.5), breaks=seq(0,15,1)) +
  scale_linetype_manual("Sexo", values = c('dotted','solid')) +
  labs(color="Modo\n(Agregado)", shape="Modo\n(Agregado)")
dev.off()

#==============================================================================#
#                               DISTANCIA-SEXO-MOTIVO                       ####
#==============================================================================#
# > Gráfico: ----
# >> Por ano e sexo ----
png(file.path(.dirResultados, "distancia-motivo.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura*0.9)
od_label %>% filter( F_VIAG==1, !VIAG_MOTIVO_RES, DIST_VIAG>0 ) %>%
  mutate( MOTIVO = ifelse( VIAG_MOTIVO_SERV_PAS, 1,
                           ifelse(VIAG_MOTIVO_TRAB, 2,
                                  ifelse( VIAG_MOTIVO_EDUC, 3,
                                          ifelse( VIAG_MOTIVO_MANUT_COMPRAS,
                                                  4, 5 ))))) %>%
  mutate( MOTIVO = factor(MOTIVO, levels = c(1,2,3,4,5),
                          labels=c('Servir Passageiro', 'Trabalho', 'Educação',
                                   'Manutenção e compras', 'Lazer e outros'))
  ) %>% group_by(ANO, SEXO, MOTIVO) %>%
  summarise(
    value = round( weighted.mean( DIST_VIAG, FE_VIAG, na.rm=T )/1000 , 2 ) ) %>%
  ungroup() %>% as.data.frame() %>%
  # spread(MOTIVO, value) %>% arrange(SEXO, ANO)
  ggplot( aes( x=as.integer(ANO), y=value,
               color=MOTIVO, linetype=SEXO, shape=MOTIVO ) ) +
  geom_line( size=0.9, alpha=0.5 ) +
  geom_point( size=3, alpha=0.5 ) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Distância média de viagem (km)",
                     limits=c(0,11), breaks=seq(0,11,1)) +
  scale_linetype_manual("Sexo", values = c('dotted','solid')) +
  labs(color="Motivo", shape="Motivo")
dev.off()

#==============================================================================#
#                               MODO 1                                      ####
#==============================================================================#
# > Estatísticas: ----
# >> Freq por ano ----
od_label %>% filter(F_VIAG==1) %>% group_by(ANO) %>% summarise(
  total_viagens = sum(FE_VIAG),
  ALTACAP = round( sum( ifelse( as.integer(MODO1)==7 | as.integer(MODO1)==8,
                                FE_VIAG, 0 ) ) / total_viagens, 4 ),
  ONINBUS = round( sum( ifelse( as.integer(MODO1)==1 | as.integer(MODO1)==2 |
                                  as.integer(MODO1)==6,
                                FE_VIAG, 0 ) ) / total_viagens, 4 ),
  DIRIGAUTO = round( sum( ifelse( as.integer(MODO1)==3,
                                  FE_VIAG, 0 ) ) / total_viagens, 4 ),
  PASSAG = round( sum( ifelse( as.integer(MODO1)==4 | as.integer(MODO1)==5,
                               FE_VIAG, 0 ) ) / total_viagens, 4 ),
  APE   = round( sum( ifelse( as.integer(MODO1)==11,
                              FE_VIAG, 0 ) ) / total_viagens, 4 ),
  OUTRO = round( sum( ifelse( as.integer(MODO1)==9 | as.integer(MODO1)==10 |
                                as.integer(MODO1)==12,
                              FE_VIAG, 0 ) ) / total_viagens, 4 )
) %>% {cbind(select((.),ANO, total_viagens),(.)[3:8]*100)}

# >> Freq por ano e sexo ----
# Por sexo (soma 100% a cada duas linhas), análise dos motivos no agrupamento
# ANO, avaliando a contribuição de homens e de mulheres em cada motivo
od_label %>% filter(F_VIAG==1) %>% group_by(ANO) %>% summarise(
  total_viagens = sum( FE_VIAG ),
  ALTACAP_M   = round( 100 * sum( ifelse( as.integer(MODO1)==7 |
                                            as.integer(MODO1)==8 &
                                            SEXO=="Masculino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  ONINBUS_M   = round( 100 * sum( ifelse( as.integer(MODO1)==1 |
                                            as.integer(MODO1)==2 &
                                            SEXO=="Masculino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  DIRIGAUTO_M = round( 100 * sum( ifelse( as.integer(MODO1)==3 &
                                            SEXO=="Masculino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  PASSAG_M    = round( 100 * sum( ifelse( as.integer(MODO1)==4 |
                                            as.integer(MODO1)==5 &
                                            SEXO=="Masculino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  APE_M       = round( 100 * sum( ifelse( as.integer(MODO1)==11 &
                                            SEXO=="Masculino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  OUTRO_M     = round( 100 * sum( ifelse( as.integer(MODO1)==9 |
                                            as.integer(MODO1)==10 |
                                            as.integer(MODO1)==12 &
                                            SEXO=="Masculino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  ALTACAP_F   = round( 100 * sum( ifelse( as.integer(MODO1)==7 |
                                            as.integer(MODO1)==8 &
                                            SEXO=="Feminino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  ONINBUS_F   = round( 100 * sum( ifelse( as.integer(MODO1)==1 |
                                            as.integer(MODO1)==2 &
                                            SEXO=="Feminino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  DIRIGAUTO_F = round( 100 * sum( ifelse( as.integer(MODO1)==3 &
                                            SEXO=="Feminino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  PASSAG_F    = round( 100 * sum( ifelse( as.integer(MODO1)==4 |
                                            as.integer(MODO1)==5 &
                                            SEXO=="Feminino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  APE_F       = round( 100 * sum( ifelse( as.integer(MODO1)==11 &
                                            SEXO=="Feminino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 ),
  OUTRO_F     = round( 100 * sum( ifelse( as.integer(MODO1)==9 |
                                            as.integer(MODO1)==10 |
                                            as.integer(MODO1)==12 &
                                            SEXO=="Feminino",
                                          FE_VIAG, 0 ) ) / total_viagens, 2 )
)

# > Gráfico: ----
# >> Freq por ano e sexo ----
# Por ANO e SEXO (somando 1 na linha)
png(file.path(.dirResultados, "freq-modo1.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura*0.8)
od_label %>% filter(F_VIAG==1) %>% group_by(ANO, SEXO) %>% summarise(
  total_viagens = sum(FE_VIAG),
  ALTACAP = round( sum( ifelse( as.integer(MODO1)==7 | as.integer(MODO1)==8,
                                FE_VIAG, 0 ) ) / total_viagens, 4 ),
  ONINBUS = round( sum( ifelse( as.integer(MODO1)==1 | as.integer(MODO1)==2 |
                                  as.integer(MODO1)==6,
                                FE_VIAG, 0 ) ) / total_viagens, 4 ),
  DIRIGAUTO = round( sum( ifelse( as.integer(MODO1)==3,
                                  FE_VIAG, 0 ) ) / total_viagens, 4 ),
  PASSAG = round( sum( ifelse( as.integer(MODO1)==4 | as.integer(MODO1)==5,
                               FE_VIAG, 0 ) ) / total_viagens, 4 ),
  APE   = round( sum( ifelse( as.integer(MODO1)==11,
                              FE_VIAG, 0 ) ) / total_viagens, 4 ),
  OUTRO = round( sum( ifelse( as.integer(MODO1)==9 | as.integer(MODO1)==10 |
                                as.integer(MODO1)==12,
                              FE_VIAG, 0 ) ) / total_viagens, 4 )
) %>% ungroup() %>% as.data.frame() %>%
  select(-total_viagens) %>% melt(id.vars = c("ANO","SEXO")) %>% na.omit() %>%
  ggplot( aes( x=as.integer(ANO), y=value, color=variable ) ) +
  geom_line( aes( linetype=SEXO ), size=0.9, alpha=0.5 ) +
  geom_point( size=2, alpha=0.5 ) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Frequência relativa", labels=scales::percent) +
  scale_color_hue("Modo da viagem",
                  labels=c( "Alta capacidade", "Ônibus", "Dirigindo\nAutomóvel",
                            "Passageiro de\nAutomóvel ou Taxi", "A pé",
                            "Outros")) +
  scale_linetype_manual(values = c('dotted','solid')) +
  labs(shape="Sexo", linetype="Sexo")
dev.off()

#==============================================================================#
#                                   MODO 2                                  ####
#==============================================================================#
# > Estatísticas: ----
# >> Freq por ano ----
# Por ANO
od_label %>% filter(F_VIAG==1) %>% group_by(ANO) %>% summarise(
  total_viagens = sum(FE_VIAG, na.rm=T),
  ALTACAP   = round( sum( ifelse( as.integer(MODO2)==7 | as.integer(MODO2)==8,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  ONINBUS   = round( sum( ifelse( as.integer(MODO2)==1 | as.integer(MODO2)==2 |
                                    as.integer(MODO2)==6,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  DIRIGAUTO = round( sum( ifelse( as.integer(MODO2)==3,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  PASSAG    = round( sum( ifelse( as.integer(MODO2)==4 | as.integer(MODO2)==5,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  OUTRO     = round( sum( ifelse( as.integer(MODO2)==9 | as.integer(MODO2)==10 |
                                    as.integer(MODO2)==12,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 )
)

# > Gráfico: ----
# >> Freq por ano e sexo ----
# No modo 2 não é possível haver viagens A Pé, pela metodologia da pesquisa OD.
# Por ANO e SEXO (somando 1 na linha)
png(file.path(.dirResultados, "freq-modo2.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura*0.6 )
od_label %>% filter(F_VIAG==1) %>% group_by(ANO, SEXO) %>% summarise(
  total_viagens = sum(FE_VIAG, na.rm=T),
  ALTACAP   = round( sum( ifelse( as.integer(MODO2)==7 |
                                    as.integer(MODO2)==8,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  ONINBUS   = round( sum( ifelse( as.integer(MODO2)==1 |
                                    as.integer(MODO2)==2 |
                                    as.integer(MODO2)==6,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  DIRIGAUTO = round( sum( ifelse( as.integer(MODO2)==3,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  PASSAG    = round( sum( ifelse( as.integer(MODO2)==4 |
                                    as.integer(MODO2)==5,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  OUTRO     = round( sum( ifelse( as.integer(MODO2)==9 |
                                    as.integer(MODO2)==10 |
                                    as.integer(MODO2)==12,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 )
) %>% ungroup() %>% as.data.frame() %>%
  select(-total_viagens) %>% melt(id.vars = c("ANO","SEXO")) %>% na.omit() %>%
  ggplot( aes( x=as.integer(ANO), y=value, color=variable ) ) +
  geom_line( aes( linetype=SEXO ), size=0.9, alpha=0.5 ) +
  geom_point( size=2, alpha=0.5 ) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Frequência relativa", labels=scales::percent) +
  scale_color_hue("Modo da viagem",
                  labels=c( "Alta capacidade", "Ônibus", "Dirigindo\nAutomóvel",
                            "Passageiro de\nAutomóvel ou Taxi", "A pé",
                            "Outros")) +
  scale_linetype_manual(values = c('dotted','solid')) +
  labs(shape="Sexo", linetype="Sexo")
dev.off()

#==============================================================================#
#                                   MODO 3                                  ####
#==============================================================================#
# > Estatísticas: ----
# >> Freq por ano ----
# No modo 3 não é possível haver viagens A Pé, pela metodologia da pesquisa OD.
# Por ANO
od_label %>% filter(F_VIAG==1) %>% group_by(ANO) %>% summarise(
  total_viagens = sum(FE_VIAG, na.rm=T),
  ALTACAP   = round( sum( ifelse( as.integer(MODO3)==7 | as.integer(MODO3)==8,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  ONINBUS   = round( sum( ifelse( as.integer(MODO3)==1 | as.integer(MODO3)==2 |
                                    as.integer(MODO3)==6,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  DIRIGAUTO = round( sum( ifelse( as.integer(MODO3)==3,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  PASSAG    = round( sum( ifelse( as.integer(MODO3)==4 | as.integer(MODO3)==5,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  OUTRO     = round( sum( ifelse( as.integer(MODO3)==9 | as.integer(MODO3)==10 |
                                    as.integer(MODO3)==12,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 )
) %>% .[3:8]*100 # Percentuais
#) # decimal

# >> Freq por ano e sexo ----
# Por ANO e SEXO (somando 1 na linha)
od_label %>% filter(F_VIAG==1) %>% group_by(ANO, SEXO) %>% summarise(
  total_viagens = sum(FE_VIAG, na.rm=T),
  ALTACAP   = round( sum( ifelse( as.integer(MODO3)==7 | as.integer(MODO3)==8,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  ONINBUS   = round( sum( ifelse( as.integer(MODO3)==1 | as.integer(MODO3)==2 |
                                    as.integer(MODO3)==6,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  DIRIGAUTO = round( sum( ifelse( as.integer(MODO3)==3,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  PASSAG    = round( sum( ifelse( as.integer(MODO3)==4 | as.integer(MODO3)==5,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  OUTRO     = round( sum( ifelse( as.integer(MODO3)==9 | as.integer(MODO3)==10 |
                                    as.integer(MODO3)==12,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 )
) %>% .[4:9]*100 # Percentuais
#) # decimal

#==============================================================================#
#                                   MODO 4                                  ####
#==============================================================================#
# > Estatísticas: ----
# >> Freq por ano ----
#No modo 4 não é possível haver viagens A Pé, pela metodologia da pesquisa OD.
# Por ANO
od_label %>% filter(F_VIAG==1) %>% group_by(ANO) %>% summarise(
  total_viagens = sum(FE_VIAG, na.rm=T),
  ALTACAP   = round( sum( ifelse( as.integer(MODO4)==7 | as.integer(MODO4)==8,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  ONINBUS   = round( sum( ifelse( as.integer(MODO4)==1 | as.integer(MODO4)==2 |
                                    as.integer(MODO4)==6,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  DIRIGAUTO = round( sum( ifelse( as.integer(MODO4)==3,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  PASSAG    = round( sum( ifelse( as.integer(MODO4)==4 | as.integer(MODO4)==5,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  OUTRO     = round( sum( ifelse( as.integer(MODO4)==9 | as.integer(MODO4)==10 |
                                    as.integer(MODO4)==12,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 )
) %>% .[3:8]*100 # Percentuais
#) # decimal

# >> Freq por ano e sexo ----
# Por ANO e SEXO (somando 1 na linha)
od_label %>% filter(F_VIAG==1) %>% group_by(ANO, SEXO) %>% summarise(
  total_viagens = sum(FE_VIAG, na.rm=T),
  ALTACAP   = round( sum( ifelse( as.integer(MODO4)==7 | as.integer(MODO4)==8,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  ONINBUS   = round( sum( ifelse( as.integer(MODO4)==1 | as.integer(MODO4)==2 |
                                    as.integer(MODO4)==6,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  DIRIGAUTO = round( sum( ifelse( as.integer(MODO4)==3,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  PASSAG    = round( sum( ifelse( as.integer(MODO4)==4 | as.integer(MODO4)==5,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 ),
  OUTRO     = round( sum( ifelse( as.integer(MODO4)==9 | as.integer(MODO4)==10 |
                                    as.integer(MODO4)==12,
                                  FE_VIAG, 0 ), na.rm=T ) / total_viagens, 4 )
) %>% .[4:9]*100 # Percentuais
#) # decimal

#==============================================================================#
#                                NÚMERO DE MODOS                            ####
#==============================================================================#
# > Estatísticas: ----
# >> Freq geral ----
describe(filter(od_label, F_VIAG==1)$VIAG_NO_MODOS)

# >> Freq por ano expandida ----
# Estatísticas descritivas do número de modos, expandindo por FE_VIAG para ANO
.mestrado.describeByPond(data = filter(od_label, VIAG_NO_MODOS>0),
                         VARIAVEL = "VIAG_NO_MODOS",
                         GRUPOS = c("ANO"),
                         FE = "FE_VIAG",
                         mat = TRUE, digits=2)

# >> Freq por ano e sexo expandida ----
# Estatísticas descritivas do número de modos, expandindo por FE_VIAG para
# ANO e SEXO
.mestrado.describeByPond(data = filter(od_label, VIAG_NO_MODOS>0),
                         VARIAVEL = "VIAG_NO_MODOS",
                         GRUPOS = c("ANO","SEXO"),
                         FE = "FE_VIAG",
                         mat = TRUE, digits=2)

#==============================================================================#
#                                   TIPO_VIAG                               ####
#==============================================================================#
# > Estatísticas: ----
# >> CrossTable ----
od_label %>% filter(F_VIAG==1,  !is.na(TIPO_VIAG), as.integer(TIPO_VIAG)!=4 ) %>%
{CrossTable((.)$famcluster4_ano07, (.)$TIPO_VIAG,
            digits = 4, expected = F, prop.t = F, prop.chisq = F, prop.c = F)}

# > Gráficos: ----
# >> TIPO_VIAG x ANO x SEXO ----
#  (soma 1 na linha)
png(file.path(.dirResultados, "freq-tipo-viag.png"), units = 'cm',
    res = 600, width = .mestrado.plot.largura, height = .mestrado.plot.altura)
od_label %>% filter( F_VIAG==1, !is.na(TIPO_VIAG) ) %>% group_by(ANO, SEXO) %>%
  summarise(
    total_viagens = sum( FE_VIAG, na.rm=T ),
    COLETIVO   = round( sum( ifelse( as.integer(TIPO_VIAG)==1, FE_VIAG, 0 ),
                             na.rm=T ) / total_viagens, 4 ),
    INDIVIDUAL = round( sum( ifelse( as.integer(TIPO_VIAG)==2, FE_VIAG, 0 ),
                             na.rm=T ) / total_viagens, 4 ),
    APE        = round( sum( ifelse( as.integer(TIPO_VIAG)==3, FE_VIAG, 0 ),
                             na.rm=T ) / total_viagens, 4 )
  ) %>% ungroup() %>% as.data.frame() %>%
  select(-total_viagens) %>% melt(id.vars = c("ANO","SEXO")) %>% na.omit() %>%
  ggplot( aes( x=as.integer(ANO), y=value, color=variable, linetype=SEXO ) ) +
  geom_line( size=0.9, alpha=0.5 ) +
  geom_point( size=2, alpha=0.5 ) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Frequência relativa",
                     labels=scales::percent, limits=c(0,0.46)) +
  scale_color_hue("Modo da viagem\n(Agregado)",
                  labels=c( "Coletivo", "Individual", "A pé")) +
  labs(shape="Sexo", linetype="Sexo") +
  scale_linetype_manual(values = c('dotted','solid'))
dev.off()

# >> TIPO_VIAG x ANO ----
# Soma 1 na linha
od_label %>% filter( F_VIAG==1, !is.na(TIPO_VIAG) ) %>% group_by(ANO) %>%
  summarise(
    total_viagens = sum( FE_VIAG, na.rm=T ),
    COLETIVO   = round( sum( ifelse( as.integer(TIPO_VIAG)==1, FE_VIAG, 0 ),
                             na.rm=T ) / total_viagens, 4 ),
    INDIVIDUAL = round( sum( ifelse( as.integer(TIPO_VIAG)==2, FE_VIAG, 0 ),
                             na.rm=T ) / total_viagens, 4 ),
    APE        = round( sum( ifelse( as.integer(TIPO_VIAG)==3, FE_VIAG, 0 ),
                             na.rm=T ) / total_viagens, 4 )
  ) %>% ungroup() %>% as.data.frame() %>%
  select(-total_viagens) %>% melt(id.vars = c("ANO")) %>% na.omit() %>%
  ggplot( aes( x=as.integer(ANO), y=value, color=variable ) ) +
  geom_line( size=1, alpha=0.5 ) +
  geom_point( size=3, alpha=0.5 ) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Frequência relativa", labels=scales::percent) +
  scale_color_hue("Tipo do modo\nda viagem",
                  labels=c( "Coletivo", "Individual", "A pé"))

#==============================================================================#
#                                 MOTIVOS                                   ####
#==============================================================================#
# > Estatísticas:----
# >> Freq por motivo agregado ----
od_label %>% filter(F_VIAG==1) %>% group_by(ANO) %>% summarise(
  total_viagens = sum(FE_VIAG),
  SERV_PAS = round( 100 * sum( ifelse( VIAG_MOTIVO_SERV_PAS==1, FE_VIAG, 0 ) ) /
                      total_viagens, 1 ),
  TRABALHO = round( 100 * sum( ifelse( VIAG_MOTIVO_TRAB==1, FE_VIAG, 0 ) ) /
                      total_viagens, 1 ),
  EDUCACAO = round( 100 * sum( ifelse( VIAG_MOTIVO_EDUC==1, FE_VIAG, 0 ) ) /
                      total_viagens, 1 ),
  RESIDENCIA = round( 100 * sum( ifelse( VIAG_MOTIVO_RES==1, FE_VIAG, 0 ) ) /
                        total_viagens, 1 ),
  MANUT_COMPRAS = round( 100 * sum( ifelse( VIAG_MOTIVO_MANUT_COMPRAS==1,
                                            FE_VIAG, 0 ) ) /
                           total_viagens, 1 ),
  LAZER_OUTROS = round( 100 * sum( ifelse( VIAG_MOTIVO_LAZER_OUTROS==1,
                                           FE_VIAG, 0 ) ) /
                          total_viagens, 1 )
)
# >> Freq por sexo, ano e motivo agregado ----
# Por sexo (soma 100% a cada duas linhas), análise dos motivos no agrupamento
#  ANO, avaliando a contribuição de homens e de mulheres em cada motivo
od_label %>% filter(F_VIAG==1) %>% group_by(ANO) %>% summarise(
  total_viagens = sum( FE_VIAG ),
  SERV_PAS_M      = round( 100 * sum( ifelse( VIAG_MOTIVO_SERV_PAS==1 &
                                                SEXO=="Masculino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  TRABALHO_M      = round( 100 * sum( ifelse( VIAG_MOTIVO_TRAB==1 &
                                                SEXO=="Masculino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  EDUCACAO_M      = round( 100 * sum( ifelse( VIAG_MOTIVO_EDUC==1 &
                                                SEXO=="Masculino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  RESIDENCIA_M    = round( 100 * sum( ifelse( VIAG_MOTIVO_RES==1 &
                                                SEXO=="Masculino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  MANUT_COMPRAS_M = round( 100 * sum( ifelse( VIAG_MOTIVO_MANUT_COMPRAS==1 &
                                                SEXO=="Masculino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  LAZER_OUTROS_M  = round( 100 * sum( ifelse( VIAG_MOTIVO_LAZER_OUTROS==1 &
                                                SEXO=="Masculino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  SERV_PAS_F      = round( 100 * sum( ifelse( VIAG_MOTIVO_SERV_PAS==1 &
                                                SEXO=="Feminino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  TRABALHO_F      = round( 100 * sum( ifelse( VIAG_MOTIVO_TRAB==1 &
                                                SEXO=="Feminino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  EDUCACAO_F      = round( 100 * sum( ifelse( VIAG_MOTIVO_EDUC==1 &
                                                SEXO=="Feminino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  RESIDENCIA_F    = round( 100 * sum( ifelse( VIAG_MOTIVO_RES==1 &
                                                SEXO=="Feminino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  MANUT_COMPRAS_F = round( 100 * sum( ifelse( VIAG_MOTIVO_MANUT_COMPRAS==1 &
                                                SEXO=="Feminino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 ),
  LAZER_OUTROS_F  = round( 100 * sum( ifelse( VIAG_MOTIVO_LAZER_OUTROS==1 &
                                                SEXO=="Feminino",
                                              FE_VIAG, 0 ) ) /
                             total_viagens, 2 )
)

# > Gráficos:----
# >> MOTIVO x ANO X SEXO ----
# Por sexo (soma 100% na linha), análise dos motivos no agrupamento ANO+SEXO
png(file.path(.dirResultados, "freq-motivo.png"), units = 'cm', res = 600,
    width = .mestrado.plot.largura, height = .mestrado.plot.altura*0.9 )
od_label %>% filter(F_VIAG==1) %>% group_by(ANO, SEXO) %>% summarise(
  total_viagens = sum(FE_VIAG),
  SERV_PAS      = round( sum( ifelse( VIAG_MOTIVO_SERV_PAS==1,
                                      FE_VIAG, 0 ) ) / total_viagens, 4 ),
  TRABALHO      = round( sum( ifelse( VIAG_MOTIVO_TRAB==1,
                                      FE_VIAG, 0 ) ) / total_viagens, 4 ),
  EDUCACAO      = round( sum( ifelse( VIAG_MOTIVO_EDUC==1,
                                      FE_VIAG, 0 ) ) / total_viagens, 4 ),
  RESIDENCIA    = round( sum( ifelse( VIAG_MOTIVO_RES==1,
                                      FE_VIAG, 0 ) ) / total_viagens, 4 ),
  MANUT_COMPRAS = round( sum( ifelse( VIAG_MOTIVO_MANUT_COMPRAS==1,
                                      FE_VIAG, 0 ) ) / total_viagens, 4 ),
  LAZER_OUTROS  = round( sum( ifelse( VIAG_MOTIVO_LAZER_OUTROS==1,
                                      FE_VIAG, 0 ) ) / total_viagens, 4 )
) %>% ungroup() %>% as.data.frame() %>%
  # Corrigindo SERV_PAS para 1987
  mutate( SERV_PAS = ifelse(ANO=='1987', NA, SERV_PAS) ) %>%
  select(-total_viagens) %>% melt(id.vars = c("ANO","SEXO")) %>% na.omit() %>%
  ggplot( aes( x=as.integer(ANO), y=value, color=variable ) ) +
  geom_line( aes( linetype=SEXO ), size=0.9, alpha=0.5 ) +
  geom_point( size=2, alpha=0.5 ) +
  scale_x_discrete("Ano", label=levels(od_label$ANO), expand=c(0.05, 0.05)) +
  scale_y_continuous("Frequência relativa",
                     labels=scales::percent) +
  scale_color_hue("Motivo da viagem",
                  labels=c("Servir\nPassageiro(a)", "Trabalho", "Educação",
                           "Residência", "Manutenção\ne Compras",
                           "Lazer e\nOutros")) +
  labs(shape="Sexo", linetype="Sexo") +
  scale_linetype_manual(values = c('dotted','solid'))
dev.off()
