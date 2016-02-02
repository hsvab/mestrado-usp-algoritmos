local({

    grafico.seleciona.cluster <- function(df=od,
                                          NCLUSTERS=10,
                                          TITULO=NULL,
                                          NOME_ARQUIVO=NULL,
                                          SALVA_EM=NULL,
                                          GRANDEZA=10^24) {
      # Função que gerá o gráfico do RMSSTD x num de clusters e também
      # o gŕafico do R² ajustado x número de clusters.
      #
      # Parâmetros:
      #           df -> Dataframe no qual a análise (kmeans) será rodada
      #                 para análise do número de clusters.
      #                 Por padrão ele irá buscar um dataframe carregado
      #                 de nome "od", caso algum outro não seja passado.
      #           NCLUSTERS -> Número máximo de clusters a serem avaliados.
      #           TITULO -> Título principal que deve ser utilizado no gráfico
      #           NOME_ARQUIVO -> Nome do arquivo de saída, sem extensão.
      #                           Se nome arquivo for definido e SALVA_EM não
      #                           for, então o arquivo será salvo na pasta atual
      #           SALVA_EM -> String que define aonde o gráfico gerado
      #                       deve ser salvo.
      #                       Se SALVA_EM for definido e NOME_ARQUIVO não,
      #                       então o arquivo receberá o nome padrão
      #                       "grafico_cluster"
      #           GRANDEZA -> Ordem de grandeza a ser utilizada para ajuste
      #                       da escala do gráfico RMSSTD
      #

      # Variáveis gerais
      n = nrow(df)
      if (!is.character(TITULO)) {
        TITULO <- paste0("Avaliação para até ", NCLUSTERS, " clusters")
      }
      clusterSeq = seq(1,NCLUSTERS,1)

      # Cálculos para o gráfico do R² ajustado
      totwss = rep(0,NCLUSTERS) # will be filled with total sum of within group sum squares
      kmfit = list() # create and empty list
      for (i in 1:NCLUSTERS){
        kclus = kmeans(df, centers=i)
        totwss[i] = kclus$tot.withinss
        kmfit[[i]] = kclus
      }
      # Cálculo do R² ajustado
      rsq = 1-(totwss*(n-1))/(totwss[1]*(n-clusterSeq))

      # Calculando variável para o gráfico do RMSSTD
      # Aqui o valor foi dividido por "GRANDEZA" apenas para
      # melhorar o gráfico.
      wss <- (nrow(df)-1)*sum(apply(df,2,var))
      for (i in 1:NCLUSTERS) wss[i] <- sum(kmeans(df,
                                             centers=i)$withinss)/GRANDEZA

      rmsstd.data <- data.frame('clusters'=clusterSeq,
                                'RMSSTD'=wss)

      r2.data <- data.frame('clusters'=clusterSeq,
                            'R2ajustado'=rsq)

      # Função para fazer a formatação do eixo y com duas casas decimais
      fmt <- function(){
        f <- function(x) as.character(sprintf("%.2f",as.numeric(x)))
        f
      }

      p1 <- ggplot(data=rmsstd.data, aes(x=clusters, y=RMSSTD)) +
        geom_line(colour=.mestrado.cor.graf.linha.simples) +
        geom_point(shape=1, size=2.5) +
        geom_text(aes(label=round(RMSSTD,2),
                      hjust="left",
                      vjust = "bottom"),
                  color=.mestrado.cor.elementos.gerais,
                  position = position_nudge(y = 0.1, x = 0.02)) +
        scale_x_continuous(breaks = clusterSeq) +
        scale_y_continuous(labels=fmt()) +
        ggtitle(TITULO) +
        xlab('Número de Clusters') +
        ylab(paste0('RMSSTD (x',gsub("1e\\+", "10^", as.character(GRANDEZA)),')')) +
        theme_light() +
        theme(plot.title = element_text(lineheight=1.6, face="bold", size="16"),
              axis.text = element_text(color=.mestrado.cor.elementos.gerais),
              axis.title = element_text(color=.mestrado.cor.elementos.gerais))

      p2 <- ggplot(data=r2.data, aes(x=clusters, y=R2ajustado)) +
        geom_line(colour=.mestrado.cor.graf.linha.simples) +
        geom_point(shape=1, size=2.5) +
        geom_text(aes(label=round(R2ajustado,2), hjust="left", vjust = "center"),
                  color=.mestrado.cor.elementos.gerais,
                  position = position_nudge(y = -0.05, x = 0.02)) +
        scale_x_continuous(breaks = clusterSeq) +
        scale_y_continuous(labels=fmt()) +
        xlab('Número de Clusters') +
        ylab('R² Ajustado') +
        theme_light() +
        theme(plot.title = element_text(lineheight=1.6, face="bold", size="16"),
              axis.text = element_text(color=.mestrado.cor.elementos.gerais),
              axis.title = element_text(color=.mestrado.cor.elementos.gerais))

      .mestrado.multiplot(p1, p2, cols=1)

      if( is.character(SALVA_EM) | is.character(NOME_ARQUIVO)){
        salva = .dirResultados
        if( is.character(SALVA_EM) ) {
          salva = file.path(sub(pattern = "^(.*)/$","\\1",SALVA_EM))
        }
        if( is.character(NOME_ARQUIVO) ) {
          salva = file.path(salva, NOME_ARQUIVO)
        } else {
          salva = file.path(salva, "grafico-cluster")
        }

        dev.copy(pdf, paste0(salva,".pdf"), width=7*5/4)
        dev.off()
        dev.copy(png, paste0(salva,".png"), width=600, height=480)
        dev.off()
      }
    }

    assign(".mestrado.grafico_seleciona_cluster", grafico.seleciona.cluster,
           envir=globalenv())
    
    assign("grafico_seleciona_cluster", grafico.seleciona.cluster,
           envir=globalenv())
})
