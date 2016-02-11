#####################################
### Regressões logísticas por ano ###
#####################################

od_filtrado <- od %>% filter(F_FAM==1) %>% select(ID_FAM, ANO_77, ANO_87, ANO_97, ANO_07,
                                                  ANO, FAM_VIAG_TOT, FAM_DIST_TOT, FAM_DIST_MED,
                                                  FAM_DURACAO_TOT, FAM_DURACAO_MED)

od_filtrado$ANO <- as.factor(od_filtrado$ANO)

Z_77 <- glm(formula = ANO_77 ~ FAM_VIAG_TOT + FAM_DIST_TOT + FAM_DIST_MED + FAM_DURACAO_TOT +
              FAM_DURACAO_MED, family = binomial, data = od_filtrado)
summary(Z_77)

Z_87 <- glm(formula = ANO_87 ~ FAM_VIAG_TOT + FAM_DIST_TOT + FAM_DIST_MED + FAM_DURACAO_TOT +
              FAM_DURACAO_MED, family = binomial, data = od_filtrado)
summary(Z_87)

Z_97 <- glm(formula = ANO_97 ~ FAM_VIAG_TOT + FAM_DIST_TOT + FAM_DIST_MED + FAM_DURACAO_TOT +
              FAM_DURACAO_MED, family = binomial, data = od_filtrado)
summary(Z_97)

Z_07 <- glm(formula = ANO_07 ~ FAM_VIAG_TOT + FAM_DIST_TOT + FAM_DIST_MED + FAM_DURACAO_TOT +
              FAM_DURACAO_MED, family = binomial, data = od_filtrado)
summary(Z_07)


#######################################
### Regressão multinomial logística ###
#######################################

# http://statistics.ats.ucla.edu/stat/r/dae/mlogit.htm
# Do pacote nnet
od_filtrado <- od %>% filter(F_FAM==1) %>% select(ID_FAM, ANO, FAM_VIAG_TOT, FAM_DIST_TOT, FAM_DIST_MED, FAM_DURACAO_TOT, FAM_DURACAO_MED)
od_filtrado$ANO <- as.factor(od_filtrado$ANO)
od_filtrado$ANO2 <- relevel(od_filtrado$ANO, ref="4")
teste <- multinom(ANO2~FAM_VIAG_TOT + FAM_DIST_TOT + FAM_DIST_MED + FAM_DURACAO_TOT + FAM_DURACAO_MED,
                  data = od_filtrado)
summary(teste)
exp(coef(teste))

#
# Tentando regressão logística múltipla  com o mlogit (do Croissant)
#
# od_reg_logit <- mlogit.data(data = od_filtrado, shape = "long", choice = 'ANO',
#                            alt.levels = c("1","2","3","4"), chid.var = 'ID_FAM',
#                            drop.index = TRUE)
#
# Z <- mlogit(ANO ~ FAM_VIAG_TOT + FAM_DIST_TOT + FAM_DIST_MED + FAM_DURACAO_TOT + FAM_DURACAO_MED,
#       data = od_reg_logit, reflevel = '4', shape = 'long')
#
# summary(Z)


save.dta13(od_filtrado, "/home/haydee/Área de trabalho/mestrado-PTR/ALGORITMOS/analises/regressoes/od_filtrado_reg_log.dta",
           time.stamp = FALSE, convert.dates = FALSE, version = 11)
