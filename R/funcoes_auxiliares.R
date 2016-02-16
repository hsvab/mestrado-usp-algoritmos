local({

    salva.base.od <- function(DF,
                              VERSAO=NULL,
                              CAMINHO=.dirBasesUnicas) {
      #
      # Esta função salva o dataframe e depois compacta ele com bzip.
      # Primeiro o arquivo é salvo como CSV e, depois, ele será compactado.
      # Enquanto o arquivo CSV estiver sendo salvo, o R ficará em estado
      # suspenso, mas quando for ocorrer a compactação o R não mais ficará em
      # estado de suspensão.
      #
      # Parâmetros:
      #   DF: O dataframe a ser salvo
      #   VERSAO: Versão que constará no nome do arquivo
      #   CAMINHO: Caminho do diretório aonde o arquivo será salvo.
      #

      #  Primeiro salvamos como CSV:
      arquivo_saida = file.path(sub(pattern = "^(.*)/$","\\1",CAMINHO), "od")
      if(is.character(VERSAO)) {
        arquivo_saida = paste0(arquivo_saida, "-", VERSAO)
      }
      arquivo_saida = paste0(arquivo_saida, ".csv")

      cat("Salvando o arquivo ", arquivo_saida,"\n", sep='')
      write.table(x = DF,
                file = arquivo_saida,
                sep = ';',
                dec = ',',
                row.names = F)

      # Agora compacta o arquivo, sem "travar" a execução do R.
      cat("\nAgora compactando o arquivo salvo.\n")
      cat("Enquanto o arquivo é compactado você pode continuar utilizando o R!\n")
      comando = paste0('bzip2 -k -f -q -9 "', arquivo_saida, '"')
      system(comando, wait=FALSE )
      cat("Não haverá uma mensagem de operação finalizada.")

    }

    carrega.base.od <- function(VERSAO=NULL,
                                CAMINHO=.dirBasesUnicas) {
      #
      # Precisa da biblioteca data.table para funcionar
      #
      # Parâmetros:
      #   VERSAO: Por padrão ele lê o arquivo od.csv, se quiser uma versão
      #           diferente passe o número como parâmetro nomeado (Exemplo 2);
      #   CAMINHO: Por padrão assume-se que as bases estão no diretório
      #            '../bases/banco unico - pols/'. Se quiser passar um diretório
      #            diferente utilize o parâmetro nomeado (Exemplo 3)
      #
      # Exemplo 1: (Lê "../bases/banco unico - pols/od.csv")
      #     od <- carrega_base_od()
      #
      # Exemplo 2:
      #     od <- carrega_base_od(VERSAO="05")
      #
      # Exemplo 3:
      #     od <- carrega_base_od(CAMINHO="~/diretorio")
      #
      # Exemplo 4: Passando os dois parâmetros sem nomeá-los
      #     od <- carrega_base_od("05", "~/diretorio")
      #

      arquivo = file.path(sub(pattern = "^(.*)/$","\\1",CAMINHO), "od")
      if(is.character(VERSAO)) { arquivo = paste0(arquivo, "-", VERSAO) }
      arquivo = paste0(arquivo,".csv")

      # Conferindo se o arquivo existe. Se não existir, verifica se existe o bz2
      # do arquivo e descompacta ele. Se não existir nem o CSV nem o CSV.BZ2,
      # então retorna uma mensagem dizendo que o arquivo não existe.

      if ( !file.exists( arquivo ) ) {
        if ( file.exists( paste0(arquivo,".bz2") ) ) {
          cat("O arquivo '", arquivo, "' não foi encontrado.\n", sep='')
          cat("Descompactando o arquivo '", arquivo, ".bz2'\n", sep='')
          comando = paste0('bunzip2 -k -f -q "', arquivo, '.bz2"')
          system( comando, wait=TRUE )
          cat("Arquivo descompactado, lendo arquivo...\n")
        } else {
          stop(
            paste0("O arquivo '",
                   arquivo,
                   "' não foi encontrado, abortando ação")
          )
        }
      }

      return(
        fread(arquivo,
              sep=';', dec=',', header=TRUE, data.table=FALSE,
              colClasses = c(
                'ID_PESS'='character',
                'ID_VIAG'='character',
                'ID_DOM'='character',
                'ID_FAM'='character')
        )
      )

    }

    # Multiple plot function
    #
    # ggplot objects can be passed in ...,
    # or to plotlist (as a list of ggplot objects)
    # - cols:   Number of columns in layout
    # - layout: A matrix specifying the layout. If present, 'cols' is ignored.
    #
    # If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
    # then plot 1 will go in the upper left, 2 will go in the upper right, and
    # 3 will go all the way across the bottom.
    #
    multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
      library(grid)

      # Make a list from the ... arguments and plotlist
      plots <- c(list(...), plotlist)

      numPlots = length(plots)

      # If layout is NULL, then use 'cols' to determine layout
      if (is.null(layout)) {
        # Make the panel
        # ncol: Number of columns of plots
        # nrow: Number of rows needed, calculated from # of cols
        layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                         ncol = cols, nrow = ceiling(numPlots/cols))
      }

      if (numPlots==1) {
        print(plots[[1]])

      } else {
        # Set up the page
        grid.newpage()
        pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

        # Make each plot, in the correct location
        for (i in 1:numPlots) {
          # Get the i,j matrix positions of the regions that contain this subplot
          matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

          print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                          layout.pos.col = matchidx$col))
        }
      }
    }

    escalar.FEs.por.ano <- function(df) {
      ## Ajuste dos FEs de forma que a soma de um determinado FE para um
      ## determinado ano seja 1 e o range varie entre 0 e 1.
      ## Retorna o dataframe com 4 novas variáveis:
      ## FE_DOM_SCALED, FE_FAM_SCALED, FE_PESS_SCALED e FE_VIAG_SCALED

      # FE_DOM
      df <- df %>%
        filter(F_DOM==1) %>% group_by(ANO) %>% select(ID_DOM, FE_DOM) %>%
        mutate(FE_DOM_SCALED = FE_DOM/sum(FE_DOM)) %>% ungroup() %>%
        select(-ANO, -FE_DOM) %>% left_join(od, y=., by='ID_DOM')
      # FE_FAM
      df <- df %>%
        filter(F_FAM==1) %>% group_by(ANO) %>% select(ID_FAM, FE_FAM) %>%
        mutate(FE_FAM_SCALED = FE_FAM/sum(FE_FAM)) %>% ungroup() %>%
        select(-ANO, -FE_FAM) %>% left_join(od, y=., by='ID_FAM')
      # FE_PESS
      df <- df %>%
        filter(F_PESS==1) %>% group_by(ANO) %>% select(ID_PESS, FE_PESS) %>%
        mutate(FE_PESS_SCALED = FE_PESS/sum(FE_PESS)) %>% ungroup() %>%
        select(-ANO, -FE_PESS) %>% left_join(od, y=., by='ID_PESS')
      # FE_VIAG
      df <- df %>%
        filter(F_VIAG==1) %>% group_by(ANO) %>% select(ID_VIAG, FE_VIAG) %>%
        mutate(FE_VIAG_SCALED = FE_VIAG/sum(FE_VIAG)) %>% ungroup() %>%
        select(-ANO, -FE_VIAG) %>% left_join(od, y=., by='ID_VIAG')
      return(df)
    }

    expande.vetor.por <- function(vetor, FE=NULL) {
      # vetor = vetor que será expandido
      # FE = fator de expansão
      # Retorna o vetor expandido
      if (!is.null(FE)) {
        return(rep(vetor, as.integer(round(FE,0))))
      } else {
        return(vetor)
      }
    }

    expande.DF.por <- function(data, FE=NULL) {
      # data = Dataframe a ser expandido
      # FE = nome da variável do DF que será utilziada como Fator de Expansão (string)
      # Retorna o DataFrame expandido SEM o Fator de expansão
      if (!is.null(FE)){
        data.expandido <- lapply(
          select_(data,
                  lazyeval::interp(~-x, x=as.name(FE))
          ),
          expande.vetor.por,
          data[[FE]]
        )
        return( data.expandido )
      } else {
        return( data )
      }
    }

    describeByPond <- function(data, VARIAVEL, GRUPOS, FE, ...){
      # data = dataframe que contém os dados a serem descritos
      # VARIAVEL = nome da variável a ser descrita (strign/character)
      # GRUPOS = lista com as variáveis que serão utilizadas para agrupamento
      #           (strings)
      # FE = nome da variável (string) do dataframe que será utilziada como
      #         Fator de Expansão
      # O fator de expensão FE será arredondado para zero casas decimais.

      # Expandindo a base passada
      data <- select_(data, VARIAVEL, FE, .dots=GRUPOS)
      data <- expande.DF.por(data, FE)
      describeBy(data[VARIAVEL], data[GRUPOS], ...)
    }

    limites.outliers <- function(x) {
      # retorna os limites inferior e superior que delimitam o início dos outliers,
      # à esquerda e à direita, de um determinado vetor.
      qnt <- quantile(x, probs=c(.25, .75), na.rm=TRUE)
      H <- 1.5 * IQR(x, na.rm=TRUE)
      y = c(
        'min'=qnt[1] - H,
        'max'=qnt[2] + H)
      return(y)
    }

    outliers.por.grupo <- function(df, groups, var, na.rm=TRUE, zero_in=T, ...) {
      # retorna os outliers (esquerda e direita) calculando o maior mínimo
      # e o menor máximo de cada um dos grupos definidos.
      groups = lapply(groups,as.name)
      var = as.name(var)
      a <- df %>%
        group_by_(.dots=groups) %>%
        summarise_(
          min=lazyeval::interp(~.mestrado.limites.outliers(x)[1], x=var),
          max=lazyeval::interp(~.mestrado.limites.outliers(x)[2], x=var))
      b <- df %>%
        summarise_(
          min=lazyeval::interp(~.mestrado.limites.outliers(x)[1], x=var),
          max=lazyeval::interp(~.mestrado.limites.outliers(x)[2], x=var))
      val.min = max(min(a$min, b$min), min(select_(df, var)))
      val.max = min(max(a$max, b$max), max(select_(df, var)))
      if (!zero_in & floor(val.min)==0) {
        val.min = 1
      }
      return(c('min'=floor(val.min),'max'=ceil(val.max)))
    }

    # Salvando as funções no ambiente global do projeto
    assign(".mestrado.salva.base.od", salva.base.od,
           envir=globalenv())

    assign(".mestrado.carrega.base.od", carrega.base.od,
           envir=globalenv())

    assign(".mestrado.multiplot", multiplot,
           envir=globalenv())

    assign(".mestrado.escalar.FEs.por.ano", escalar.FEs.por.ano,
           envir=globalenv())

    assign(".mestrado.expande.vetor.por", expande.vetor.por,
           envir=globalenv())

    assign(".mestrado.expande.DF.por", expande.DF.por,
           envir=globalenv())

    assign(".mestrado.describeByPond", describeByPond,
           envir=globalenv())

    assign(".mestrado.limites_outliers", limites.outliers,
           envir=globalenv())

    assign(".mestrado.outliers.por.grupo", outliers.por.grupo,
           envir=globalenv())

    assign("salva.base.od", salva.base.od,
           envir=globalenv())

    assign("carrega.base.od", carrega.base.od,
           envir=globalenv())

})
