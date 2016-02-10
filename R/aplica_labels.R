local({

    aplica.labels <- function(df) {
      if(is.data.frame(df)) {
        # Variáveis binárias:
        df$F_DOM <- as.logical(df$F_DOM)
        df$F_FAM <- as.logical(df$F_FAM)
        df$F_PESS <- as.logical(df$F_PESS)
        df$F_VIAG <- as.logical(df$F_VIAG)
        df$VIAG_MODO_ONIBUS <- as.logical(df$VIAG_MODO_ONIBUS)
        df$VIAG_MODO_DIRIG <- as.logical(df$VIAG_MODO_DIRIG)
        df$VIAG_MODO_PASS <- as.logical(df$VIAG_MODO_PASS)
        df$VIAG_MODO_TREM <- as.logical(df$VIAG_MODO_TREM)
        df$VIAG_MODO_MOTO <- as.logical(df$VIAG_MODO_MOTO)
        df$VIAG_MODO_BICI <- as.logical(df$VIAG_MODO_BICI)
        df$VIAG_MODO_APE <- as.logical(df$VIAG_MODO_APE)
        df$VIAG_MODO_OUTROS <- as.logical(df$VIAG_MODO_OUTROS)
        df$VIAG_MOTIVO_TRAB <- as.logical(df$VIAG_MOTIVO_TRAB)
        df$VIAG_MOTIVO_EDUC <- as.logical(df$VIAG_MOTIVO_EDUC)
        df$VIAG_MOTIVO_RES <- as.logical(df$VIAG_MOTIVO_RES)
        df$VIAG_MOTIVO_MANUT_COMPRAS <- as.logical(df$VIAG_MOTIVO_MANUT_COMPRAS)
        df$VIAG_MOTIVO_LAZER_OUTROS <- as.logical(df$VIAG_MOTIVO_LAZER_OUTROS)
        df$VIAG_PER_MADRUG <- as.logical(df$VIAG_PER_MADRUG)
        df$VIAG_PER_COM_MAN <- as.logical(df$VIAG_PER_COM_MAN)
        df$VIAG_PER_MANHA <- as.logical(df$VIAG_PER_MANHA)
        df$VIAG_PER_MEIODIA <- as.logical(df$VIAG_PER_MEIODIA)
        df$VIAG_PER_TARDE <- as.logical(df$VIAG_PER_TARDE)
        df$VIAG_PER_COM_NOI <- as.logical(df$VIAG_PER_COM_NOI)
        df$VIAG_PER_NOITE <- as.logical(df$VIAG_PER_NOITE)
        df$FX_ET_0 <- as.logical(df$FX_ET_0)
        df$FX_ET_1 <- as.logical(df$FX_ET_1)
        df$FX_ET_2 <- as.logical(df$FX_ET_2)
        df$FX_ET_3 <- as.logical(df$FX_ET_3)
        df$FX_ET_4 <- as.logical(df$FX_ET_4)
        df$FX_ET_5 <- as.logical(df$FX_ET_5)
        df$FX_ET_6 <- as.logical(df$FX_ET_6)
        df$FX_ET_7 <- as.logical(df$FX_ET_7)
        df$FX_ET_8 <- as.logical(df$FX_ET_8)
        df$FX_ET_9 <- as.logical(df$FX_ET_9)
        df$FX_ET_10 <- as.logical(df$FX_ET_10)
        df$FX_ET_11 <- as.logical(df$FX_ET_11)
        df$FX_ET_12 <- as.logical(df$FX_ET_12)
        df$FX_ET_13 <- as.logical(df$FX_ET_13)
        df$FX_ET_14 <- as.logical(df$FX_ET_14)
        df$FX_ET_15 <- as.logical(df$FX_ET_15)
        df$FX_ET_16 <- as.logical(df$FX_ET_16)
        df$FX_ET_17 <- as.logical(df$FX_ET_17)
        df$FX_ET_18 <- as.logical(df$FX_ET_18)
        df$FX_ET_19 <- as.logical(df$FX_ET_19)
        df$FX_ET_20 <- as.logical(df$FX_ET_20)
        df$PRESENCA_IDOSO_60_70 <- as.logical(df$PRESENCA_IDOSO_60_70)
        df$PRESENCA_IDOSO_70 <- as.logical(df$PRESENCA_IDOSO_70)
        df$PRESENCA_FILH_ate4 <- as.logical(df$PRESENCA_FILH_ate4)
        df$PRESENCA_FILH_5a9 <- as.logical(df$PRESENCA_FILH_5a9)
        df$PRESENCA_FILH_10a14 <- as.logical(df$PRESENCA_FILH_10a14)
        df$PRESENCA_FILH_15a19 <- as.logical(df$PRESENCA_FILH_15a19)
        df$PRESENCA_AUTO <- as.logical(df$PRESENCA_AUTO)

        ################################################################################
        ################################################################################
        # Transformar essa variável em factor ao invés de "binária" (logical)?
        ################################################################################
        df$ANDA_ORIG <- as.logical(df$ANDA_ORIG)

        ################################################################################
        ################################################################################
        # Transformar essa variável em factor ao invés de "binária" (logical)?
        ################################################################################
        df$ANDA_DEST <- as.logical(df$ANDA_DEST)

        df$ANO <- factor(df$ANO,
                         levels=c(1,2,3,4),
                         labels=c("1977","1987","1997","2007"))

        df$CD_ENTRE <- factor(df$CD_ENTRE,
                              levels=c(0,1),
                              labels=c("Entrevista Completa Sem Viagem",
                                       "Entrevista Completa Com Viagem"))

        df$DIA_SEM <- factor(df$DIA_SEM,
                             levels=c(2,3,4,5,6),
                             labels=c('Segunda-feira',
                                      'Terça-feira',
                                      'Quarta-feira',
                                      'Quinta-feira',
                                      'Sexta-feira'))

        df$UCOD_DOM <- factor(df$UCOD_DOM)
        df$UCOD_ESC <- factor(df$UCOD_ESC)
        df$UCOD_TRAB1 <- factor(df$UCOD_TRAB1)
        df$UCOD_TRAB2 <- factor(df$UCOD_TRAB2)
        df$UCOD_ORIG <- factor(df$UCOD_ORIG)
        df$UCOD_DEST <- factor(df$UCOD_DEST)

        df$MUN_DOM <- factor(df$MUN_DOM)
        df$MUN_ESC <- factor(df$MUN_ESC)
        df$MUN_TRAB1 <- factor(df$MUN_TRAB1)
        df$MUN_TRAB2 <- factor(df$MUN_TRAB2)
        df$MUN_ORIG <- factor(df$MUN_ORIG)
        df$MUN_DEST <- factor(df$MUN_DEST)

        df$ZONA_DOM <- factor(df$ZONA_DOM)
        df$ZONA_ESC <- factor(df$ZONA_ESC)
        df$ZONA_TRAB1 <- factor(df$ZONA_TRAB1)
        df$ZONA_TRAB2 <- factor(df$ZONA_TRAB2)
        df$ZONA_ORIG <- factor(df$ZONA_ORIG)
        df$ZONA_DEST <- factor(df$ZONA_DEST)

        df$SUBZONA_DOM <- factor(df$SUBZONA_DOM)
        df$SUBZONA_ESC <- factor(df$SUBZONA_ESC)
        df$SUBZONA_TRAB1 <- factor(df$SUBZONA_TRAB1)
        df$SUBZONA_TRAB2 <- factor(df$SUBZONA_TRAB2)
        df$SUBZONA_ORIG <- factor(df$SUBZONA_ORIG)
        df$SUBZONA_DEST <- factor(df$SUBZONA_DEST)

        df$TIPO_DOM <- factor(df$TIPO_DOM,
                              levels=c(0,1),
                              labels=c('Coletivo',
                                       'Particular'))

        df$COND_MORA <- factor(df$COND_MORA,
                               levels=c(1,2,3),
                               labels=c('Alugada',
                                        'Própria',
                                        'Outros'))

        df$CD_RENFAM <- factor(df$CD_RENFAM,
                               levels=c(0,1,2),
                               labels=c('Renda familiar declarada como zero',
                                        'Renda familiar declarada e maior que zero',
                                        'Renda familiar atribuída'))

        df$SIT_FAM <- factor(df$SIT_FAM,
                             levels=c(1,2,3,4,5,6),
                             labels=c('Pessoa responsável',
                                      'Cônjuge / Companheiro(a)',
                                      'Filho(a) / Enteado(a)',
                                      'Outro parente / Agregado',
                                      'Empregado residente',
                                      'Outros (visitante não residente / parente do empregado)'))

        df$SEXO <- factor(df$SEXO,
                          levels=c(0,1),
                          labels=c("Masculino","Feminino"))

        df$ESTUDA <- factor(df$ESTUDA,
                            levels=c(0,1),
                            labels=c('Não estuda',
                                     'Estuda'))

        df$GRAU_INSTR <- factor(df$GRAU_INSTR,
                                levels=c(1,2,3,4),
                                labels=c('Não-alfabetizado / Fundamental incompleto',
                                         'Fundamental completo / Médio incompleto',
                                         'Médio completo / Superior incompleto',
                                         'Superior completo'))

        df$OCUP <- factor(df$OCUP,
                          levels=c(1,2,3,4,5,6,7),
                          labels=c('Tem trabalho',
                                   'Em licença médica',
                                   'Aposentado / pensionista',
                                   'Desempregado',
                                   'Sem ocupação',
                                   'Dona de casa',
                                   'Estudante'))

        df$SETOR_ATIV <- factor(df$SETOR_ATIV,
                                levels=c(1,2,3,4,5,6,7,8,9),
                                labels=c('Agrícola',
                                         'Construção civil',
                                         'Indústria',
                                         'Comércio',
                                         'Administração pública',
                                         'Serviços de transporte',
                                         'Outros serviços',
                                         'Outros',
                                         'Não se aplica'))

        df$CD_RENIND <- factor(df$CD_RENIND,
                               levels=c(0,1),
                               labels=c('Não tem renda',
                                        'Tem renda'))

        df$SERV_PAS_ORIG <- factor(df$SERV_PAS_ORIG,
                                   levels=c(0,1),
                                   labels=c('Não',
                                            'Sim'))

        df$SERV_PAS_DEST <- factor(df$SERV_PAS_DEST,
                                   levels=c(0,1),
                                   labels=c('Não',
                                            'Sim'))

        motivos_levels = c(1,2,3,4,5,6,7,8,9)
        motivos_labels = c('Trabalho/Indústria',
                           'Trabalho/Comércio',
                           'Trabalho/Serviços',
                           'Educação',
                           'Compras',
                           'Saúde',
                           'Lazer',
                           'Residência',
                           'Outros')
        df$MOTIVO_ORIG <- factor(df$MOTIVO_ORIG,
                                 levels=motivos_levels,
                                 labels=motivos_labels)

        df$MOTIVO_DEST <- factor(df$MOTIVO_DEST,
                                 levels=motivos_levels,
                                 labels=motivos_labels)

        modos_levels = c(1,2,3,4,5,6,7,8,9,10,11,12)
        modos_labels = c('Ônibus',
                         'Ônibus escolar / empresa',
                         'Dirigindo automóvel',
                         'Passageiro de automóvel',
                         'Táxi',
                         'Lotação / Perua / Van / Microônibus',
                         'Metrô',
                         'Trem',
                         'Moto',
                         'Bicicleta',
                         'A pé',
                         'Outros')

        df$MODO1 <- factor(df$MODO1,
                           levels=modos_levels,
                           labels=modos_labels)

        df$MODO2 <- factor(df$MODO2,
                           levels=modos_levels,
                           labels=modos_labels)

        df$MODO3 <- factor(df$MODO3,
                           levels=modos_levels,
                           labels=modos_labels)

        df$MODO4 <- factor(df$MODO4,
                           levels=modos_levels,
                           labels=modos_labels)

        df$MODO_PRIN <- factor(df$MODO_PRIN,
                               levels=modos_levels,
                               labels=modos_labels)

        ################################################################################
        ################################################################################
        # Tem alguns registros com TIPO_VIAG==4. O que fazer? Transformar em NA?
        # TODO??
        ################################################################################
        df$TIPO_VIAG <- factor(df$TIPO_VIAG,
                              levels=c(1,2,3,4),
                              labels=c('Coletivo',
                                       'Individual',
                                       'A pé',
                                       'outros'))

        df$TIPO_EST_AUTO <- factor(df$TIPO_EST_AUTO,
                                   levels=c(0,1,2),
                                   labels=c('Não estacionou',
                                            'Estacionamento Privado (Particuar avulso ou Mensal, próprio ou patrocinado)',
                                            'Estacionamento Público (na rua)'))

        df$FAIXA_ETARIA <- factor(df$FAIXA_ETARIA,
                                  levels=c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),
                                  labels= c('0 a 4 anos',
                                            '5 a 9 anos',
                                            '10 a 14 anos',
                                            '15 a 19 anos',
                                            '20 a 24 anos',
                                            '25 a 29 anos',
                                            '30 a 34 anos',
                                            '35 a 39 anos',
                                            '40 a 44 anos',
                                            '45 a 49 anos',
                                            '50 a 54 anos',
                                            '55 a 59 anos',
                                            '60 a 64 anos',
                                            '65 a 69 anos',
                                            '70 a 74 anos',
                                            '75 a 79 anos',
                                            '80 a 84 anos',
                                            '85 a 89 anos',
                                            '90 a 94 anos',
                                            '95 a 99 anos',
                                            'mais de 100 anos'))

        df$FAIXA_HORARIA <- factor(df$FAIXA_HORARIA,
                                   levels=c(0,1,2,3,4),
                                   labels=c('Não fez viagem',
                                            'madrugada',
                                            'manhã',
                                            'tarde',
                                            'noite'))

        df$FAIXA_REN_FAM <- factor(df$FAIXA_REN_FAM,
                                   levels=c(0,1,2,3,4,5),
                                   labels=c('Sem renda',
                                            'Classe E',
                                            'Classe D',
                                            'Classe C',
                                            'Classe B',
                                            'Classe A'))

        df$FAIXA_REN_IND <- factor(df$FAIXA_REN_IND,
                                   levels=c(0,1,2,3,4,5,6,7),
                                   labels=c('Sem renda',
                                            'até 1 SM',
                                            'de 1 a 2 SM',
                                            'de 2 a 3 SM',
                                            'de 3 a 5 SM',
                                            'de 5 a 10 SM',
                                            'de 10 a 15 SM',
                                            'mais de 15 SM'))

        print("Labels aplicadas. Retornando dataframe com fatores/labels.", quote = FALSE)
        return(df)
      }
      stop("O objeto passado não é um dataframe, abortando...")
    }

    assign(".mestrado.aplica.labels", aplica.labels,
           envir=globalenv())
})
