# Variáveis binárias:
od$F_DOM <- as.logical(od$F_DOM)
od$F_FAM <- as.logical(od$F_FAM)
od$F_PESS <- as.logical(od$F_PESS)
od$F_VIAG <- as.logical(od$F_VIAG)
od$VIAG_MODO_ONIBUS <- as.logical(od$VIAG_MODO_ONIBUS)
od$VIAG_MODO_DIRIG <- as.logical(od$VIAG_MODO_DIRIG)
od$VIAG_MODO_PASS <- as.logical(od$VIAG_MODO_PASS)
od$VIAG_MODO_TREM <- as.logical(od$VIAG_MODO_TREM)
od$VIAG_MODO_MOTO <- as.logical(od$VIAG_MODO_MOTO)
od$VIAG_MODO_BICI <- as.logical(od$VIAG_MODO_BICI)
od$VIAG_MODO_APE <- as.logical(od$VIAG_MODO_APE)
od$VIAG_MODO_OUTROS <- as.logical(od$VIAG_MODO_OUTROS)
od$VIAG_MOTIVO_TRAB <- as.logical(od$VIAG_MOTIVO_TRAB)
od$VIAG_MOTIVO_EDUC <- as.logical(od$VIAG_MOTIVO_EDUC)
od$VIAG_MOTIVO_RES <- as.logical(od$VIAG_MOTIVO_RES)
od$VIAG_MOTIVO_OUTROS <- as.logical(od$VIAG_MOTIVO_OUTROS)
od$VIAG_PER_MADRUG <- as.logical(od$VIAG_PER_MADRUG)
od$VIAG_PER_COM_MAN <- as.logical(od$VIAG_PER_COM_MAN)
od$VIAG_PER_MANHA <- as.logical(od$VIAG_PER_MANHA)
od$VIAG_PER_MEIODIA <- as.logical(od$VIAG_PER_MEIODIA)
od$VIAG_PER_TARDE <- as.logical(od$VIAG_PER_TARDE)
od$VIAG_PER_COM_NOI <- as.logical(od$VIAG_PER_COM_NOI)
od$VIAG_PER_NOITE <- as.logical(od$VIAG_PER_NOITE)
od$FX_ET_0 <- as.logical(od$FX_ET_0)
od$FX_ET_1 <- as.logical(od$FX_ET_1)
od$FX_ET_2 <- as.logical(od$FX_ET_2)
od$FX_ET_3 <- as.logical(od$FX_ET_3)
od$FX_ET_4 <- as.logical(od$FX_ET_4)
od$FX_ET_5 <- as.logical(od$FX_ET_5)
od$FX_ET_6 <- as.logical(od$FX_ET_6)
od$FX_ET_7 <- as.logical(od$FX_ET_7)
od$FX_ET_8 <- as.logical(od$FX_ET_8)
od$FX_ET_9 <- as.logical(od$FX_ET_9)
od$FX_ET_10 <- as.logical(od$FX_ET_10)
od$FX_ET_11 <- as.logical(od$FX_ET_11)
od$FX_ET_12 <- as.logical(od$FX_ET_12)
od$FX_ET_13 <- as.logical(od$FX_ET_13)
od$FX_ET_14 <- as.logical(od$FX_ET_14)
od$FX_ET_15 <- as.logical(od$FX_ET_15)
od$FX_ET_16 <- as.logical(od$FX_ET_16)
od$FX_ET_17 <- as.logical(od$FX_ET_17)
od$FX_ET_18 <- as.logical(od$FX_ET_18)
od$FX_ET_19 <- as.logical(od$FX_ET_19)
od$FX_ET_20 <- as.logical(od$FX_ET_20)
od$PRESENCA_IDOSO_60_70 <- as.logical(od$PRESENCA_IDOSO_60_70)
od$PRESENCA_IDOSO_70 <- as.logical(od$PRESENCA_IDOSO_70)
od$PRESENCA_FILH_ate4 <- as.logical(od$PRESENCA_FILH_ate4)
od$PRESENCA_FILH_5a9 <- as.logical(od$PRESENCA_FILH_5a9)
od$PRESENCA_FILH_10a14 <- as.logical(od$PRESENCA_FILH_10a14)
od$PRESENCA_FILH_15a19 <- as.logical(od$PRESENCA_FILH_15a19)
od$PRESENCA_AUTO <- as.logical(od$PRESENCA_AUTO)

################################################################################
################################################################################
# Transformar essa variável em factor ao invés de "binária" (logical)?
################################################################################
od$ANDA_ORIG <- as.logical(od$ANDA_ORIG)

################################################################################
################################################################################
# Transformar essa variável em factor ao invés de "binária" (logical)?
################################################################################
od$ANDA_DEST <- as.logical(od$ANDA_DEST)

od$ANO <- factor(od$ANO,
                 levels=c(1,2,3,4),
                 labels=c("1977","1987","1997","2007"))

od$CD_ENTRE <- factor(od$CD_ENTRE,
                      levels=c(0,1),
                      labels=c("Entrevista Completa Sem Viagem",
                               "Entrevista Completa Com Viagem"))

od$DIA_SEM <- factor(od$DIA_SEM,
                    levels=c(2,3,4,5,6),
                    labels=c('Segunda-feira',
                             'Terça-feira',
                             'Quarta-feira',
                             'Quinta-feira',
                             'Sexta-feira'))

od$UCOD_DOM <- factor(od$UCOD_DOM)
od$UCOD_ESC <- factor(od$UCOD_ESC)
od$UCOD_TRAB1 <- factor(od$UCOD_TRAB1)
od$UCOD_TRAB2 <- factor(od$UCOD_TRAB2)
od$UCOD_ORIG <- factor(od$UCOD_ORIG)
od$UCOD_DEST <- factor(od$UCOD_DEST)

od$MUN_DOM <- factor(od$MUN_DOM)
od$MUN_ESC <- factor(od$MUN_ESC)
od$MUN_TRAB1 <- factor(od$MUN_TRAB1)
od$MUN_TRAB2 <- factor(od$MUN_TRAB2)
od$MUN_ORIG <- factor(od$MUN_ORIG)
od$MUN_DEST <- factor(od$MUN_DEST)

od$ZONA_DOM <- factor(od$ZONA_DOM)
od$ZONA_ESC <- factor(od$ZONA_ESC)
od$ZONA_TRAB1 <- factor(od$ZONA_TRAB1)
od$ZONA_TRAB2 <- factor(od$ZONA_TRAB2)
od$ZONA_ORIG <- factor(od$ZONA_ORIG)
od$ZONA_DEST <- factor(od$ZONA_DEST)

od$SUBZONA_DOM <- factor(od$UCOD_DOM)
od$SUBZONA_ESC <- factor(od$UCOD_ESC)
od$SUBZONA_TRAB1 <- factor(od$UCOD_TRAB1)
od$SUBZONA_TRAB2 <- factor(od$UCOD_TRAB2)
od$SUBZONA_ORIG <- factor(od$UCOD_ORIG)
od$SUBZONA_DEST <- factor(od$UCOD_DEST)

od$TIPO_DOM <- factor(od$TIPO_DOM,
                      levels=c(0,1),
                      labels=c('Coletivo',
                               'Particular'))

od$COND_MORA <- factor(od$COND_MORA,
                       levels=c(1,2,3),
                       labels=c('Alugada',
                                'Própria',
                                'Outros'))

od$CD_RENFAM <- factor(od$CD_RENFAM,
                       levels=c(0,1,2),
                       labels=c('Renda familiar declarada como zero',
                                'Renda familiar declarada e maior que zero',
                                'Renda familiar atribuída'))

od$SIT_FAM <- factor(od$SIT_FAM,
                     levels=c(0,1,2,3,4,5,6),
                     labels=c('Não respondeu',
                              'Pessoa responsável',
                              'Cônjuge / Companheiro(a)',
                              'Filho(a) / Enteado(a)',
                              'Outro parente / Agregado',
                              'Empregado residente',
                              'Outros (visitante não residente / parente do empregado'))

od$SEXO <- factor(od$SEXO,
                  levels=c(0,1),
                  labels=c("MASC","FEM"))

od$ESTUDA <- factor(od$ESTUDA,
                    levels=c(0,1),
                    labels=c('Não estuda',
                             'Estuda'))

od$GRAU_INSTR <- factor(od$GRAU_INSTR,
                        levels=c(1,2,3,4),
                        labels=c('Não-alfabetizado / Fundamental incompleto',
                                 'Fundamental completo / Médio incompleto',
                                 'Médio completo / Superior incompleto',
                                 'Superior completo'))

od$OCUP <- factor(od$OCUP,
                  levels=c(1,2,3,4,5,6,7),
                  labels=c('Tem trabalho',
                           'Em licença médica',
                           'Aposentado / pensionista',
                           'Desempregado',
                           'Sem ocupação',
                           'Dona de casa',
                           'Estudante'))

od$SETOR_ATIV <- factor(od$SETOR_ATIV,
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

od$CD_RENIND <- factor(od$CD_RENIND,
                       levels=c(0,1),
                       labels=c('Não tem renda',
                                'Tem renda'))

od$SERV_PAS_ORIG <- factor(od$SERV_PAS_ORIG,
                           levels=c(0,1),
                           labels=c('Não',
                                    'Sim'))

od$SERV_PAS_DEST <- factor(od$SERV_PAS_DEST,
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
od$MOTIVO_ORIG <- factor(od$MOTIVO_ORIG,
                         levels=motivos_levels,
                         labels=motivos_labels)

od$MOTIVO_DEST <- factor(od$MOTIVO_DEST,
                         levels=motivos_levels,
                         labels=motivos_labels)

rm(motivos_levels, motivos_labels)

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

od$MODO1 <- factor(od$MODO1,
                   levels=modos_levels,
                   labels=modos_labels)

od$MODO2 <- factor(od$MODO2,
                   levels=modos_levels,
                   labels=modos_labels)

od$MODO3 <- factor(od$MODO3,
                   levels=modos_levels,
                   labels=modos_labels)

od$MODO4 <- factor(od$MODO4,
                   levels=modos_levels,
                   labels=modos_labels)

od$MODO_PRIN <- factor(od$MODO_PRIN,
                   levels=modos_levels,
                   labels=modos_labels)

rm(modos_levels, modos_labels)

################################################################################
################################################################################
# Tem alguns registros com TIPO_VIAG==4. O que fazer? Transformar em NA?
# TODO??
################################################################################
# od$TIPO_VIAG <- factor(od$TIPO_VIAG,
#                        levels=c(1,2,3),
#                        labels=c('Coletivo',
#                                 'Individual',
#                                 'A pé'))

od$TIPO_EST_AUTO <- factor(od$TIPO_EST_AUTO,
                           levels=c(0,1,2),
                           labels=c('Não estacionou',
                                    'Estacionamento Privado (Particuar avulso ou Mensal, próprio ou patrocinado)',
                                    'Estacionamento Público (na rua)'))

od$FAIXA_ETARIA <- factor(od$FAIXA_ETARIA,
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

od$FAIXA_HORARIA <- factor(od$FAIXA_HORARIA,
                           levels=c(0,1,2,3,4),
                           labels=c('Não fez viagem',
                                    'madrugada',
                                    'manhã',
                                    'tarde',
                                    'noite'))

od$FAIXA_REN_FAM <- factor(od$FAIXA_REN_FAM,
                          levels=c(0,5,4,3,2,1),
                          labels=c('Sem renda',
                                   'Classe E (até 2 SM)',
                                   'Classe D (de 2 a 4 SM)',
                                   'Classe C (de 4 a 10 SM)',
                                   'Classe B (de 10 a 20 SM)',
                                   'Classe A (mais de 20 SM)'))

od$FAIXA_REN_IND <- factor(od$FAIXA_REN_IND,
                           levels=c(0,7,6,5,4,3,2,1),
                           labels=c('Sem renda',
                                    'até 1 SM',
                                    'de 1 a 2 SM',
                                    'de 2 a 3 SM',
                                    'de 3 a 5 SM',
                                    'de 5 a 10 SM',
                                    'de 10 a 15 SM',
                                    'mais de 15 SM'))
