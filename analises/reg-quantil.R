install.packages("quantreg")
library(quantreg)

fit1 <- rq(formula = ANO_77 ~ FAM_VIAG_TOT + FAM_DIST_TOT + FAM_DIST_MED + FAM_DURACAO_TOT +
             FAM_DURACAO_MED,, tau = .5, data = od_filtrado)
summary(fit1)
