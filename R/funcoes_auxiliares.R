salva_base_od <- function(DF,
                          VERSAO=NULL,
                          CAMINHO=.dirBasesUnicas) {
  #
  # Esta função salva o dataframe e depois compacta ele com bzip.
  # Primeiro o arquivo é salvo como CSV e, depois, ele será compactado.
  # Enquanto o arquivo CSV estiver sendo salvo, o R ficará em estado suspenso,
  # mas quando for ocorrer a compactação o R não mais ficará em estado de
  # suspensão.
  #
  # Parâmetros:
  #   DF: O dataframe a ser salvo
  #   VERSAO: Versão que constará no nome do arquivo
  #   CAMINHO: Caminho do diretório aonde o arquivo será salvo.
  #

  #  Primeiro salvamos como CSV:
  arquivo_saida = file.path(sub(pattern = "^(.*)/$","\\1",CAMINHO), "od")
  if(is.character(VERSAO)) { arquivo_saida = paste0(arquivo_saida, "-", VERSAO) }
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

carrega_base_od <- function(VERSAO=NULL,
                            CAMINHO=.dirBasesUnicas) {
  #
  # Precisa da biblioteca data.table para funcionar
  #
  # Parâmetros:
  #   VERSAO: Por padrão ele lê o arquivo od.csv, se quiser uma versão diferente
  #           passe o número como parâmetro nomeado (Exemplo 2);
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
      stop(paste0("O arquivo '", arquivo, "' não foi encontrado, abortando ação"))
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
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
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

################################################################################
#          Funções de teste de desempenho dos métodos de leitura
################################################################################

suite_de_testes_de_leitura <- function() {

  load.data <- function() {
    print("Primeiro vamos baixar um arquivo de exemplo para ser utilizado.", quote = F)
    print("Vamos utilizar o arquivo od-11 do repositório https://github.com/hsvab/mestrado-usp-ODs/", quote = F)
    url <- "https://github.com/hsvab/mestrado-usp-ODs/raw/master/banco%20unico%20-%20pols/od-11.csv.bz2"
    download.file(url, destfile="teste.csv.bz2", method = "wget")
    print("Download finalizado.", quote=F)
    print("Agora vamos descompactar o arquivo (mantendo também o compactado)... ", quote = F)
    system('bunzip2 -k -f teste.csv.bz2')
    print("Arquivo descompactado.", quote = F)
  }

  rtab <- function() {
    # Tempos de execução:
    #    usuário   sistema decorrido
    #    51.032     0.640    51.670
    print("Lê teste.csv com comando read.table()", quote = F)
    read.table('teste.csv', sep=';', dec=',', header = T, colClasses = c( 'ID_PESS'='character', 'ID_VIAG'='character', 'ID_DOM'='character', 'ID_FAM'='character') )
  }

  rtab_com_bz2 <- function(){
    # Tempos de execução:
    #    usuário   sistema decorrido
    #    78.960     0.264    79.213
    print("Lê teste2.csv.bz2 com comando read.table()", quote = F)
    read.table('teste.csv.bz2', sep=';', dec=',', header = T, colClasses = c( 'ID_PESS'='character', 'ID_VIAG'='character', 'ID_DOM'='character', 'ID_FAM'='character') )
  }

  fread_com_bz2 <- function(){
    # Tempos de execução:
    #    usuário   sistema decorrido
    #    15.636     1.864    17.639
    print("Descompacta teste2.csv.bz2 e depois lê teste2.csv com comando fread()", quote = F)
    system('bunzip2 -k -f teste.csv.bz2')
    fread("teste.csv", sep=';', dec=',', header=TRUE, data.table=FALSE, colClasses = c( 'ID_PESS'='character', 'ID_VIAG'='character', 'ID_DOM'='character', 'ID_FAM'='character') )
  }

  apenas_fread <- function() {
    # Tempos de execução:
    #    usuário   sistema decorrido
    #    6.424     0.052     6.469
    print("Lê teste.csv com comando fread()", quote = F)
    fread("teste.csv", sep=';', dec=',', header=TRUE, data.table=FALSE, colClasses = c( 'ID_PESS'='character', 'ID_VIAG'='character', 'ID_DOM'='character', 'ID_FAM'='character') )
  }

  load.data()
  cat("\n\n#########################################\n")
  time01 <- system.time( rtab() )
  print(time01)
  cat("\n\n#########################################\n")
  time02 <- system.time( rtab_com_bz2()  )
  print(time02)
  cat("\n\n#########################################\n")
  time03 <- system.time( fread_com_bz2() )
  print(time03)
  cat("\n\n#########################################\n")
  time04 <- system.time( apenas_fread() )
  print(time04)

  system("rm teste*.csv*")
}
rm(suite_de_testes_de_leitura)
################################################################################
#          Funções de verificação nas correções das bases originais
################################################################################

correcoes.originais.resumo <- function(df, linhaInicio, linhaFim=NULL) {
  if ( !is.null(linhaFim) ) {
    df[
      as.integer(linhaInicio):as.integer(linhaFim),
      c('ID_DOM','F_DOM','FE_DOM','ID_FAM','F_FAM','FE_FAM','REN_FAM',
        'ID_PESS','F_PESS','FE_PESS','IDADE','SEXO','SIT_FAM','REN_IND',
        'ID_VIAG','F_VIAG','FE_VIAG','DURACAO','H_SAIDA','MIN_SAIDA',
        'H_CHEG','MIN_CHEG','ID_ORIGINAL','ID_CONSOLIDADO_01')]
  } else {
    df[
      as.integer(linhaInicio),
      c('ID_DOM','F_DOM','FE_DOM','ID_FAM','F_FAM','FE_FAM','REN_FAM',
        'ID_PESS','F_PESS','FE_PESS','IDADE','SEXO','SIT_FAM','REN_IND',
        'ID_VIAG','F_VIAG','FE_VIAG','DURACAO','H_SAIDA','MIN_SAIDA',
        'H_CHEG','MIN_CHEG','ID_ORIGINAL','ID_CONSOLIDADO_01')]
  }
}
rm(correcoes.originais.resumo)
