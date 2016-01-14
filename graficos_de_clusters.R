require("sfsmisc")
####################################################################
# Variáveis gerais

kmax = 10 # the maximum number of clusters we will examine; you can change this
n = nrow(od_cluster_fam)

# Cálculos para o gráfico do R² ajustado
####################################################################
# the data frame mydata_for_clustering is ncol=2 dimensional
# and we wish to determine the minimum number of clusters that leads
# to a more-or-less minimum total within group sum of squares
####################################################################
totwss = rep(0,kmax) # will be filled with total sum of within group sum squares
kmfit = list() # create and empty list
for (i in 1:kmax){
  kclus = kmeans(od_cluster_fam, centers=i)
  totwss[i] = kclus$tot.withinss
  kmfit[[i]] = kclus
}
# Cálculo do R² ajustado
rsq = 1-(totwss*(n-1))/(totwss[1]*(n-seq(1,kmax)))

############

# Calculando variável para o gráfico do RMSSTD
wss <- (nrow(od_cluster_fam)-1)*sum(apply(od_cluster_fam,2,var))
for (i in 1:kmax) wss[i] <- sum(kmeans(od_cluster_fam,
                                       centers=i)$withinss)

# Plotando

par(mfrow=c(2,1))
plot(1:kmax, wss, type="b", xlab=NA, frame.plot = T,
     ylab="RMSSTD",
     main="Avaliação para até 10 clusters para as famílias")
abline(v=seq(1,kmax,1), lty=2, col="blue")
plot(seq(1,kmax), rsq, xlab="Número de Clusters", ylab="R² ajustado", pch=20, cex=1, type = 'b' )
abline(v=seq(1,kmax,1), lty=2, col="blue")
