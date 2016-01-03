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

od$SEXO <- factor(od$SEXO,
                  levels=c(1,2),
                  labels=c("MASC","FEM"))

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

od$MOTIVO_ORIG <- factor(od$MOTIVO_ORIG,
                         levels=c(1,2,3,4,5,6,7,8,9),
                         labels=c('Trabalho/Indústria',
                                  'Trabalho/Comércio',
                                  'Trabalho/Serviços',
                                  'Educação',
                                  'Compras',
                                  'Saúde',
                                  'Lazer',
                                  'Residência',
                                  'Outros'))

od$MOTIVO_DEST <- factor(od$MOTIVO_DEST,
                         levels=c(1,2,3,4,5,6,7,8,9),
                         labels=c('Trabalho/Indústria',
                                  'Trabalho/Comércio',
                                  'Trabalho/Serviços',
                                  'Educação',
                                  'Compras',
                                  'Saúde',
                                  'Lazer',
                                  'Residência',
                                  'Outros'))

od$MODO1 <- factor(od$MODO1,
                   levels=c(1,2,3,4,5,6,7,8,9,10,11,12),
                   labels=c('Ônibus',
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
                            'Outros'))

od$MODO2 <- factor(od$MODO2,
                   levels=c(1,2,3,4,5,6,7,8,9,10,11,12),
                   labels=c('Ônibus',
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
                            'Outros'))

od$MODO3 <- factor(od$MODO3,
                   levels=c(1,2,3,4,5,6,7,8,9,10,11,12),
                   labels=c('Ônibus',
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
                            'Outros'))

od$MODO4 <- factor(od$MODO4,
                   levels=c(1,2,3,4,5,6,7,8,9,10,11,12),
                   labels=c('Ônibus',
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
                            'Outros'))

od$MODO_PRIN <- factor(od$MODO_PRIN,
                   levels=c(1,2,3,4,5,6,7,8,9,10,11,12),
                   labels=c('Ônibus',
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
                            'Outros'))

od$TIPO_VIAG <- factor(od$TIPO_VIAG,
                       levels=c(1,2,3),
                       labels=c('Coletivo',
                                'Individual',
                                'A pé'))

od$TIPO_EST_AUTO <- factor(od$TIPO_EST_AUTO,
                           levels=c(1,2,3,4,5),
                           labels=c('Não estacionou',
                                    'Estacionamento Particular (Avulso / Mensal / Próprio / Patrocinado)',
                                    'Estacionamento Público (meio fio / zona azul / zona marrom / parquímetro)'))

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

od$FAIXA_HORARIA <- factor(od$FAIXA_HORARIA,
                           levels=c(0,1,2,3,4),
                           labels=c('Não fez viagem',
                                    'madrugada',
                                    'manhã',
                                    'tarde',
                                    'noite'))