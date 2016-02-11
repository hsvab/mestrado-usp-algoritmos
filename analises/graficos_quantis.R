library(quantreg)
library(dplyr)
library(ggplot2)
# od_reg_1 é o banco de dados usado para regressão, filtrado por:
# pessoa (F_PESS=1)
# mulher (SEXO==2)
# pessoa responsável pela família (SIT_FAM==1)
dt <- od %>%
    filter(SEXO==2, F_PESS==1, SIT_FAM==1) %>%
    rq(TOT_VIAG ~ REN_IND, tau=0.40, data=., na.action(na.omit)) %>% summary()

od %>%
    filter(SEXO==2, F_PESS==1, SIT_FAM==1) %>%
    lm(DURACAO ~ PRESENCA_FILH_ate4, data=.) %>%
    summary()

plota_distribuicao_quantilica <- function(VAR, nome) {
    VAR <- VAR[!is.na(VAR)]
    n <- length(VAR)
    prob = (1:n)/(n+1)
    normal.quantiles <- qnorm(prob, mean(VAR, na.rm=T), sd(VAR, na.rm=T))
    data <- as.data.frame(cbind(VAR,normal.quantiles))
    data %>% ggplot(aes(x=sort(normal.quantiles),y=sort(VAR)))+
        geom_hex(bins=50, size=15) +
        geom_abline(intercept=0, slope=1) +
        ggtitle(paste('Gráfico Quantil normal x Quantil da variável ', nome)) +
        xlab('Quantis teóricos da distribuição normal') +
        ylab(paste('Quantis da distribuição da variável ', nome))
}

plota_distribuicao_quantilica(od$TOT_VIAG, "Total de Viagens")
plota_distribuicao_quantilica(od$DIST_VIAG, "DIST_VIAG")
plota_distribuicao_quantilica(od$DURACAO, "DURACAO")

od %>% filter(ZONA_ORIG<250, ZONA_DEST<250) %>% ggplot(aes(x=sort(ZONA_ORIG),y=sort(ZONA_DEST)))+
    geom_point( size=1 ) + geom_density2d() +
    geom_abline()

qqnorm(od$TOT_VIAG)
