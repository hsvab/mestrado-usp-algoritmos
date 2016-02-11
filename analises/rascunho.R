library(dplyr)
od7 <- od %>% filter(F_FAM==1)
CrossTable(od7$famcluster3_ward, od8$ANO, prop.r = TRUE, prop.c = TRUE, prop.t = FALSE, prop.chisq = FALSE)
CrossTable(od7$famcluster3_centroide, od8$ANO, prop.r = TRUE, prop.c = TRUE, prop.t = FALSE, prop.chisq = FALSE)

od8 <- od %>% filter(F_PESS==1)
CrossTable(od8$pesscluster3_ward, od8$ANO, prop.r = TRUE, prop.c = TRUE, prop.t = FALSE, prop.chisq = FALSE)
CrossTable(od8$pesscluster3_centroide, od8$ANO, prop.r = TRUE, prop.c = TRUE, prop.t = FALSE, prop.chisq = FALSE)


od <- od %>% mutate (QT_AUTO_EXP=QT_AUTO*FE_FAM)
od %>% filter(ANO==1, F_FAM==1) %>% summarise(soma=sum(QT_AUTO_EXP,na.rm=TRUE))
od %>% filter(ANO==2, F_FAM==1) %>% summarise(soma=sum(QT_AUTO_EXP,na.rm=TRUE))
od %>% filter(ANO==3, F_FAM==1) %>% summarise(soma=sum(QT_AUTO_EXP,na.rm=TRUE))
od %>% filter(ANO==4, F_FAM==1) %>% summarise(soma=sum(QT_AUTO_EXP,na.rm=TRUE))

od1 <- read.csv(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-11.csv",
                header = TRUE, sep = ";", dec = ",", colClasses = c("ID_DOM"="character", "ID_FAM"="character",
                                                                    "ID_PESS"="character", "ID_VIAG"="character"))

od %>% write.table(file = "/home/haydee/Área de trabalho/mestrado-PTR/OD/Consolidado/banco unico - pols/od-14.csv",
                   sep = ";", dec = ",", row.names = FALSE)
