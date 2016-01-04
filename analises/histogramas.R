library(ggplot2)

od$SEXO <- factor(od$SEXO,
                  levels=c(1,2),
                  labels=c("MASC","FEM"))

ggplot(od,aes(x=PESS_NO_MOTIVOS, fill=SEXO))+geom_histogram(binwidth=0.5, position='identity', colour='red', fill='red', alpha=0.2)