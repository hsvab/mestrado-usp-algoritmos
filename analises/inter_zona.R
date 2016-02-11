od12 <- od11 %>% mutate (VIAG_INTER_ZONA = ifelse
                                      (ZONA_ORIG==ZONA_DEST &
                                        !is.na(ZONA_ORIG) &
                                        !is.na(ZONA_DEST),
                                      0,
                                      1
                                      )
                    )
