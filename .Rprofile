#### -- Packrat Autoloader (version 0.4.6-1) -- ####
source("packrat/init.R")
#### -- End Packrat Autoloader -- ####

# define user data directory and history file location
local({

  # Configuraçẽos gerais de diretórios do projeto
  dirMestrado <- file.path('~/mestrado/')
  dirBases <- file.path(dirMestrado,'bases')
  dirAlgoritmos <- file.path(dirMestrado,'algoritmos')

  hostname <- Sys.info()["nodename"]

  if(hostname=="grace") {
    dirMestrado <- file.path('/home/haydee/Área de trabalho/mestrado-PTR')
    dirBases <- file.path(dirMestrado,'OD/Consolidado')
    dirAlgoritmos <- file.path(dirMestrado,'ALGORITMOS')
  } else if(hostname=="russel") {
    dirMestrado <- file.path('/home/diraol/haydee/mestrado')
    dirBases <- file.path(dirMestrado,'bases')
    dirAlgoritmos <- file.path(dirMestrado,'mestrado-usp-algoritmos')
  } else if(hostname=="luizpc") {
    dirMestrado <- file.path('/home/haydee/mestrado')
    dirBases <- file.path(dirMestrado,'bases')
    dirAlgoritmos <- file.path(dirMestrado,'algoritmos')
  }

  dirBasesSeparadas <- file.path(dirBases, 'bancos-separados')
  dirBasesUnicas <- file.path(dirBases,'banco unico - pols')
  dirAlgoritmosAnalises <- file.path(dirAlgoritmos,'analises')
  dirResultados <- file.path(dirAlgoritmos,'resultados')

  # Salvando estas variáveis no ambiente global
  assign(".dirMestrado", dirMestrado, envir = globalenv())
  assign(".dirBases", dirBases, envir = globalenv())
  assign(".dirBasesSeparadas", dirBasesSeparadas, envir = globalenv())
  assign(".dirBasesUnicas", dirBasesUnicas, envir = globalenv())
  assign(".dirAlgoritmos", dirAlgoritmos, envir = globalenv())
  assign(".dirAlgoritmosAnalises", dirAlgoritmosAnalises, envir = globalenv())
  assign(".dirResultados", dirResultados, envir = globalenv())

  dataDir <- ".userdata"
  if (identical(.Platform$OS.type, "windows"))
    username <- Sys.getenv("USERNAME")
  else
    username <-  Sys.getenv("USER")
  userDir <- file.path(dirAlgoritmos, dataDir, username)
  if (!file.exists(userDir))
    dir.create(userDir, recursive = TRUE)
  userDir <- normalizePath(userDir)

  # locate history in user data dir
  Sys.setenv(R_HISTFILE = file.path(userDir, ".Rhistory"))

  # make the rdataPath available in the global environment
  # so it can be accessed by .First and .Last
  rdataPath <- file.path(userDir, ".RData")
  assign(".rdataPath", rdataPath, envir = globalenv())

})

# load the .RData at startup
.First <- function() {
  if (file.exists(.rdataPath))
    cat("Carregando dados salvos do ambiente")
    load(.rdataPath, envir = globalenv())
  require(utils)
  try(loadhistory(Sys.getenv("R_HISTFILE")))
  # Carrega principais scripts do mestrado
  source("R/inicializacao.R")
}

# save the .RData at exit
.Last <- function() {
  cat("\nEncerrando as atividades por enquanto...\n")
  cat("Salvando o ambiente atual antes de fechar o projeto,\n")
  cat("Esta operação pode demorar um pouco.\n")
  cat("Primeiro salvando o histórico... ")
  require(utils)
  try(savehistory(Sys.getenv("R_HISTFILE")))
  cat("Histórico Salvo.\n Agora salvando as variáveis de ambiente...")
  # removendo variáveis de ambiente do mestrado que são recarregadas automaticamente
  rm(list=ls(pattern=".mestrado.*", all.names=T))
  rm(list=ls(pattern=".dir*", all.names=T))
  save.image(.rdataPath)
  cat(" Ambiente salvo, agora sim fechando o R/Rstudio. =)")
}
