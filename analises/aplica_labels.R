od$ANO <- factor(od$ANO,
                 levels=c(1,2,3,4),
                 labels=c("1977","1987","1997","2007"))

od$CD_ENTRE <- factor(od$CD_ENTRE,
                      levels=c(0,1),
                      labels=c("Entrevista Completa Sem Viagem",
                               "Entrevista Completa Com Viagem"))

od$DIA_SEM <- factor(od$DIA_SEM,
                    levels=c(0,2,3,4,5,6),
                    labels=c('Não Respondeu',
                             'Segunda-feira',
                             'Terça-feira',
                             'Quarta-feira',
                             'Quinta-feira',
                             'Sexta-feira'))

od$SEXO <- factor(od$SEXO,
                  levels=c(1,2),
                  labels=c("MASC","FEM"))

od$TIPO_DOM <- factor(od$TIPO_DOM,
                      levels=c(0,1,2),
                      labels=c('Não respondeu',
                               'Particular',
                               'Coletivo'))

od$COND_MORA <- factor(od$COND_MORA,
                       levels=c(0,1,2,3),
                       labels=c('Não respondeu',
                                'Alugada',
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
                        levels=c(0,1,2,3,4),
                        labels=c('Não declarou',
                                 'Não-alfabetizado / Fundamental incompleto',
                                 'Fundamental completo / Médio incompleto',
                                 'Médio completo / Superior incompleto',
                                 'Superior completo'))

od$OCUP <- factor(od$OCUP,
                  levels=c(0,1,2,3,4,5,6,7),
                  labels=c('Não respondeu',
                           'Tem trabalho',
                           'Em licença médica',
                           'Aposentado / pensionista',
                           'Desempregado',
                           'Sem ocupação',
                           'Dona de casa',
                           'Estudante'))

od$SETOR_ATIV <- factor(od$SETOR_ATIV,
                        levels=c(0,1,2,3,4,5,6,7,8,9),
                        labels=c('Não respondeu',
                                 'Agrícola',
                                 'Construção civil',
                                 'Indústria',
                                 'Comércio',
                                 'Administração pública',
                                 'Serviços de transporte',
                                 'Outros serviços',
                                 'Outros',
                                 'Não se aplica'))

od$CD_RENIND <- factor(od$CD_RENIND,
                       levels=c(0,1,2),
                       labels=c('Não declarou',
                                'Tem renda',
                                'Não tem renda'))

od$SERV_PAS_ORIG <- factor(od$SERV_PAS_ORIG,
                           levels=c(0,1,2),
                           labels=c('Não respondido',
                                    'Sim',
                                    'Não'))

od$SERV_PAS_DEST <- factor(od$SERV_PAS_DEST,
                           levels=c(0,1,2),
                           labels=c('Não respondido',
                                    'Sim',
                                    'Não'))

od$MOTIVO_ORIG <- factor(od$MOTIVO_ORIG,
                         levels=c(0,1,2,3,4,5,6,7,8,9),
                         labels=c('Não respondeu/não fez viagem',
                                  'Trabalho/Indústria',
                                  'Trabalho/Comércio',
                                  'Trabalho/Serviços',
                                  'Educação',
                                  'Compras',
                                  'Saúde',
                                  'Lazer',
                                  'Residência',
                                  'Outros'))

od$MOTIVO_DEST <- factor(od$MOTIVO_DEST,
                         levels=c(0,1,2,3,4,5,6,7,8,9),
                         labels=c('Não respondeu/não fez viagem',
                                  'Trabalho/Indústria',
                                  'Trabalho/Comércio',
                                  'Trabalho/Serviços',
                                  'Educação',
                                  'Compras',
                                  'Saúde',
                                  'Lazer',
                                  'Residência',
                                  'Outros'))

od$MODO1 <- factor(od$MODO1,
                   levels=c(0,1,2,3,4,5,6,7,8,9,10,11,12),
                   labels=c('Não respondeu/não fez viagem',
                            'Ônibus',
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
                   levels=c(0,1,2,3,4,5,6,7,8,9,10,11,12),
                   labels=c('Não respondeu/não fez viagem',
                            'Ônibus',
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
                   levels=c(0,1,2,3,4,5,6,7,8,9,10,11,12),
                   labels=c('Não respondeu/não fez viagem',
                            'Ônibus',
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
                   levels=c(0,1,2,3,4,5,6,7,8,9,10,11,12),
                   labels=c('Não respondeu/não fez viagem',
                            'Ônibus',
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
                   levels=c(0,1,2,3,4,5,6,7,8,9,10,11,12),
                   labels=c('Não respondeu/não fez viagem',
                            'Ônibus',
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
                       levels=c(0,1,2,3),
                       labels=c('Não respondeu',
                                'Coletivo',
                                'Individual',
                                'A pé'))

od$TIPO_EST_AUTO <- factor(od$TIPO_EST_AUTO,
                           levels=c(0,1,2,3,4,5),
                           labels=c('Não respondeu',
                                    'Não estacionou',
                                    'Estacionamento particular (Avulso/Mensal)',
                                    'Estacionamento próprio',
                                    'Estacionamento patrocinado',
                                    'Rua (meio fio / zona azul / zona marrom / parquímetro)'))