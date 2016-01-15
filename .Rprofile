#### -- Packrat Autoloader (version 0.4.6-1) -- ####
source("packrat/init.R")
#### -- End Packrat Autoloader -- ####
# define user data directory and history file location
local({
  dataDir <- ".userdata"
  if (identical(.Platform$OS.type, "windows"))
    username <- Sys.getenv("USERNAME")
  else
    username <-  Sys.getenv("USER")                   
  userDir <- file.path(dataDir, username)
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
    load(.rdataPath, envir = globalenv())
}

# save the .RData at exit
.Last <- function() {
  save.image(.rdataPath)
}
source("R/inicializacao.R")
