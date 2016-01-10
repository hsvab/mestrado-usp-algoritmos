library(dplyr)
library(psych)
library(plyr)

# numero de registros total
nrow(od)

# número de registros por ano
od %>% filter(ANO==1) %>% nrow()
od %>% filter(ANO==2) %>% nrow()
od %>% filter(ANO==3) %>% nrow()
od %>% filter(ANO==4) %>% nrow()

# numero total de viagens
od %>% filter(F_VIAG==1) %>% nrow()

# número de viagens por ano
od %>% filter(ANO==1, F_VIAG==1) %>% nrow()
od %>% filter(ANO==2, F_VIAG==1) %>% nrow()
od %>% filter(ANO==3, F_VIAG==1) %>% nrow()
od %>% filter(ANO==4, F_VIAG==1) %>% nrow()

# numero total de pessoas
od %>% filter(F_PESS==1) %>% nrow()

# número de pessoas por ano
od %>% filter(ANO==1, F_PESS==1) %>% nrow()
od %>% filter(ANO==2, F_PESS==1) %>% nrow()
od %>% filter(ANO==3, F_PESS==1) %>% nrow()
od %>% filter(ANO==4, F_PESS==1) %>% nrow()

# numero total de famílias
od %>% filter(F_FAM==1) %>% nrow()

# número de famílias por ano
od %>% filter(ANO==1, F_FAM==1) %>% nrow()
od %>% filter(ANO==2, F_FAM==1) %>% nrow()
od %>% filter(ANO==3, F_FAM==1) %>% nrow()
od %>% filter(ANO==4, F_FAM==1) %>% nrow()

# numero de registros total no famcluster2
od$famcluster2 %>% table()
# numero de viagens no famcluster2
od %>% filter(F_VIAG==1) %>% select (famcluster2) %>% table()
# numero de pessoas no famcluster2
od %>% filter(F_PESS==1) %>% select (famcluster2) %>% table()
# numero de famílias no famcluster2
od %>% filter(F_FAM==1) %>% select (famcluster2) %>% table()

# numero de registros total no famcluster4
od$famcluster4 %>% table()
# numero de viagens no famcluster4
od %>% filter(F_VIAG==1) %>% select (famcluster4) %>% table()
# numero de pessoas no famcluster4
od %>% filter(F_PESS==1) %>% select (famcluster4) %>% table()
# numero de famílias no famcluster4
od %>% filter(F_FAM==1) %>% select (famcluster4) %>% table()

# numero de registros total no famcluster9
od$famcluster9 %>% table()
# numero de viagens no famcluster9
od %>% filter(F_VIAG==1) %>% select (famcluster9) %>% table()
# numero de pessoas no famcluster9
od %>% filter(F_PESS==1) %>% select (famcluster9) %>% table()
# numero de famílias no famcluster9
od %>% filter(F_FAM==1) %>% select (famcluster9) %>% table()

# numero de registros total no pesscluster2
od$pesscluster2 %>% table()
# numero de viagens no pesscluster2
od %>% filter(F_VIAG==1) %>% select (pesscluster2) %>% table()
# numero de pessoas no pesscluster2
od %>% filter(F_PESS==1) %>% select (pesscluster2) %>% table()
# numero de famílias no pesscluster2
od %>% filter(F_FAM==1) %>% select (pesscluster2) %>% table()

# numero de registros total no pesscluster4
od$pesscluster4 %>% table()
# numero de viagens no pesscluster4
od %>% filter(F_VIAG==1) %>% select (pesscluster4) %>% table()
# numero de pessoas no pesscluster4
od %>% filter(F_PESS==1) %>% select (pesscluster4) %>% table()
# numero de famílias no pesscluster4
od %>% filter(F_FAM==1) %>% select (pesscluster4) %>% table()

#
#
# estatística descritiva da média da distância total da pessoa para toda a base
od %>% filter(F_PESS==1) %>% select(PESS_DIST_TOT) %>% describe()

# estatística descritiva da média da distância total da pessoa por ano
od %>% filter(F_PESS==1, ANO==1) %>% select(PESS_DIST_TOT) %>% describe()
od %>% filter(F_PESS==1, ANO==2) %>% select(PESS_DIST_TOT) %>% describe()
od %>% filter(F_PESS==1, ANO==3) %>% select(PESS_DIST_TOT) %>% describe()
od %>% filter(F_PESS==1, ANO==4) %>% select(PESS_DIST_TOT) %>% describe()

# estatística descritiva da média da distância total da pessoa por famcluster2
od %>% filter(F_PESS==1) %>% select(PESS_DIST_TOT, famcluster2) %>% describeBy(group='famcluster2')
# estatística descritiva da média da distância total da pessoa por famcluster4
od %>% filter(F_PESS==1) %>% select(PESS_DIST_TOT, famcluster4) %>% describeBy(group='famcluster4')
# estatística descritiva da média da distância total da pessoa por famcluster9
od %>% filter(F_PESS==1) %>% select(PESS_DIST_TOT, famcluster9) %>% describeBy(group='famcluster9')

# estatística descritiva da média da distância total da pessoa por pesscluster2
od %>% filter(F_PESS==1) %>% select(PESS_DIST_TOT, pesscluster2) %>% describeBy(group='pesscluster2')
# estatística descritiva da média da distância total da pessoa por pesscluster4
od %>% filter(F_PESS==1) %>% select(PESS_DIST_TOT, pesscluster4) %>% describeBy(group='pesscluster4')

# estatística descritiva da média da distância total da pessoa para toda a base
od %>% filter(F_PESS==1) %>% select(FAM_DIST_TOT) %>% describe()

# estatística descritiva da média da distância total da pessoa por ano
od %>% filter(F_PESS==1, ANO==1) %>% select(FAM_DIST_TOT) %>% describe()
od %>% filter(F_PESS==1, ANO==2) %>% select(FAM_DIST_TOT) %>% describe()
od %>% filter(F_PESS==1, ANO==3) %>% select(FAM_DIST_TOT) %>% describe()
od %>% filter(F_PESS==1, ANO==4) %>% select(FAM_DIST_TOT) %>% describe()

# estatística descritiva da média da distância total da pessoa por famcluster2
od %>% filter(F_PESS==1) %>% select(FAM_DIST_TOT, famcluster2) %>% describeBy(group='famcluster2')
# estatística descritiva da média da distância total da pessoa por famcluster4
od %>% filter(F_PESS==1) %>% select(FAM_DIST_TOT, famcluster4) %>% describeBy(group='famcluster4')
# estatística descritiva da média da distância total da pessoa por famcluster9
od %>% filter(F_PESS==1) %>% select(FAM_DIST_TOT, famcluster9) %>% describeBy(group='famcluster9')

# estatística descritiva da média da distância total da pessoa por pesscluster2
od %>% filter(F_PESS==1) %>% select(FAM_DIST_TOT, pesscluster2) %>% describeBy(group='pesscluster2')
# estatística descritiva da média da distância total da pessoa por pesscluster4
od %>% filter(F_PESS==1) %>% select(FAM_DIST_TOT, pesscluster4) %>% describeBy(group='pesscluster4')


# estatística descritiva do número médio de viagens da pessoa para toda a base
od %>% filter(F_PESS==1) %>% select(TOT_VIAG) %>% describe()

# estatística descritiva da média do número médio de viagens da pessoa por ano
od %>% filter(F_PESS==1, ANO==1) %>% select(TOT_VIAG) %>% describe()
od %>% filter(F_PESS==1, ANO==2) %>% select(TOT_VIAG) %>% describe()
od %>% filter(F_PESS==1, ANO==3) %>% select(TOT_VIAG) %>% describe()
od %>% filter(F_PESS==1, ANO==4) %>% select(TOT_VIAG) %>% describe()

# estatística descritiva da média do número médio de viagens da pessoa por famcluster2
od %>% filter(F_PESS==1) %>% select(TOT_VIAG, famcluster2) %>% describeBy(group='famcluster2')
# estatística descritiva da média da distância total da pessoa por famcluster4
od %>% filter(F_PESS==1) %>% select(TOT_VIAG, famcluster4) %>% describeBy(group='famcluster4')
# estatística descritiva da média da distância total da pessoa por famcluster9
od %>% filter(F_PESS==1) %>% select(TOT_VIAG, famcluster9) %>% describeBy(group='famcluster9')

# estatística descritiva da média do número médio de viagens da pessoa por pesscluster2
od %>% filter(F_PESS==1) %>% select(TOT_VIAG, pesscluster2) %>% describeBy(group='pesscluster2')
# estatística descritiva da média da distância total da pessoa por pesscluster4
od %>% filter(F_PESS==1) %>% select(TOT_VIAG, pesscluster4) %>% describeBy(group='pesscluster4')

##
##
# estatística descritiva do número médio de viagens da famílis para toda a base
od %>% filter(F_FAM==1) %>% select(FAM_VIAG_TOT) %>% describe()

# estatística descritiva da média do número médio de viagens da família por ano
od %>% filter(F_FAM==1, ANO==1) %>% select(FAM_VIAG_TOT) %>% describe()
od %>% filter(F_FAM==1, ANO==2) %>% select(FAM_VIAG_TOT) %>% describe()
od %>% filter(F_FAM==1, ANO==3) %>% select(FAM_VIAG_TOT) %>% describe()
od %>% filter(F_FAM==1, ANO==4) %>% select(FAM_VIAG_TOT) %>% describe()

# estatística descritiva da média do número médio de viagens da família por famcluster2
od %>% filter(F_FAM==1) %>% select(FAM_VIAG_TOT, famcluster2) %>% describeBy(group='famcluster2')
# estatística descritiva da média da distância total da família por famcluster4
od %>% filter(F_FAM==1) %>% select(FAM_VIAG_TOT, famcluster4) %>% describeBy(group='famcluster4')
# estatística descritiva da média da distância total da família por famcluster9
od %>% filter(F_FAM==1) %>% select(FAM_VIAG_TOT, famcluster9) %>% describeBy(group='famcluster9')

# estatística descritiva da média do número médio de viagens da família por pesscluster2
od %>% filter(F_FAM==1) %>% select(FAM_VIAG_TOT, pesscluster2) %>% describeBy(group='pesscluster2')
# estatística descritiva da média da distância total da família por pesscluster4
od %>% filter(F_FAM==1) %>% select(FAM_VIAG_TOT, pesscluster4) %>% describeBy(group='pesscluster4')

##
##
# estatística descritiva do número médio de viagens da famílis para toda a base
od %>% filter(F_FAM==1) %>% select(REN_FAM) %>% describe()

# estatística descritiva da média do número médio de viagens da família por ano
od %>% filter(F_FAM==1, ANO==1) %>% select(REN_FAM) %>% describe()
od %>% filter(F_FAM==1, ANO==2) %>% select(REN_FAM) %>% describe()
od %>% filter(F_FAM==1, ANO==3) %>% select(REN_FAM) %>% describe()
od %>% filter(F_FAM==1, ANO==4) %>% select(REN_FAM) %>% describe()

# estatística descritiva da média do número médio de viagens da família por famcluster2
od %>% filter(F_FAM==1) %>% select(REN_FAM, famcluster2) %>% describeBy(group='famcluster2')
# estatística descritiva da média da distância total da família por famcluster4
od %>% filter(F_FAM==1) %>% select(REN_FAM, famcluster4) %>% describeBy(group='famcluster4')
# estatística descritiva da média da distância total da família por famcluster9
od %>% filter(F_FAM==1) %>% select(REN_FAM, famcluster9) %>% describeBy(group='famcluster9')

# estatística descritiva da média do número médio de viagens da família por pesscluster2
od %>% filter(F_FAM==1) %>% select(REN_FAM, pesscluster2) %>% describeBy(group='pesscluster2')
# estatística descritiva da média da distância total da família por pesscluster4
od %>% filter(F_FAM==1) %>% select(REN_FAM, pesscluster4) %>% describeBy(group='pesscluster4')

##
##
# estatística descritiva do número médio de viagens da família para toda a base
od %>% filter(F_FAM==1) %>% select(TOT_FAM) %>% describe()

# estatística descritiva da média do número médio de viagens da família por ano
od %>% filter(F_FAM==1, ANO==1) %>% select(TOT_FAM) %>% describe()
od %>% filter(F_FAM==1, ANO==2) %>% select(TOT_FAM) %>% describe()
od %>% filter(F_FAM==1, ANO==3) %>% select(TOT_FAM) %>% describe()
od %>% filter(F_FAM==1, ANO==4) %>% select(TOT_FAM) %>% describe()

# estatística descritiva da média do número médio de viagens da família por famcluster2
od %>% filter(F_FAM==1) %>% select(TOT_FAM, famcluster2) %>% describeBy(group='famcluster2')
# estatística descritiva da média da distância total da família por famcluster4
od %>% filter(F_FAM==1) %>% select(TOT_FAM, famcluster4) %>% describeBy(group='famcluster4')
# estatística descritiva da média da distância total da família por famcluster9
od %>% filter(F_FAM==1) %>% select(TOT_FAM, famcluster9) %>% describeBy(group='famcluster9')

# estatística descritiva da média do número médio de viagens da família por pesscluster2
od %>% filter(F_FAM==1) %>% select(TOT_FAM, pesscluster2) %>% describeBy(group='pesscluster2')
# estatística descritiva da média da distância total da família por pesscluster4
od %>% filter(F_FAM==1) %>% select(TOT_FAM, pesscluster4) %>% describeBy(group='pesscluster4')




