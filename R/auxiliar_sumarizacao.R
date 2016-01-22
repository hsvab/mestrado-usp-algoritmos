resumo.resultados.gerais <- function(DF=od,
                                     AGRUPA_POR='ANO',
                                     IMPRIME=T,
                                     RETORNA=F,
                                     SALVA_EM=NULL,
                                     NOME_ARQUIVO=NULL) {
  #
  # Função que realiza uma sumarização do dataframe olhando
  # os recortes das categorias da variável de agrupamento.
  # Esta função irá salvar o resultado num arquivo CSV se pelo menos um dos
  # parâmetros (SALVA_EM e/ou NOME_ARQUIVO) forem fornecidos na chamada.
  #
  # Parâmetros:
  #           DF -> dataframe que será avaliado. Por padrão
  #                 a função utiliza um dataframe que já deve
  #                 estar carregado e possui o nome "od".
  #           AGRUPA_POR -> Parâmetro que será utilziado para
  #                 realizar os recortes a serem avaliados.
  #                 O padrão é realziar o recorte por ANO.
  #                 Assim, o resultado será dado para cada um
  #                 dos anos presentes na base.
  #           IMPRIME -> Se a função deve imprimir o resultado da
  #                       análise no console ou não.
  #           RETORNA -> Se a função deve retornar um dataframe com os
  #                     resultados da análise para futura utilização
  #                     dos dados analisados/consolidados. Este
  #                     dataframe será retornado no console. Este
  #                     parâmetro não tem qualquer relação com salvar
  #                     o resultado da análise num arquivo CSV.
  #           SALVA_EM -> string com o caminho aonde o resultado deve ser salvo.
  #           NOME_ARQUIVO -> Nome do arquivo aonde o resultado será
  #                           salvo. Se essa informação não for passada
  #                           utiliza um nome default.
  #

  if(IMPRIME) {
    cat("Resumo geral dos resultados.", "\n")
    cat("Variável de agrupamento:", AGRUPA_POR, "\n")
  }

  resumo <- DF %>%
    dplyr::group_by_(as.name(AGRUPA_POR)) %>%
    dplyr::summarise(
      registros = length( F_DOM ),
      viagens = sum( F_VIAG & NO_VIAG, na.rm=T ),
      pessoas = length( unique( ID_PESS, na.action=na.exclude ) ),
      familias = length( unique( ID_FAM,  na.action=na.exclude ) ),
      perc_pess_77 = round( 100 * sum( ANO=="1" & F_PESS, na.rm=T ) / pessoas,
                            digits = 2 ),
      perc_pess_87 = round( 100 * sum( ANO=="2" & F_PESS, na.rm=T ) / pessoas,
                            digits = 2 ),
      perc_pess_97 = round( 100 * sum( ANO=="3" & F_PESS, na.rm=T ) / pessoas,
                            digits = 2 ),
      perc_pess_07 = round( 100 * sum( ANO=="4" & F_PESS, na.rm=T ) / pessoas,
                            digits = 2 )
  ) %>%
  dplyr::rename(
    "Nº de registros" = registros,
    "Nº de viagens" = viagens,
    "Nº de pessoas" = pessoas,
    "Nº de famílias" = familias,
    "% de pessoas de 1977" = perc_pess_77,
    "% de pessoas de 1987" = perc_pess_87,
    "% de pessoas de 1997" = perc_pess_97,
    "% de pessoas de 2007" = perc_pess_07
  )

  if(IMPRIME) {
    print.data.frame(resumo, row.names = FALSE, print.gap = 5 )
  }

  if( is.character(SALVA_EM) | is.character(NOME_ARQUIVO)){
    salva = .dirResultados
    if( is.character(SALVA_EM) ) {
      salva = file.path(sub(pattern = "^(.*)/$","\\1",SALVA_EM))
    }
    if( is.character(NOME_ARQUIVO) ) {
      salva = file.path(salva, paste0(NOME_ARQUIVO,'.csv'))
    } else {
      salva = file.path(salva, paste0("resumo_caracteristicas_gerais_por_",
                                      AGRUPA_POR,'.csv'))
    }

    cat("Salvando o resultado da análise no arquivo '", salva, "'", sep='')
    write.table( resumo, file=salva, sep=';', dec=',', row.names=F )
  }

  if( RETORNA ) {
    return( resumo )
  }
}

resumo.resultados.viagens <- function(DF=od,
                                      AGRUPA_POR='ANO',
                                      APENAS_COM_VIAGEM=T,
                                      IMPRIME=T,
                                      RETORNA=F,
                                      SALVA_EM=NULL,
                                      NOME_ARQUIVO=NULL) {
  #
  # Função que realiza uma sumarização do dataframe olhando
  # os recortes das categorias da variável de agrupamento e
  # para as características das viagens.
  # Esta função irá salvar o resultado num arquivo CSV se pelo menos um dos
  # parâmetros (SALVA_EM e/ou NOME_ARQUIVO) forem fornecidos na chamada.
  #
  # Parâmetros:
  #           DF -> dataframe que será avaliado. Por padrão
  #                 a função utiliza um dataframe que já deve
  #                 estar carregado e possui o nome "od".
  #           AGRUPA_POR -> Parâmetro que será utilziado para
  #                 realizar os recortes a serem avaliados.
  #                 O padrão é realziar o recorte por ANO.
  #                 Assim, o resultado será dado para cada um
  #                 dos anos presentes na base.
  #           APENAS_COM_VIAGEM -> Parâmetro utilizado para
  #                 filtrar da análise apenas os registros
  #                 de viagens que foram realizadas (F_VIAG==1).
  #                 Por padrão esta variável é verdadeira (TRUE),
  #                 então as análises serão realizadas excluindo-se
  #                 os registros nos quais não houve viagem.
  #           IMPRIME -> Se a função deve imprimir o resultado da
  #                       análise no console ou não.
  #           RETORNA -> Se a função deve retornar um dataframe com os
  #                     resultados da análise para futura utilização
  #                     dos dados analisados/consolidados. Este
  #                     dataframe será retornado no console. Este
  #                     parâmetro não tem qualquer relação com salvar
  #                     o resultado da análise num arquivo CSV.
  #           SALVA_EM -> string com o caminho aonde o resultado deve ser salvo.
  #           NOME_ARQUIVO -> Nome do arquivo aonde o resultado será
  #                           salvo. Se essa informação não for passada
  #                           utiliza um nome default.
  #

  # Estamos utilizando o parâmetro APENAS_COM_VIAGEM na chamada pois ele é mais
  # lógico aos usuários. Porém, para o código vamos utilziar a variável TODOS
  # que é menor em número de letras e faz mais sentido no código em si. Ela é
  # apenas o inverso lógico da APENAS_COMVIAGEM.
  TODOS = !APENAS_COM_VIAGEM

  if(IMPRIME) {
    cat("Resumo dos resultados referentes às viagens.", "\n")
    cat("Variável de agrupamento: ", AGRUPA_POR, "\n")
    cat("Considera registros sem viagem: ", ifelse(TODOS,"Sim","Não"), "\n")
  }

  resumo <- DF %>%
    dplyr::group_by_(as.name(AGRUPA_POR)) %>%
    dplyr::summarise(
      n_med_viagens_pess = round(
                            mean(
                              ifelse(
                                F_PESS & ( TODOS | F_VIAG ),
                                TOT_VIAG,
                                NA ),
                              na.rm=T ),
                            digits=2 ),
      n_med_viagens_fam = round(
                            mean(
                              ifelse(
                                F_FAM & ( TODOS | FAM_VIAG_TOT > 0 ),
                                FAM_VIAG_TOT,
                                NA ),
                              na.rm=T ),
                            digits=2 ),
      med_dist_tot_pess = round(
                            mean(
                              ifelse(
                                F_PESS & ( TODOS | F_VIAG ),
                                PESS_DIST_TOT,
                                NA ),
                              na.rm=T ),
                            digits=2 ),
      med_dist_tot_fam = round(
                          mean(
                            ifelse(
                              F_FAM & ( TODOS | FAM_VIAG_TOT > 0 ),
                              FAM_DIST_TOT,
                              NA ),
                            na.rm=T ),
                          digits=2 ),
      dist_med_viag_pess = round(
                            med_dist_tot_pess / n_med_viagens_pess,
                            digits=2 ),
      dist_med_pess_fam = round(
                            med_dist_tot_fam / n_med_viagens_fam,
                            digits=2 ),
      med_dur_tot_viag_pess = round(
                                mean(
                                  ifelse(
                                    F_PESS & ( TODOS | F_VIAG ),
                                    PESS_DURACAO_TOT,
                                    NA ),
                                  na.rm=T ),
                                digits=2 ),
      med_dur_tot_viag_fam = round(
                              mean(
                                ifelse(
                                  F_FAM & ( TODOS | FAM_VIAG_TOT > 0 ),
                                  FAM_DURACAO_TOT,
                                  NA ),
                                na.rm=T ),
                              digits=2 ),
      duracao_med_viag_pess = round(
                                med_dur_tot_viag_pess / n_med_viagens_pess,
                                digits=2 ),
      duracao_med_viag_fam = round(
                              med_dur_tot_viag_fam / n_med_viagens_fam,
                              digits=2 )
    ) %>%
    dplyr::rename(
      "Nº médio de viagens por pessoa" = n_med_viagens_pess,
      "Nº médio de viagens por família" = n_med_viagens_fam,
      "Média da distância total da pessoa (m)" = med_dist_tot_pess,
      "Média da distância total da família (m)" = med_dist_tot_fam,
      "Distância média por viagem da pessoa (m)" = dist_med_viag_pess,
      "Distância média por pessoa da família (m)" = dist_med_pess_fam,
      "Média da duração total da viagem da pessoa (min)" = med_dur_tot_viag_pess,
      "Média da duração total de viagens da família (min)" = med_dur_tot_viag_fam,
      "Duração média de viagens da pessoa (min)" = duracao_med_viag_pess,
      "Duração média de viagens da família (min)" = duracao_med_viag_fam
  )

  if(IMPRIME) {
    print.data.frame(resumo, row.names = FALSE, print.gap = 5 )
  }

  if( is.character(SALVA_EM) | is.character(NOME_ARQUIVO)){
    salva = .dirResultados
    if( is.character(SALVA_EM) ) {
      salva = file.path(sub(pattern = "^(.*)/$","\\1",SALVA_EM))
    }
    if( is.character(NOME_ARQUIVO) ) {
      salva = file.path(salva, paste0(NOME_ARQUIVO,'.csv'))
    } else {
      salva = file.path(salva, paste0("resumo_viagem_por_",AGRUPA_POR,'.csv'))
    }

    cat("Salvando o resultado da análise no arquivo '", salva, "'", sep='')
    write.table( resumo, file=salva, sep=';', dec=',', row.names=F )
  }

  if( RETORNA ) {
    return( resumo )
  }
}

resumo.resultados.pessoas <- function(DF=od,
                                      AGRUPA_POR='ANO',
                                      IMPRIME=T,
                                      RETORNA=F,
                                      SALVA_EM=NULL,
                                      NOME_ARQUIVO=NULL) {
  #
  # Função que realiza uma sumarização do dataframe olhando
  # os recortes das categorias da variável de agrupamento e
  # para as características das pessoas.
  # Esta função irá salvar o resultado num arquivo CSV se pelo menos um dos
  # parâmetros (SALVA_EM e/ou NOME_ARQUIVO) forem fornecidos na chamada.
  #
  # Parâmetros:
  #           DF -> dataframe que será avaliado. Por padrão
  #                 a função utiliza um dataframe que já deve
  #                 estar carregado e possui o nome "od".
  #           AGRUPA_POR -> Parâmetro que será utilziado para
  #                 realizar os recortes a serem avaliados.
  #                 O padrão é realziar o recorte por ANO.
  #                 Assim, o resultado será dado para cada um
  #                 dos anos presentes na base.
  #           IMPRIME -> Se a função deve imprimir o resultado da
  #                       análise no console ou não.
  #           RETORNA -> Se a função deve retornar um dataframe com os
  #                     resultados da análise para futura utilização
  #                     dos dados analisados/consolidados. Este
  #                     dataframe será retornado no console. Este
  #                     parâmetro não tem qualquer relação com salvar
  #                     o resultado da análise num arquivo CSV.
  #           SALVA_EM -> string com o caminho aonde o resultado deve ser salvo.
  #           NOME_ARQUIVO -> Nome do arquivo aonde o resultado será
  #                           salvo. Se essa informação não for passada
  #                           utiliza um nome default.
  #

  if(IMPRIME) {
    cat("Resumo dos resultados referentes às pessoas.", "\n")
    cat("Variável de agrupamento: ", AGRUPA_POR, "\n")
  }

  resumo <- DF %>%
    dplyr::filter(F_PESS==1) %>%
    dplyr::group_by_(as.name(AGRUPA_POR)) %>%
    dplyr::summarise(
      perc_pessoas_sexo_fem = round( 100 * sum( SEXO, na.rm=T ) /
                                       sum( F_PESS ),
                                     digits=2 ),
      perc_pessoas_sexo_mas = round( 100 * sum( !SEXO, na.rm=T ) /
                                       sum( F_PESS ),
                                     digits=2 ),
      media_idade_pessoa = round( mean( IDADE, na.rm=T ),
                                  digits=2 ),
      perc_sit_fam_1 = round( 100 * sum( SIT_FAM==1, na.rm=T ) /
                                sum( !is.na(SIT_FAM) ),
                              digits=2 ),
      perc_sit_fam_2 = round( 100 * sum( SIT_FAM==2, na.rm=T ) /
                                sum( !is.na(SIT_FAM) ),
                              digits=2 ),
      perc_sit_fam_3 = round( 100 * sum( SIT_FAM==3, na.rm=T ) /
                                sum( !is.na(SIT_FAM) ),
                              digits=2 ),
      perc_sit_fam_4 = round( 100 * sum( SIT_FAM==4, na.rm=T ) /
                                sum( !is.na(SIT_FAM) ),
                              digits=2 ),
      perc_sit_fam_5 = round( 100 * sum( SIT_FAM==5, na.rm=T ) /
                                sum( !is.na(SIT_FAM) ),
                              digits=2 ),
      perc_sit_fam_6 = round( 100 * sum( SIT_FAM==6, na.rm=T ) /
                                sum( !is.na(SIT_FAM) ),
                              digits=2 ),
      perc_grau_instr_1 = round( 100 * sum( GRAU_INSTR==1, na.rm=T ) /
                                   sum( !is.na(GRAU_INSTR) ),
                                 digits=2 ),
      perc_grau_instr_2 = round( 100 * sum( GRAU_INSTR==2, na.rm=T ) /
                                   sum( !is.na(GRAU_INSTR) ),
                                 digits=2 ),
      perc_grau_instr_3 = round( 100 * sum( GRAU_INSTR==3, na.rm=T ) /
                                   sum( !is.na(GRAU_INSTR) ),
                                 digits=2 ),
      perc_grau_instr_4 = round( 100 * sum( GRAU_INSTR==4, na.rm=T ) /
                                   sum( !is.na(GRAU_INSTR) ),
                                 digits=2 ),
      perc_pessoas_estudam = round( 100 * sum( ESTUDA,  na.rm=T ) /
                                      sum( !is.na(ESTUDA) ),
                                    digits=2 ),
      perc_pessoas_trab = round( 100 * sum( OCUP==1, na.rm=T ) /
                                   sum( !is.na(OCUP) ),
                                 digits=2 ),
      media_renda_ind = round( mean( REN_IND, na.rm=T ), digits=2 )
    ) %>%
    dplyr::rename(
      "% de pessoas do sexo feminino" = perc_pessoas_sexo_fem,
      "% de pessoas do sexo masculino" = perc_pessoas_sexo_mas,
      "Média de idade (anos)" = media_idade_pessoa,
      "% de pessoa responsável" = perc_sit_fam_1,
      "% de cônjuges" = perc_sit_fam_2,
      "% filhos / enteados" = perc_sit_fam_3,
      "% de outros parentes / agregados" = perc_sit_fam_4,
      "% de empregados" = perc_sit_fam_5,
      "% de outros" = perc_sit_fam_6,
      "% de pessoas não alfabetizadas ou com funamental incompleto" = perc_grau_instr_1,
      "% de pessoas com fundamental incompleto ou médio incompleto" = perc_grau_instr_2,
      "% de pessoas com médio completo ou superior incompleto" = perc_grau_instr_3,
      "% de pessoas com superior completo" = perc_grau_instr_4,
      "% de pessoas que estudam" = perc_pessoas_estudam,
      "% de pessoas que trabalham" = perc_pessoas_trab,
      "Média da Renda Individual (R$ - out/2007)" = media_renda_ind
    )

  if(IMPRIME) {
    print.data.frame(resumo, row.names = FALSE, print.gap = 5 )
  }

  if( is.character(SALVA_EM) | is.character(NOME_ARQUIVO)){
    salva = .dirResultados
    if( is.character(SALVA_EM) ) {
      salva = file.path(sub(pattern = "^(.*)/$","\\1",SALVA_EM))
    }
    if( is.character(NOME_ARQUIVO) ) {
      salva = file.path(salva, paste0(NOME_ARQUIVO,'.csv'))
    } else {
      salva = file.path(salva, paste0("resumo_pessoa_por_",AGRUPA_POR,'.csv'))
    }

    cat("Salvando o resultado da análise no arquivo '", salva, "'", sep='')
    write.table( resumo, file=salva, sep=';', dec=',', row.names=F )
  }

  if( RETORNA ) {
    return( resumo )
  }
}

resumo.resultados.familias <- function(DF=od,
                                       AGRUPA_POR='ANO',
                                       IMPRIME=T,
                                       RETORNA=F,
                                       SALVA_EM=NULL,
                                       NOME_ARQUIVO=NULL) {
  #
  # Função que realiza uma sumarização do dataframe olhando
  # os recortes das categorias da variável de agrupamento e
  # para as características das famílias
  # Esta função irá salvar o resultado num arquivo CSV se pelo menos um dos
  # parâmetros (SALVA_EM e/ou NOME_ARQUIVO) forem fornecidos na chamada.
  #
  # Parâmetros:
  #           DF -> dataframe que será avaliado. Por padrão
  #                 a função utiliza um dataframe que já deve
  #                 estar carregado e possui o nome "od".
  #           AGRUPA_POR -> Parâmetro que será utilziado para
  #                 realizar os recortes a serem avaliados.
  #                 O padrão é realziar o recorte por ANO.
  #                 Assim, o resultado será dado para cada um
  #                 dos anos presentes na base.
  #           IMPRIME -> Se a função deve imprimir o resultado da
  #                       análise no console ou não.
  #           RETORNA -> Se a função deve retornar um dataframe com os
  #                     resultados da análise para futura utilização
  #                     dos dados analisados/consolidados. Este
  #                     dataframe será retornado no console. Este
  #                     parâmetro não tem qualquer relação com salvar
  #                     o resultado da análise num arquivo CSV.
  #           SALVA_EM -> string com o caminho aonde o resultado deve ser salvo.
  #           NOME_ARQUIVO -> Nome do arquivo aonde o resultado será
  #                           salvo. Se essa informação não for passada
  #                           utiliza um nome default.
  #

  if(IMPRIME) {
    cat("Resumo dos resultados referentes às pessoas", "\n")
    cat("Variável de agrupamento: ", AGRUPA_POR, "\n")
  }

  resumo <- DF %>%
    dplyr::filter(F_FAM==1) %>%
    dplyr::group_by_(as.name(AGRUPA_POR)) %>%
    dplyr::summarise(
      media_renda_fam = round( mean( REN_FAM, na.rm=T ), digits=2 ),
      perc_fam_sem_renda = round( 100 * sum( FAIXA_REN_FAM==0, na.rm=T ) /
                                    sum( !is.na(FAIXA_REN_FAM) ),
                                  digits=2 ),
      perc_fam_fx_renda_E = round( 100 * sum( FAIXA_REN_FAM==1, na.rm=T ) /
                                    sum( !is.na(FAIXA_REN_FAM) ),
                                   digits=2 ),
      perc_fam_fx_renda_D = round( 100 * sum( FAIXA_REN_FAM==2, na.rm=T ) /
                                     sum( !is.na(FAIXA_REN_FAM) ),
                                   digits=2 ),
      perc_fam_fx_renda_C = round( 100 * sum( FAIXA_REN_FAM==3, na.rm=T ) /
                                     sum( !is.na(FAIXA_REN_FAM) ),
                                   digits=2 ),
      perc_fam_fx_renda_B = round( 100 * sum( FAIXA_REN_FAM==4, na.rm=T ) /
                                     sum( !is.na(FAIXA_REN_FAM) ),
                                   digits=2 ),
      perc_fam_fx_renda_A = round( 100 * sum( FAIXA_REN_FAM==5, na.rm=T ) /
                                     sum( !is.na(FAIXA_REN_FAM) ),
                                   digits=2 ),
      tam_med_fam = round( mean( TOT_PESS, na.rm=T ), digits=2 ),
      perc_fam_fx_et_0 = round( 100 * sum( PRESENCA_FILH_ate4==1, na.rm=T) /
                                  sum( !is.na(PRESENCA_FILH_ate4) ),
                                digits=2 ),
      perc_fam_fx_et_1 = round( 100 * sum( PRESENCA_FILH_5a9==1, na.rm=T) /
                                  sum( !is.na(PRESENCA_FILH_5a9) ),
                                digits=2 ),
      perc_fam_fx_et_2 = round( 100 * sum( PRESENCA_FILH_10a14==1, na.rm=T) /
                                  sum( !is.na(PRESENCA_FILH_10a14) ),
                                digits=2 ),
      perc_fam_fx_et_3 = round( 100 * sum( PRESENCA_FILH_15a19==1, na.rm=T) /
                                  sum( !is.na(PRESENCA_FILH_15a19) ),
                                digits=2 ),
      perc_fam_fx_et_60m = round( 100 * sum( PRESENCA_IDOSO_60_70==1 | PRESENCA_IDOSO_70==1, na.rm=T) /
                                    sum( !is.na(PRESENCA_IDOSO_60_70) | !is.na(PRESENCA_IDOSO_70)  ),
                                  digits=2 ),
      perc_fam_tem_auto = round( 100 * sum( PRESENCA_AUTO, na.rm=T) /
                                  sum( !is.na(PRESENCA_AUTO) ),
                                 digits=2 ),
      media_qt_auto_fam = round( mean( QT_AUTO, na.rm=T ),
                                 digits=2 )
    ) %>%
    dplyr::rename(
      "Média da Renda Familia (R$ - out/2007)" = media_renda_fam,
      "% de famílias sem renda" = perc_fam_sem_renda,
      "% de famílias na Classe E (até 2 SM)" = perc_fam_fx_renda_E,
      "% de famílias na Classe D (de 2 a 4 SM)" = perc_fam_fx_renda_D,
      "% de famílias na Classe C (de 4 a 10 SM)" = perc_fam_fx_renda_C,
      "% de famílias na Classe B (de 10 a 20 SM)" = perc_fam_fx_renda_B,
      "% de famílias na Classe A (mais de 20 SM)" = perc_fam_fx_renda_A,
      "Tamanho médio da família" = tam_med_fam,
      "% de famílias com presença de criança entre 0 e 4 anos" = perc_fam_fx_et_0,
      "% de famílias com presença de criança entre 5 e 9 anos" = perc_fam_fx_et_1,
      "% de famílias com presença de criança entre 10 e 14 anos" = perc_fam_fx_et_2,
      "% de famílias com presença de adolescente entre 15 e 19 anos" = perc_fam_fx_et_3,
      "% de famílias com presença de idosos com 60 anos ou mais" = perc_fam_fx_et_60m,
      "% de famílias que têm automóvel" = perc_fam_tem_auto,
      "Média da quantidade de autos na família" = media_qt_auto_fam
    )

  if(IMPRIME) {
    print.data.frame(resumo, row.names = FALSE, print.gap = 5 )
  }

  if( is.character(SALVA_EM) | is.character(NOME_ARQUIVO)){
    salva = .dirResultados
    if( is.character(SALVA_EM) ) {
      salva = file.path(sub(pattern = "^(.*)/$","\\1",SALVA_EM))
    }
    if( is.character(NOME_ARQUIVO) ) {
      salva = file.path(salva, paste0(NOME_ARQUIVO,'.csv'))
    } else {
      salva = file.path(salva, paste0("resumo_familia_por_",AGRUPA_POR,'.csv'))
    }

    cat("Salvando o resultado da análise no arquivo '", salva, "'", sep='')
    write.table( resumo, file=SALVA_EM, sep=';', dec=',', row.names=F )
  }

  if( RETORNA ) {
    return( resumo )
  }
}

resumo.resultados <-  function(DF=od,
                               AGRUPA_POR='ANO',
                               APENAS_COM_VIAGEM=T,
                               IMPRIME=T,
                               RETORNA=F,
                               SALVA_EM=NULL,
                               NOME_ARQUIVO=NULL) {
  #
  # Função que realiza uma sumarização do dataframe olhando
  # os recortes das categorias da variável de agrupamento.
  # Esta função irá salvar o resultado num arquivo CSV se pelo menos um dos
  # parâmetros (SALVA_EM e/ou NOME_ARQUIVO) forem fornecidos na chamada.
  #
  # Parâmetros:
  #           DF -> dataframe que será avaliado. Por padrão
  #                 a função utiliza um dataframe que já deve
  #                 estar carregado e possui o nome "od".
  #           AGRUPA_POR -> Parâmetro que será utilziado para
  #                 realizar os recortes a serem avaliados.
  #                 O padrão é realziar o recorte por ANO.
  #                 Assim, o resultado será dado para cada um
  #                 dos anos presentes na base.
  #           APENAS_COM_VIAGEM -> Parâmetro utilizado para
  #                 filtrar da análise apenas os registros
  #                 de viagens que foram realizadas (F_VIAG==1).
  #                 Por padrão esta variável é verdadeira (TRUE),
  #                 então as análises serão realizadas excluindo-se
  #                 os registros nos quais não houve viagem.
  #           IMPRIME -> Se a função deve imprimir o resultado da
  #                       análise no console ou não.
  #           RETORNA -> Se a função deve retornar um dataframe com os
  #                     resultados da análise para futura utilização
  #                     dos dados analisados/consolidados. Este
  #                     dataframe será retornado no console. Este
  #                     parâmetro não tem qualquer relação com salvar
  #                     o resultado da análise num arquivo CSV.
  #           SALVA_EM -> string com o caminho aonde o resultado deve ser salvo.
  #           NOME_ARQUIVO -> Nome do arquivo aonde o resultado será
  #                           salvo. Se essa informação não for passada
  #                           utiliza um nome default.
  #

  cat("Resumo completo dos resultados.", "\n")
  cat("Variável de agrupamento: ", AGRUPA_POR, "\n")
  cat("Considera registros sem viagem: ",
      ifelse(APENAS_COM_VIAGEM,"Não","Sim"), "\n")

  cat("\nCalculando resultados gerais... ")
  geral <- resumo.resultados.gerais(
                                DF = DF,
                                AGRUPA_POR = AGRUPA_POR,
                                IMPRIME = F,
                                RETORNA = T)
  cat("Resultados gerais calculados.\n")
  cat("Calculando resultados das variáveis das viagens... ")
  viagens <- resumo.resultados.viagens(
                                DF = DF,
                                AGRUPA_POR = AGRUPA_POR,
                                IMPRIME = F,
                                RETORNA = T,
                                APENAS_COM_VIAGEM = APENAS_COM_VIAGEM)
  cat("Resultados das variáveis de viagens calculados.\n")
  cat("Calculando resultados das variáveis das viagens... ")
  pessoas <- resumo.resultados.pessoas(
                                DF = DF,
                                AGRUPA_POR = AGRUPA_POR,
                                IMPRIME = F,
                                RETORNA = T)
  cat("Resultados das variáveis de pessoas calculados.\n")
  cat("Calculando resultados das variáveis das famílias... ")
  familias <- resumo.resultados.familias(
                                DF = DF,
                                AGRUPA_POR = AGRUPA_POR,
                                IMPRIME = F,
                                RETORNA = T)
  cat("Resultados das variáveis de famílias calculados.\n")

  # Juntando tudo
  completo <- cbind(
    geral,
    select_(viagens, lazyeval::interp(~-x, x = as.name(AGRUPA_POR))),
    select_(pessoas, lazyeval::interp(~-x, x = as.name(AGRUPA_POR))),
    select_(familias, lazyeval::interp(~-x, x = as.name(AGRUPA_POR)))
  )

  if(IMPRIME) {
    print.data.frame(completo, row.names = FALSE, print.gap = 5 )
  }

  if( is.character(SALVA_EM) | is.character(NOME_ARQUIVO)){
    salva = .dirResultados
    if( is.character(SALVA_EM) ) {
      salva = file.path(sub(pattern = "^(.*)/$","\\1",SALVA_EM))
    }
    if( is.character(NOME_ARQUIVO) ) {
      salva = file.path(salva, paste0(NOME_ARQUIVO,'.csv'))
    } else {
      salva = file.path(salva, paste0("resumo_por_",AGRUPA_POR,'.csv'))
    }

    cat("Salvando o resultado da análise no arquivo '", salva, "'", sep='')
    write.table( completo, file=salva, sep=';', dec=',', row.names=F )
  }

  if( RETORNA ) {
    return( completo )
  }

}

#
# passe o valor como uma string.
# P.ex: quanti_por_ano(FE_DOM)
quanti_por_grupo <- function(DF=od,
                             VARIAVEL=NULL,
                             AGRUPA_POR='ANO',
                             IMPRIME=T,
                             RETORNA=F,
                             SALVA_EM=NULL,
                             NOME_ARQUIVO=NULL) {

  # Função de sumarização de variáveis quanti por ano.
  # Esta função irá salvar o resultado num arquivo CSV se pelo menos um dos
  # parâmetros (SALVA_EM e/ou NOME_ARQUIVO) forem fornecidos na chamada.
  #
  # Parâmetros:
  #           DF -> Dataframe que será avaliado. Por padrão
  #                 a função irá buscar um dataframe já carregado
  #                 de nome "od", caso algum outro não seja
  #                 especificado
  #           VARIAVEL -> Variável do dataframe sendo avaliada.
  #           AGRUPA_POR -> Recortes que serão realizados da
  #                         variável sendo analizada. Por exemplo,
  #                         o padrão é "ANO". Então o resultado
  #                         da análise da variável VARIAVEL se
  #                         dará em cada um dos anos. Em qualquer
  #                         análise também será retornada a
  #                         "avaliação geral" (sem considerar os
  #                         recortes propostos por este parâmetro)
  #           IMPRIME -> Se a função deve imprimir o resultado da
  #                       análise no console ou não.
  #           RETORNA -> Se a função deve retornar um dataframe com os
  #                     resultados da análise para futura utilização
  #                     dos dados analisados/consolidados. Este
  #                     dataframe será retornado no console. Este
  #                     parâmetro não tem qualquer relação com salvar
  #                     o resultado da análise num arquivo CSV.
  #           SALVA_EM -> string com o caminho aonde o resultado
  #                       deve ser salvo.
  #           NOME_ARQUIVO -> Nome do arquivo aonde o resultado será
  #                           salvo. Se essa informação não for passada
  #                           utiliza um nome default.

  if(!is.character(VARIAVEL)) {
    stop("Por favor, passe o parâmetro VARIÁVEL para a função")
  }

    agrupado_a <- DF %>%
        group_by_(as.name(AGRUPA_POR)) %>%
        summarise_(
            min = lazyeval::interp(~min(x, na.rm=T), x=as.name(VARIAVEL)),
            q1 = lazyeval::interp(~quantile(x, na.rm=T)[2], x=as.name(VARIAVEL)),
            mediana = lazyeval::interp(~median(x, na.rm=T), x=as.name(VARIAVEL)),
            q3 = lazyeval::interp(~quantile(x, na.rm=T)[4], x=as.name(VARIAVEL)),
            max = lazyeval::interp(~max(x, na.rm=T), x=as.name(VARIAVEL))
        ) %>% as.data.frame()

    geral_a <- DF %>%
        summarise_(
            min = lazyeval::interp(~min(x, na.rm=T), x=as.name(VARIAVEL)),
            q1 = lazyeval::interp(~quantile(x, na.rm=T)[2], x=as.name(VARIAVEL)),
            mediana = lazyeval::interp(~median(x, na.rm=T), x=as.name(VARIAVEL)),
            q3 = lazyeval::interp(~quantile(x, na.rm=T)[4], x=as.name(VARIAVEL)),
            max = lazyeval::interp(~max(x, na.rm=T), x=as.name(VARIAVEL))
        ) %>% as.data.frame()

    geral_a[[AGRUPA_POR]] <- "Geral"

    parte_a = rbind(agrupado_a, geral_a)

    agrupado_b <- DF %>%
        group_by_(as.name(AGRUPA_POR)) %>%
        summarise_(
            media = lazyeval::interp(~mean(x, na.rm=T), x=as.name(VARIAVEL)),
            devPad = lazyeval::interp(~sd(x, na.rm=T), x=as.name(VARIAVEL)),
            skew = lazyeval::interp(~skew(x, na.rm=T), x=as.name(VARIAVEL)),
            curtose = lazyeval::interp(~kurtosi(x, na.rm=T), x=as.name(VARIAVEL)),
            NAs = lazyeval::interp(~sum(is.na(x)), x=as.name(VARIAVEL))
        ) %>% as.data.frame()

    geral_b <- od %>%
        summarise_(
            media = lazyeval::interp(~mean(x, na.rm=T), x=as.name(VARIAVEL)),
            devPad = lazyeval::interp(~sd(x, na.rm=T), x=as.name(VARIAVEL)),
            skew = lazyeval::interp(~skew(x, na.rm=T), x=as.name(VARIAVEL)),
            curtose = lazyeval::interp(~kurtosi(x, na.rm=T), x=as.name(VARIAVEL)),
            NAs = lazyeval::interp(~sum(is.na(x)), x=as.name(VARIAVEL))
        ) %>% as.data.frame()

    geral_b[[AGRUPA_POR]] <- "Geral"

    parte_b = rbind(agrupado_b, geral_b)

    retorno <- cbind(parte_a, parte_b[,-1])

    if( IMPRIME ) {
      print.data.frame(parte_a, right = 5, row.names = F)
      cat("\n")
      print.data.frame(parte_b, right = 5, row.names = F)
    }

    if( is.character(SALVA_EM) | is.character(NOME_ARQUIVO)){
      salva = .dirResultados
      if( is.character(SALVA_EM) ) {
        salva = file.path(sub(pattern = "^(.*)/$","\\1",SALVA_EM))
      }
      if( is.character(NOME_ARQUIVO) ) {
        salva = file.path(salva, paste0(NOME_ARQUIVO,'.csv'))
      } else {
        salva = file.path(salva, paste0("quanti-por-grupo-",AGRUPA_POR,'-',VARIAVEL,'.csv'))
      }

      cat("Salvando o resultado da análise no arquivo '", salva, "'", sep='')
      write.table( retorno, file=salva, sep=';', dec=',', row.names=F )
    }

    if( RETORNA ) {
      return(retorno)
    }
}

# quali_por_ano
#  xtabs(~ANO+CD_ENTRE, data=od, drop.unused.levels=FALSE) %>% t() %>% ftable()
#  od %>%
#    mutate(MODO4=factor(MODO4, exclude=NULL)) %>%
#    xtabs(~ANO+MODO4, data=., drop.unused.levels=FALSE, exclude=NULL) %>%
#    ftable()
