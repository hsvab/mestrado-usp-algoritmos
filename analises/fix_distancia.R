# http://www.r-bloggers.com/great-circle-distance-calculations-in-r/
#
# Calcula a distância geodésica entre dois pontos especificando
# latitude e longitude (em graus) usando a
# Fórmula Inversa de Vincenty para elipsóides (vif)
# Este é um processo iterativo e é o mais preciso para cálculo das distâncias.
# É o método que mais se aproxima do resultado apresentado pelo NHC:
# http://www.nhc.noaa.gov/gccalc.shtml
#
# Referência: SaoPaulo = ("latitude"="-23.5333333", "longitude"="-46.6166667")
# CO_ORIG_X = lat1
# CO_ORIG_Y = long1
# CO_DEST_X = lat2
# CO_DEST_Y = long2
#
#                     long1,      lat1,      long2,     lat2
GcdVif <- function(CO_ORIG_Y, CO_ORIG_X, CO_DEST_Y, CO_DEST_X) {
    # Função para converter um ângulo de graus para radianos.
    Deg2Rad <- function(deg) return(deg*pi/180)

    lat1 <- Deg2Rad(CO_ORIG_X)
    long1 <- Deg2Rad(CO_ORIG_Y)
    lat2 <- Deg2Rad(CO_DEST_X)
    long2 <- Deg2Rad(CO_DEST_Y)

    # Parâmetros para elipsoides na projeção WGS-84
    a <- 6378137         # comprimento do maior eixo do elipsoide (raio no equador)
    b <- 6356752.314245  # comprimento do menor eixo do elipsoide (raio nos polos)
    f <- 1/298.257223563 # Flattening (achatamento) do elipsoide

    L <- long2-long1 # diferença nas longitudes
    U1 <- atan((1-f) * tan(lat1)) # latitude reduzida
    U2 <- atan((1-f) * tan(lat2)) # latitude reduzida
    sinU1 <- sin(U1)
    cosU1 <- cos(U1)
    sinU2 <- sin(U2)
    cosU2 <- cos(U2)

    cosSqAlpha <- NULL
    sinSigma <- NULL
    cosSigma <- NULL
    cos2SigmaM <- NULL
    sigma <- NULL

    lambda <- L
    lambdaP <- 0
    iterLimit <- 100
    while (abs(lambda-lambdaP) > 1e-12 & iterLimit>0) {
        sinLambda <- sin(lambda)
        cosLambda <- cos(lambda)
        sinSigma <- sqrt( (cosU2*sinLambda) * (cosU2*sinLambda) +
                          (cosU1*sinU2-sinU1*cosU2*cosLambda) * (cosU1*sinU2-sinU1*cosU2*cosLambda) )
        if (sinSigma==0) return(0)  # Co-incident points
        cosSigma <- sinU1*sinU2 + cosU1*cosU2*cosLambda
        sigma <- atan2(sinSigma, cosSigma)
        sinAlpha <- cosU1 * cosU2 * sinLambda / sinSigma
        cosSqAlpha <- 1 - sinAlpha*sinAlpha
        cos2SigmaM <- cosSigma - 2*sinU1*sinU2/cosSqAlpha
        if (is.na(cos2SigmaM)) cos2SigmaM <- 0  # Linha equatorial: cosSqAlpha=0
        C <- f/16*cosSqAlpha*(4+f*(4-3*cosSqAlpha))
        lambdaP <- lambda
        lambda <- L + (1-C) * f * sinAlpha *
            (sigma + C*sinSigma*(cos2SigmaM+C*cosSigma*(-1+2*cos2SigmaM*cos2SigmaM)))
        iterLimit <- iterLimit - 1
    }
    if (iterLimit==0) return(NA)  # A fórmula não convergiu
    uSq <- cosSqAlpha * (a*a - b*b) / (b*b)
    A <- 1 + uSq/16384*(4096+uSq*(-768+uSq*(320-175*uSq)))
    B <- uSq/1024 * (256+uSq*(-128+uSq*(74-47*uSq)))
    deltaSigma = B*sinSigma*(cos2SigmaM + B/4*(cosSigma*(-1+2*cos2SigmaM^2) -
                                          B/6*cos2SigmaM*(-3+4*sinSigma^2)*(-3+4*cos2SigmaM^2)))
    s <- b*A*(sigma-deltaSigma) / 1000

    return(s) # Distância em km
}

# Aplicando a função gcd.vif no banco de dados od para os anos de 1977, 1987 e 1997.
# 2007 já tem nos campos COORD_X e COORD_Y as devidas coordenadas. Em 2007
# só precisamos dividir DIST_VIAG por 1000 para transformar de metros para Km.
od <- od  %>%
    # Calculando a distância com a fórmula VIF
    mutate(DIST_VIAG=ifelse(
        ANO==4,
        DIST_VIAG/1000,
        GcdVif(CO_ORIG_Y, CO_ORIG_X, CO_DEST_Y, CO_DEST_X)
    )) %>%
    # Corrigindo distâncias NAN para ZERO.
    # Isto só acontece quando origem e destino são iguais
    mutate(DIST_VIAG=
            ifelse(
                is.nan(DIST_VIAG),
                0,
                DIST_VIAG)
    )

#Plotando histograma, por ano, das distâncias viagem
ggplot(od,aes(x=as.numeric(DIST_VIAG),fill=as.factor(ANO))) +
    geom_histogram(binwidth=5,position="dodge")
