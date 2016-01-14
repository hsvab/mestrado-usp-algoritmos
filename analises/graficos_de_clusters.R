grafico_seleciona_cluster <- function(df=od,
                                      NCLUSTERS=10,
                                      TITULO=NULL,
                                      SALVA_EM=NULL) {
  # Função que gerá o gráfico do RMSSTD x num de clusters e também
  # o gŕafico do R² ajustado x número de clusters.
  #
  # Parâmetros:
  #           df -> Dataframe no qual a análise (kmeans) será rodada
  #                 para análise do número de clusters.
  #                 Por padrão ele irá buscar um dataframe carregado
  #                 de nome "od", caso algum outro não seja passado.
  #           NCLUSTERS -> Número máximo de clusters a serem avaliados.
  #           TITULO -> Título que deve ser utilizado no gráfico que
  #
  #           SALVA_EM -> String que define aonde e com qual nome
  #                       o gráfico gerado deve ser salvo.será gerado

  # Variáveis gerais
  n = nrow(df)
  if (!is.character(TITULO)) {
    TITULO <- paste0("Avaliação para até ", NCLUSTERS, " clusters")
  }

  # Cálculos para o gráfico do R² ajustado
  totwss = rep(0,NCLUSTERS) # will be filled with total sum of within group sum squares
  kmfit = list() # create and empty list
  for (i in 1:NCLUSTERS){
    kclus = kmeans(df, centers=i)
    totwss[i] = kclus$tot.withinss
    kmfit[[i]] = kclus
  }
  # Cálculo do R² ajustado
  rsq = 1-(totwss*(n-1))/(totwss[1]*(n-seq(1,NCLUSTERS)))

  # Calculando variável para o gráfico do RMSSTD
  wss <- (nrow(df)-1)*sum(apply(df,2,var))
  for (i in 1:NCLUSTERS) wss[i] <- sum(kmeans(df,
                                         centers=i)$withinss)

  # Plotando              b l t r
  par(mfrow=c(2,1), mar=c(4,4,1.3,2), oma=c(0.7,1,0.7,1))
  plot(seq(1,NCLUSTERS), wss, main=TITULO,
       type="b", cex=1, pch=20, frame.plot = T, xlab=NA, ylab="RMSSTD")
  abline(v=seq(1,NCLUSTERS,1), lty=2, col="blue")
  plot(seq(1,NCLUSTERS), rsq,
       type = 'b', cex=1, pch=20, frame.plot = T, xlab="Número de Clusters", ylab="R² ajustado" )
  abline(v=seq(1,NCLUSTERS,1), lty=2, col="blue")
  if( is.character(SALVA_EM) ){
    dev.copy(png, SALVA_EM)
    dev.off()
  }

}
