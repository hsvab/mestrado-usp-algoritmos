od_label <- .mestrado.aplica.labels(od)

slice_break <- function(text) {
  gsub('/','\n',text)
}
label_MARGIN_ALL <- function(value) {
  value[value=="(all)"] <- "Todos"
  value
}

###############################################################################
# IDADE
###############################################################################
# Distribuição de idade de respondentes das Pesquisas OD por ano e por sexo.
od_label %>%
  filter(F_PESS==1, !is.na(IDADE)) %>%
  ggplot(
    aes(x=IDADE,
        fill=SEXO)
    # weight=FE_PESS) # Ponderando por FE_PESS
  ) +
  facet_grid(ANO ~ SEXO,
             margins="SEXO" ,
             labeller=labeller(SEXO=label_MARGIN_ALL)) +
  geom_histogram(binwidth = 1,
                 alpha=0.5) +
  scale_fill_discrete(
    labels=c('Masculino','Feminino','Todos')
  ) +
  scale_x_continuous(breaks = seq(0,100,10)) +
  xlab('Idade') +
  ylab('Frequência absoluta') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"))

## MODELO 2 - Sem o 'grid'
od_label %>%
  filter(F_PESS==1, !is.na(IDADE)) %>%
  ggplot(
    aes(x=IDADE,
        fill=SEXO)
    # weight=FE_PESS) # Ponderando por FE_PESS
  ) +
  facet_grid(ANO ~ .,
             margin="ANO",
             scales = "free_y") + # Retirar 'scales' se quiser todos na mesma escala
  geom_histogram(binwidth = 1,
                 alpha=0.4,
                 position="identity") + # Dá pra testar com position='dodge' também
  scale_x_continuous(breaks = seq(0,100,10)) +
  xlab('Idade') +
  ylab('Frequência absoluta') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"))


###############################################################################
# SIT_FAM
###############################################################################
od_label %>%
  filter(F_PESS==1, !is.na(SIT_FAM)) %>%
  ggplot(
    aes(x=SIT_FAM,
        fill=SEXO)
        # weight=FE_PESS) # Ponderando por FE_PESS
  ) +
  facet_grid(ANO ~ SEXO) +
  geom_bar(aes(y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..]), alpha=0.5) +
  stat_count(geom="text",
             aes(y=(..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..],
                 label=paste0(
                   round(
                     (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..]*100,
                     2),
                   '%')
             ),
             size=3,
             color=.mestrado.cor.elementos.gerais,
             vjust=-0.5) +
  scale_x_discrete(label=slice_break) + # slice_break, definido no começo,
  # troca as "barras" ("/") por quebras de
  # linha nas labels do eixo X.
  scale_y_continuous(labels=scales::percent, expand=c(0.15, 0)) + # usado para aumentar o espaço para a
  # margem do gráfico para caber o valor.
  xlab('Situação Familiar') +
  ylab('Frequência relativa') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 30, hjust=1))

###############################################################################
# GRAU_INSTR
###############################################################################
od_label %>%
  filter(F_PESS==1, !is.na(GRAU_INSTR)) %>%
  ggplot(
    aes(x=GRAU_INSTR,
        fill=SEXO) # Colore 'por sexo'
        # weight=FE_PESS) # Ponderando por FE_PESS
  ) +
  facet_grid(ANO ~ SEXO) + # Aqui cria o 'grid' ANO x SEXO
  geom_bar(aes(y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..]),
           alpha=0.5) + # Plota o gráfico de barras
  stat_count(geom="text", # E esse stat count serve para colocar o valor
             aes(y=(..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..],
                 label=paste0(
                        round(
                          (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..]*100,
                          2),
                        '%')
              ),
             size=3,
             color=.mestrado.cor.elementos.gerais,
             vjust=-0.5) +
  scale_x_discrete(label=slice_break) + # slice_break, definido no começo,
                                        # troca as "barras" ("/") por quebras de
                                        # linha nas labels do eixo X.
  scale_y_continuous(labels=scales::percent, expand=c(0.15, 0)) + # usado para aumentar o espaço para a
                                          # margem do gráfico para caber o valor.
  xlab('Grau de Instrução') +
  ylab('Frequência relativa') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 30, hjust=1))


#########################################################
# BOXPLOT da variável TOT_FAM (filtrada por domicílio)
#########################################################
od_label %>%
  filter(F_DOM==1) %>%
  ggplot(
    aes(x=ANO,
        y=TOT_FAM,
        colour=ANO) #este colour é o que faz colorido por ano.
  ) +
  geom_boxplot(alpha=0.5, show.legend=FALSE) + #Plotando o boxplot em si
  scale_y_continuous(breaks = seq(0,80,10)) + # usado para aumentar o espaço para a
  # margem do gráfico para caber o valor.
  xlab('Ano') +
  ylab('Total de Famílias por domicílio') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 30, hjust=1))



###############################################################################
# Distribuição do FE_DOM
###############################################################################
od_label %>%
  filter(F_DOM==1, !is.na(FE_DOM)) %>%
  filter(FE_DOM<550) %>% # filtro para cortar o limite superior da curva
                         # o limite superior do intervalo interquartil é 535,45 p/ 2007 (o maior valor IIQ)
  ggplot(
    aes(x=FE_DOM, fill=ANO)
  ) +
  facet_grid(ANO~.)+
  geom_histogram(binwidth = 10,
                 alpha=0.4,
                 show.legend = FALSE,
                 position="identity")+
  scale_x_continuous(breaks=seq(0,550, 50), # usado para determinar mín, máx, e delta do intervalo do eixo x
                     expand=c(0, 0)) + # usado para aumentar o espaço para a margem do gráfico para caber o valor.
  xlab('FE_DOM') +
  ylab('Frequência Absoluta') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 30, hjust=1))

###############################################################################
# Distribuição da REN_FAM
###############################################################################

#### Histograma - valores absolutos ####
od_label %>%
  filter(F_FAM==1, !is.na(REN_FAM)) %>%
  filter(REN_FAM<10000, REN_FAM>0) %>% # filtro para cortar o limite superior da curva
  # o limite superior do intervalo interquartil é R$9964,19 p/ 1977 (o maior valor IIQ)

  ggplot(
    aes(x=REN_FAM, fill=ANO)
  ) +
  facet_grid(ANO~.)+
  geom_histogram(binwidth = 250,
                 alpha=0.4,
                 position="identity",
                 show.legend = FALSE)+
  xlab('REN_FAM') +
  ylab('Frequência absoluta') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 30, hjust=1))

#### Gráfico de linhas ####
od_label %>%
  filter(F_FAM==1, !is.na(REN_FAM)) %>%
  ggplot(
  aes(x=REN_FAM, fill=NULL, colour=ANO)
  ) +
  geom_line(stat="density",alpha=1, size=1.2) + # Geom_density plota as densidades (freq. rel)
  scale_y_continuous(labels=scales::percent)+ # acertando a escala para %
  xlim(0.1, 10000) +
  xlab('REN_FAM') +
  ylab('Frequência relativa') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 30, hjust=1))

#### Histograma de faixas de renda familiar ####
od_label %>%
  filter(F_FAM==1, FAIXA_REN_FAM!="Sem renda", !is.na(FAIXA_REN_FAM)) %>%
  ggplot(
    aes(x=FAIXA_REN_FAM,
        fill=ANO) # Colore 'por sexo'
    # weight=FE_PESS) # Ponderando por FE_PESS
  ) +
  facet_grid(ANO ~ .) + # Aqui cria o 'grid' ANO x SEXO
  geom_bar(aes(y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..]),
           alpha=0.5,
           show.legend = FALSE) + # Plota o gráfico de barras
  stat_count(geom="text", # E esse stat count serve para colocar o valor
             aes(y=(..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..],
                 label=paste0(
                   round(
                     (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..]*100,
                     2),
                   '%')
             ),
             size=3,
             color=.mestrado.cor.elementos.gerais,
             vjust=-0.5) +
  scale_y_continuous(labels=scales::percent, expand=c(0.15, 0)) + # usado para aumentar o espaço para a
  # margem do gráfico para caber o valor.
  xlab('Classificação Econômica da Renda Familiar') +
  ylab('Frequência relativa') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 45, hjust=1))



###############################################################################
# Distribuição de QT_AUTO
###############################################################################


od %>% filter(F_FAM==1) %>% group_by(ANO) %>% summarise(QT_AUTO_ano=sum(QT_AUTO*FE_FAM, na.rm=TRUE),
                                                        QT_AUTO_fam=sum(QT_AUTO, na.rm=TRUE)/sum(F_FAM, na.rm=TRUE))

od_label %>%
  filter(F_FAM==1) %>%
  group_by(ANO) %>%
  summarise(QTA0=sum(ifelse(QT_AUTO==0,
                                  FE_FAM,
                                  0), na.rm=TRUE)/
                       sum(FE_FAM),
            QTA1=sum(ifelse(QT_AUTO==1,
                                    FE_FAM,
                                    0), na.rm=TRUE)/
                         sum(FE_FAM),
            QTA2=sum(ifelse( QT_AUTO>1,
                                              FE_FAM,
                                              0), na.rm=TRUE)/
                                              sum(FE_FAM)) %>% as.data.frame() %>%
  ggplot(
    aes(x=as.integer(ANO), y=value, color=variable)
  ) +
  geom_line(aes(y=QTA0,col='Sem auto')) +
  geom_line(aes(y=QTA1,col='Com 1 automóvel')) +
  geom_line(aes(y=QTA2,col='Com 2 ou mais automóveis')) +
  scale_y_continuous(labels=scales::percent) + # acertando a escala para %
  scale_x_discrete(labels=levels(od_label$ANO)) +
  xlab('Ano') +
  ylab('% de famílias') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 45, hjust=1))




od_label %>%
  filter(F_FAM==1) %>%
  group_by(ANO, SEXO, SIT_FAM) %>%
  summarise(QTA0=sum(ifelse(QT_AUTO==0,
                            FE_FAM,
                            0), na.rm=TRUE)/
              sum(FE_FAM),
            QTA1=sum(ifelse(QT_AUTO==1,
                            FE_FAM,
                            0), na.rm=TRUE)/
              sum(FE_FAM),
            QTA2=sum(ifelse( QT_AUTO>1,
                             FE_FAM,
                             0), na.rm=TRUE)/
              sum(FE_FAM)) %>% as.data.frame() %>% filter(SIT_FAM=="Pessoa responsável")

##### Outras questões sobre QT_AUTO #####

# Quantas viagens são feitas por quem tem automóvel (QT_AUTO!=0) em que essa pessoa
# está dirigindo? Dessas viagens, quantas são feitas por homens e por mulheres,
# em cada ano?

od %>% filter(QT_AUTO!=0, MODO1==3 | MODO2==3 | MODO3==3 | MODO4==3) %>%
  select(SEXO,ANO) %>% table()

# Quantas viagens são feitas por quem tem automóvel (QT_AUTO!=0) em que essa pessoa
# está é passageiro? Dessas viagens, quantas são feitas por homens e por mulheres,
# em cada ano?

od %>% filter(QT_AUTO!=0, MODO1==4 | MODO2==4 | MODO3==4 | MODO4==4) %>%
  select(SEXO,ANO) %>% table()

# Quantas viagens são feitas por quem tem automóvel (QT_AUTO!=0) em que essa pessoa
# está dirigindo e é responsável pela família? Dessas viagens, quantas são feitas
# por homens e por mulheres, em cada ano?

od %>% filter(SIT_FAM==1, QT_AUTO!=0, MODO1==3 | MODO2==3 | MODO3==3 | MODO4==3) %>%
  select(SEXO,ANO) %>% table()

# Quantas viagens são feitas por quem tem automóvel (QT_AUTO!=0) em que essa pessoa
# é passageiro e é responsável pela família? Dessas viagens, quantas são feitas
# por homens e por mulheres, em cada ano?

od %>% filter(SIT_FAM==1, QT_AUTO!=0, MODO1==4 | MODO2==4 | MODO3==4 | MODO4==4) %>%
  select(SEXO,ANO) %>% table()

# Quantas viagens são feitas por quem tem automóvel (QT_AUTO!=0) em que essa pessoa
# está dirigindo e é cônjuge?? Dessas viagens, quantas são feitas
# por homens e por mulheres, em cada ano?

od %>% filter(SIT_FAM==2, QT_AUTO!=0, MODO1==3 | MODO2==3 | MODO3==3 | MODO4==3) %>%
  select(SEXO,ANO) %>% table()

# Quantas viagens são feitas por quem tem automóvel (QT_AUTO!=0) em que essa pessoa
# é passageiro e é cônjuge? Dessas viagens, quantas são feitas
# por homens e por mulheres, em cada ano?

od %>% filter(SIT_FAM==2, QT_AUTO!=0, MODO1==4 | MODO2==4 | MODO3==4 | MODO4==4) %>%
  select(SEXO,ANO) %>% table()

# Quantas viagens são feitas por quem tem automóvel (QT_AUTO!=0) em que essa pessoa
# está dirigindo e é filho(a)/outro parente? Dessas viagens, quantas são feitas
# por homens e por mulheres, em cada ano?

od %>% filter(SIT_FAM==3 | SIT_FAM==4, QT_AUTO!=0, MODO1==3 | MODO2==3 | MODO3==3 | MODO4==3) %>%
  select(SEXO,ANO) %>% table()

# Quantas viagens são feitas por quem tem automóvel (QT_AUTO!=0) em que essa pessoa
# é passageiro e é filho(a)/outro parente? Dessas viagens, quantas são feitas
# por homens e por mulheres, em cada ano?

od %>% filter(SIT_FAM==3 | SIT_FAM==4, QT_AUTO!=0, MODO1==4 | MODO2==4 | MODO3==4 | MODO4==4) %>%
  select(SEXO,ANO) %>% table()


#########################################################
# BOXPLOT da variável TOT_PESS (filtrada por família)
#########################################################
od_label %>%
  filter(F_FAM==1) %>%
  ggplot(
    aes(x=ANO,
        y=TOT_PESS,
        colour=ANO) #este colour é o que faz colorido por ano.
  ) +
  geom_boxplot(alpha=0.5, show.legend=FALSE) + #Plotando o boxplot em si
  scale_y_continuous(breaks = seq(0,80,10)) + # usado para aumentar o espaço para a
  # margem do gráfico para caber o valor.
  xlab('Ano') +
  ylab('Total de pessoas por família') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 30, hjust=1))


###############################################################################
# Distribuição da REN_IND
###############################################################################

#### Histograma - valores absolutos ####
od_label %>%
  filter(F_PESS==1, !is.na(REN_IND)) %>%
  filter(REN_IND<5000, REN_IND>0) %>% # filtro para cortar o limite superior da curva
  ggplot(
    aes(x=REN_IND, fill=ANO)
  ) +
  facet_grid(ANO~.)+
  geom_histogram(binwidth = 250,
                 alpha=0.4,
                 position="identity",
                 show.legend = FALSE)+
  xlab('Renda Individual (R$)') +
  ylab('Frequência absoluta') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 30, hjust=1))

#### Gráfico de linhas ####
od_label %>%
  filter(F_PESS==1, !is.na(REN_IND)) %>%
  ggplot(
    aes(x=REN_IND, fill=NULL, colour=ANO)
  ) +
  geom_line(stat="density",alpha=1, size=1.2) + # Geom_density plota as densidades (freq. rel)
  scale_y_continuous(labels=scales::percent)+ # acertando a escala para %
  xlim(0.1, 10000) +
  xlab('REN_FAM') +
  ylab('Frequência relativa') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 30, hjust=1))

#### Histograma de faixas de renda individual ####
od_label %>%
  filter(F_PESS==1, FAIXA_REN_IND!="Sem renda", !is.na(FAIXA_REN_IND)) %>%
  ggplot(
    aes(x=FAIXA_REN_IND,
        fill=ANO) # Colore 'por sexo'
       # weight=FE_PESS) # Ponderando por FE_PESS
  ) +
  facet_grid(ANO ~ .) + # Aqui cria o 'grid' ANO x SEXO
  geom_bar(aes(y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..]),
           alpha=0.5,
           show.legend = FALSE) + # Plota o gráfico de barras
  stat_count(geom="text", # E esse stat count serve para colocar o valor
             aes(y=(..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..],
                 label=paste0(
                   round(
                     (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..]*100,
                     2),
                   '%')
             ),
             size=3,
             color=.mestrado.cor.elementos.gerais,
             vjust=-0.5) +
  scale_y_continuous(labels=scales::percent, expand=c(0.15, 0)) + # usado para aumentar o espaço para a
  # margem do gráfico para caber o valor.
  xlab('Faixas de Renda Individual') +
  ylab('Frequência relativa') +
  theme_light() +
  theme(plot.title = element_text(lineheight=1.6, face="bold", size="26"),
        axis.text = element_text(color=.mestrado.cor.elementos.gerais, size="20"),
        axis.title = element_text(color=.mestrado.cor.elementos.gerais, size="24"),
        axis.text.x = element_text(angle = 45, hjust=1))



### Outras estatísticas ###


CrossTable (od_filtrado$SEXO, od_filtrado$ANO)
xtabs(data=od_filtrado, ~ANO+SEXO+ESTUDA)
od_filtrado %>% group_by(ANO,SEXO) %>% summarise(ESTUDA1=sum(FE_PESS*ESTUDA))
od_filtrado %>% group_by(ANO,SEXO) %>% summarise(ESTUDA1=sum(FE_PESS*ESTUDA)/sum(FE_PESS))

xtabs(data=od_filtrado, ~ANO+SEXO+TRABALHA)
od_filtrado %>% group_by(ANO,SEXO) %>% summarise(TRABALHA1=sum(FE_PESS*TRABALHA, na.rm=TRUE))
od_filtrado %>% group_by(ANO,SEXO) %>% summarise(TRABALHA1=sum(FE_PESS*TRABALHA, na.rm=TRUE)/sum(FE_PESS, na.rm=TRUE))

od_filtrado %>% filter(ANO==1, PESS_MOTIVO_SERV_PAS==1,
                       !is.na(ZONA_ESC), ZONA_ESC>0 ) %>% nrow()

od %>% filter(SERV_PAS_DEST==1, ZONA_DEST==ZONA_ESC, SUBZONA_DEST==SUBZONA_ESC,
              ANO==1) %>% select(ESTUDA, ID_PESS) %>% count(ID_PESS)
