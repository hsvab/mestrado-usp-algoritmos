library('dplyr')
library('ggplot2')

# od <- read.table('../../mestrado-usp-ODs/banco unico - pols/od-7.csv.bz2',
#                  header=TRUE,
#                  sep=';',
#                  dec=',',
#                  colClasses = c(
#                      'ID_PESS'='character',
#                      'ID_VIAG'='character',
#                      'ID_DOM'='character',
#                      'ID_FAM'='character')
#                  )
#
# http://www.r-bloggers.com/great-circle-distance-calculations-in-r/
#
# Calcula a distância geodésica entre dois pontos especificando
# latitude e longitude (em graus) usndo a fórmula Haversine (hf)
#
# Referência: SaoPaulo = ("latitude"="-23.5333333", "longitude"="-46.6166667")
# CO_ORIG_X
# 
#
gcd.hf <- function(CO_ORIG_Y, CO_ORIG_X, CO_DEST_Y, CO_DEST_X) {
    # Função para converter um ângulo de graus para radianos.
    deg2rad <- function(deg) return(deg*pi/180)

    CO_ORIG_X <- deg2rad(CO_ORIG_X)
    CO_ORIG_Y <- deg2rad(CO_ORIG_Y)
    CO_DEST_X <- deg2rad(CO_DEST_X)
    CO_DEST_Y <- deg2rad(CO_DEST_Y)
    R <- (12756.2/2) # Raio médio da Terra em km = diâmetro equatorial da Terra / 2
    delta.long <- (CO_DEST_X - CO_ORIG_X)
    delta.lat <- (CO_DEST_Y - CO_ORIG_Y)
    a <- sin(delta.lat/2)^2 + cos(CO_ORIG_Y) * cos(CO_DEST_Y) * sin(delta.long/2)^2
    c <- 2 * asin(min(1,sqrt(a)))
    d = R * c
    return(d) # Distância em km
}

# Aplicando a função gcd.hf no banco de dados od para os anos de 1977, 1987 e 1997
# 2007 já tem nos campos COORD_X e COORD_Y as devidas coordenadas

od <- od  %>%
  mutate(DIST_VIAG=ifelse(
    ANO==1 | ANO==2 | ANO==3,
    gcd.hf(CO_ORIG_Y, CO_ORIG_X, CO_DEST_Y, CO_DEST_X),
    DIST_VIAG))

