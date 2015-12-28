library(dplyr)
library(ggplot2)
setwd("~/haydee/mestrado/mestrado-usp-algoritmos/analises")

# #Plotando histograma, por ano, das distâncias viagem
# ggplot(od,aes(x=as.numeric(DIST_VIAG),fill=as.factor(ANO))) +
#     geom_histogram(binwidth=5,position="dodge")

################################################################################
# Realizando substituição das distâncias (DIST_VIAG) com base na consulta aos
# cálculos de distância realizaods com o software QGis, com referência ao
# centróide das zonas (1977) e das das subzonas (1987 e 1997).
# O resultado fornecido tem como unidade de medida Metro.
################################################################################
# Função que transforma dois números em uma string no formato "001-01",
# formado constante no mapa de 1997. Sempre com 3 dígitos para zona e
# 2 para subzona.
codifica97 <- function(zona, subzona) {
    codificado = paste(
            sprintf("%03d", as.integer(trimws(zona))),    # Formato: XXX
            sprintf("%02d", as.integer(trimws(subzona))), # Formato: XX
            sep="-"
        )
    return(codificado)
}
# Formato de codificação do mapa de 87: Zona.Subzona (sem zeros à esquerda)
codifica87 <- function(zona, subzona) {
    codificado = paste(
        trimws(zona),    # Formato: XXX
        trimws(subzona), # Formato: XX
        sep="."
        )
    return(codificado)
}

# Lendo os arquivos com as distâncias:
matriz77 <- read.table('../CSVs-auxiliares/matriz_distancias_1977.csv', header=TRUE,
                       sep=',', dec='.')
matriz87 <- read.table('../CSVs-auxiliares/matriz_distancias_1987.csv', header=TRUE,
                       sep=',', dec='.')
matriz97 <- read.table('../CSVs-auxiliares/matriz_distancias_1997.csv', header=TRUE,
                       sep=',', dec='.')

# Unindo das matrizes de distância de 77, 87 e 97
## Primeiro adiciona uma nova coluna em cada matriz com o ano da mesma.
matriz77$ANO_DADO <- 1
matriz87$ANO_DADO <- 2
matriz97$ANO_DADO <- 3
## Agora uni as três numa nova:
distancias <- rbind(matriz77, matriz87, matriz97)

# Removendo as matrizes de distância de cada um dos anos
rm(matriz77)
rm(matriz87)
rm(matriz97)

# Lendo a base OD mais atual
od <- read.table('../../../mestrado/mestrado-usp-ODs/banco unico - pols/od-10.csv.bz2',
                 header=TRUE, sep=';', dec=',',
                 colClasses = c(
                     'ID_PESS'='character',
                     'ID_VIAG'='character',
                     'ID_DOM'='character',
                     'ID_FAM'='character')
        )

# Lendo a OD-08, que contém a distância correta para 2007
od08 <- read.table('../../../mestrado/mestrado-usp-ODs/banco unico - pols/od-8.csv.bz2',
                   header=TRUE, sep=';', dec=',',
                   colClasses = c(
                       'ID_PESS'='character',
                       'ID_VIAG'='character',
                       'ID_DOM'='character',
                       'ID_FAM'='character')
        )

# Substintuindo a variável DIST_VIAG em "od" pela DIST_VIAG de "od08"
od$DIST_VIAG <- od08$DIST_VIAG

# Removendo od08, que agora não é mais necessário:
rm(od08)

# Gerando variáveis auxiliares de origem e destino para consultar distâncias,
# seguindo o padrão de cada ano constante nos mapas fornecidos.
od <- od %>%
    mutate(ORIGEM=ifelse(ANO=="1",
                         ZONA_ORIG,
                         ifelse(ANO=="2",
                                codifica87(ZONA_ORIG, SUBZONA_ORIG),
                                ifelse(ANO=="3",
                                codifica97(ZONA_ORIG, SUBZONA_ORIG),
                                NA
                            )
                         )
                    )
    ) %>%
    mutate(DESTINO=ifelse(ANO=="1",
                         ZONA_DEST,
                         ifelse(ANO=="2",
                                codifica87(ZONA_DEST, SUBZONA_DEST),
                                ifelse(ANO=="3",
                                codifica97(ZONA_DEST, SUBZONA_DEST),
                                NA
                            )
                        )
                    )
    )

# Removendo as funções codifica87 e codifica97, que já foram utilizadas
rm(codifica87)
rm(codifica97)

# Criando uma coluna chamada "Distance" no dataframe OD, por meio da junção
# do dataframe OD com o distancias, unindo com base em:
# ORIGEM == InputID
# DESTINO == TargetID
# ANO == ANO_DADO
od <- left_join(od,
                distancias,
                by=c('ORIGEM'='InputID','DESTINO'='TargetID','ANO'='ANO_DADO')
        )

# Removendo dataframe já utilizado distancias
rm(distancias)

# Substituindo, para os anos 1977, 1987 e 1997, o valor em DIST_VIAG pelo valor
# da coluna Distance
od <- od %>%
        mutate(DIST_VIAG = ifelse(
            ANO==4,
            DIST_VIAG,
            Distance
            )
        )

# Removendo as colunas Distance, ORIGEM e DESTINO (não mais necessárias)
od$Distance <- NULL
od$ORIGEM <- NULL
od$DESTINO <- NULL

##############################
# Realizando algumas correções
#
# Correção 1: Se F_VIAG for igual a zero, então DIST_VIAG receberá NA
od <- od %>%
        mutate(DIST_VIAG = ifelse(
            F_VIAG==0,
            NA,
            DIST_VIAG
            )
        )
# Correção 2: Se F_VIAG for igual a 1, mas ZONA_ORIG == ZONA_DEST
# então DIST_VIAG recebe ZERO
od <- od %>%
    mutate(DIST_VIAG = ifelse(
        ZONA_ORIG==ZONA_DEST,
        0,
        DIST_VIAG
        )
    )
# Correção 3: Se F_VIAG for igual a 1, mas:
# ZONA_ORIG == 0 ou ZONA_ORIG == 999 ou
# ZONA_DEST == 0 ou ZONA_DEST == 999,
# então DIST_VIAG receberá NA
od <- od %>%
        mutate(DIST_VIAG = ifelse(
            ZONA_ORIG==0 | ZONA_DEST==0 |
            ZONA_ORIG==999 | ZONA_DEST==999,
            NA,
            DIST_VIAG
            )
        )

write.table(od,
            file="../../../mestrado/mestrado-usp-ODs/banco unico - pols/od-10.csv",
            sep =';',
            dec=',',
            row.names = FALSE)


################################################################################
###                             PLOTS
################################################################################
coresSEXO = c("#0072B2", "#D55E00") # Homens, Mulheres

# Plotando distância média por ano e por sexo
#png(file = "distancia_media_percorrida.png")
od %>%
    filter(!is.na(DIST_VIAG)) %>% # Removendo NA's
    group_by(ANO, SEXO) %>% # Agrupa por ANO e SEXO para sumarizar
    summarise(distancia.media = mean(DIST_VIAG)) %>% # Calcula a média
    as.data.frame() %>% # Transforma o resultado num dataframe com ANO, SEXO e distancia.media
    mutate(
        ANO = factor(ANO, levels=c(1,2,3,4), labels=c("1977","1987","1997","2007")),
        SEXO = factor(SEXO, labels=c("MASC","FEM"))
    ) %>% # Aplica as labels às variáveis ANO e SEXO
    ggplot(aes(x=ANO, y=distancia.media, fill=SEXO, group=SEXO, colour=SEXO)) +
        geom_histogram(stat="identity", position="dodge", alpha=0.2) + # Histograma
        geom_smooth(method=lm, alpha=0.1) + # Reta de ajuste com "lm"
        ylab("Distância Média (m)") + # Configurando título do eixo Y
        xlab("Ano") + # configurando título do eixo X
        ggtitle("Distância média de viagem, por sexo e ano") + # Configurando título
        scale_colour_manual(values = coresSEXO) + # Configurando cores
        scale_fill_manual(values = coresSEXO) # Configurando cores
#dev.off()

# Plotando distâncias por ano e por sexo (1 plot com 8 linhas)
#png(file = "distribuicao_de_distancias.png")
od %>%
    filter(!is.na(DIST_VIAG)) %>% # Removendo DIST_VIAG == NA
    mutate(
        ANO = factor(ANO,
                     levels=c(1,2,3,4),
                     labels=c("1977","1987","1997","2007")
                ),
        SEXO = factor(SEXO, labels=c("MASC","FEM"))
    ) %>% # Aplica as labels às variáveis ANO e SEXO
    filter(
        DIST_VIAG < quantile(DIST_VIAG, 0.75)
    ) %>% # Filtrando no quantil 90%
    ggplot(
        aes(x=DIST_VIAG, fill=NULL, colour=interaction(SEXO,ANO), group=interaction(SEXO,ANO))
    ) + geom_density(alpha=0.2) +
    ylab("Densidade de viagens") +
    xlab("Distância da viagem") +
    ggtitle("Distribuição de viagens por sexo e ano (3 quartis)") # Configurando título
#dev.off()

# Plotando distâncias por ano e por sexo (8 plots em quadro)
#png(file = "distribuicao_de_distancias.png")
od %>%
    filter(!is.na(DIST_VIAG)) %>% # Removendo DIST_VIAG == NA
    mutate(
        ANO = factor(ANO,
                     levels=c(1,2,3,4),
                     labels=c("1977","1987","1997","2007")
        ),
        SEXO = factor(SEXO, labels=c("MASC","FEM"))
    ) %>% # Aplica as labels às variáveis ANO e SEXO
    filter(
        DIST_VIAG < quantile(DIST_VIAG, 0.75)
    ) %>% # Filtrando no quantil 90%
    ggplot(
        aes(x=DIST_VIAG, fill=SEXO, colour=SEXO)
    ) + geom_density(alpha=0.2) +
    facet_grid(SEXO ~ ANO) +
    ylab("Densidade de viagens") +
    xlab("Distância da viagem") +
    ggtitle("Distribuição de viagens por sexo e ano (3 quartis)") + # Configurando título
    scale_colour_manual(values = coresSEXO) + # Configurando cores
    scale_fill_manual(values = coresSEXO) # Configurando cores
#dev.off()

# ################# TESTES ##########################
# # 1977
# teste %>% filter(ANO==1) %>% select(F_VIAG) %>% table() %>% as.data.frame()
#
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG!=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_DEST!=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG!=0, ZONA_DEST!=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST!=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG!=0, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% nrow()
#
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG!=0, ZONA_DEST!=0) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG!=0, ZONA_DEST!=0) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST!=0) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST!=0) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG!=0, ZONA_DEST==0) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG!=0, ZONA_DEST==0) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
#
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_DEST!=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG==0, ZONA_DEST!=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG==0, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% nrow()
#
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG==0, ZONA_DEST!=0) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG==0, ZONA_DEST!=0) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG==0, ZONA_DEST==0) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG==0, ZONA_DEST==0) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST==0) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==1, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST==0) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
#
# # 1987
# teste %>% filter(ANO==2) %>% select(F_VIAG) %>% table() %>% as.data.frame()
#
# teste %>% filter(ANO==2, F_VIAG==0, ZONA_ORIG==0) %>% nrow()
# teste %>% filter(ANO==2, F_VIAG==0, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==2, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==2, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==2, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
#
# teste %>% filter(ANO==2, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0) %>% nrow()
# teste %>% filter(ANO==2, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% nrow()
# teste %>% filter(ANO==2, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==2, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
# teste %>% filter(ANO==2, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% nrow()
# teste %>% filter(ANO==2, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==2, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
#
# # 1997
# teste %>% filter(ANO==3) %>% select(F_VIAG) %>% table() %>% as.data.frame()
#
# teste %>% filter(ANO==3, F_VIAG==0, ZONA_ORIG==0) %>% nrow()
# teste %>% filter(ANO==3, F_VIAG==0, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==3, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==3, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==3, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
#
# teste %>% filter(ANO==3, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0) %>% nrow()
# teste %>% filter(ANO==3, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% nrow()
# teste %>% filter(ANO==3, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==3, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
# teste %>% filter(ANO==3, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% nrow()
# teste %>% filter(ANO==3, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==3, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()
#
# # 2007
# teste %>% filter(ANO==4) %>% select(F_VIAG) %>% table() %>% as.data.frame()
#
# teste %>% filter(ANO==4, F_VIAG==0, ZONA_ORIG==0) %>% nrow()
# teste %>% filter(ANO==4, F_VIAG==0, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==4, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% nrow()
# teste %>% filter(ANO==4, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==4, F_VIAG==0, ZONA_ORIG==0, ZONA_DEST==0) %>% filter(!is.na(Distance),  Distance!=0) %>% nrow()
#
# teste %>% filter(ANO==4, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0) %>% nrow()
# teste %>% filter(ANO==4, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% nrow()
# teste %>% filter(ANO==4, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==4, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG!=ZONA_DEST) %>% filter(!is.na(Distance), Distance!=0) %>% nrow()
# teste %>% filter(ANO==4, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% nrow()
# teste %>% filter(ANO==4, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% filter(is.na(Distance) | Distance==0) %>% nrow()
# teste %>% filter(ANO==4, F_VIAG==1, ZONA_ORIG!=0, ZONA_DEST!=0, ZONA_ORIG==ZONA_DEST) %>% filter(!is.na(Distance), Distance !=0) %>% nrow()