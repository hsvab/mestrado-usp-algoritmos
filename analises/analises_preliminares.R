library(ggplot2)

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
