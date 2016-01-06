library(dplyr)
setwd("~/haydee/mestrado/mestrado-usp-algoritmos/analises")
od_77 <- read.table('../../mestrado-usp-ODs/bancos-separados/1977_od.csv', sep=';', dec=',', header=TRUE,
                        colClasses = c(
                        'ID_PESS'='character',
                        'ID_VIAG'='character',
                        'ID_DOM'='character',
                        'ID_FAM'='character')
)
od_87 <- read.table('../../mestrado-usp-ODs/bancos-separados/1987_od.csv', sep=';', dec=',', header=TRUE,
                        colClasses = c(
                        'ID_PESS'='character',
                        'ID_VIAG'='character',
                        'ID_DOM'='character',
                        'ID_FAM'='character')
)
od_97 <- read.table('../../mestrado-usp-ODs/bancos-separados/1997_od.csv', sep=';', dec=',', header=TRUE,
                        colClasses = c(
                        'ID_PESS'='character',
                        'ID_VIAG'='character',
                        'ID_DOM'='character',
                        'ID_FAM'='character')
)
od_07 <- read.table('../../mestrado-usp-ODs/bancos-separados/2007_od.csv', sep=';', dec=',', header=TRUE,
                        colClasses = c(
                        'ID_PESS'='character',
                        'ID_VIAG'='character',
                        'ID_DOM'='character',
                        'ID_FAM'='character')
)

#Corrigindo tipo das variáveis entre os anos
#campos77 = sapply(od_77,typeof)
#campos87 = sapply(od_87,typeof)
#campos97 = sapply(od_97,typeof)
#campos07 = sapply(od_07,typeof)
#teste <- data.frame(campos77, campos87, campos97, campos07)
#teste$CHECK01 <-    campos77==campos87 &
#                    campos87==campos97 &
#                    campos97==campos07

## 77
od_77$DIA_SEM <- as.integer(od_77$DIA_SEM)
od_77$QT_BICI <- as.integer(od_77$QT_BICI)
od_77$QT_MOTO <- as.integer(od_77$QT_MOTO)
od_77$DIST_VIAG <- as.double(od_77$DIST_VIAG)
od_77$MODO4 <- as.integer(od_77$MODO4)

## 87
od_87$QT_BICI <- as.integer(od_87$QT_BICI)
od_87$QT_MOTO <- as.integer(od_87$QT_MOTO)
od_87$DIST_VIAG <- as.double(od_87$DIST_VIAG)
od_87$MODO4 <- as.integer(od_87$MODO4)
od_87$VALOR_EST_AUTO <- as.double(od_87$VALOR_EST_AUTO)

## 97
od_97$QT_BICI <- as.integer(od_97$QT_BICI)
od_97$QT_MOTO <- as.integer(od_97$QT_MOTO)
od_97$DIST_VIAG <- as.double(od_97$DIST_VIAG)
od_97$TIPO_EST_AUTO <- as.integer(od_97$TIPO_EST_AUTO)
od_97$VALOR_EST_AUTO <- as.double(od_97$VALOR_EST_AUTO)

## 07
od_07$SUBZONA_DOM <- as.integer(od_07$SUBZONA_DOM)
od_07$SUBZONA_ESC <- as.integer(od_07$SUBZONA_ESC)
od_07$SUBZONA_TRAB1 <- as.integer(od_07$SUBZONA_TRAB1)
od_07$SUBZONA_TRAB2 <- as.integer(od_07$SUBZONA_TRAB2)
od_07$SUBZONA_ORIG <- as.integer(od_07$SUBZONA_ORIG)
od_07$SUBZONA_DEST <- as.integer(od_07$SUBZONA_DEST)
od_07$CO_DOM_X <- as.double(od_07$CO_DOM_X)
od_07$CO_ESC_X <- as.double(od_07$CO_ESC_X)
od_07$CO_TRAB1_X <- as.integer(od_07$CO_TRAB1_X)
od_07$CO_TRAB2_X <- as.integer(od_07$CO_TRAB2_X)
od_07$CO_ORIG_X <-  as.integer(od_07$CO_ORIG_X)
od_07$CO_DEST_X <-  as.integer(od_07$CO_DEST_X)

od <- rbind(od_77, od_87, od_97, od_07)

#camposOD <- sapply(od, FUN=typeof)
#teste$camposOD <- camposOD
#teste$CHECK02 <-    campos77==campos87 &
#                    campos87==campos97 &
#                    campos97==campos07 &
#                    campos07==camposODv

# Removendo variáveis geradas não mais necessárias
rm(od_07, od_77, od_87, od_97, teste, campos07, campos87, campos97, campos77, camposOD)

# Salvando base unificada
write.table(od,
            file="../../mestrado-usp-ODs/banco unico - pols/od.csv",
            sep =';',
            dec=',',
            row.names = FALSE)