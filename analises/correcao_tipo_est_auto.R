od <- od %>%
    mutate(
        TIPO_EST_AUTO =
            ifelse(
                TIPO_EST_AUTO==0,
                NA,
                ifelse(
                    TIPO_EST_AUTO==1,
                    0,
                    ifelse(
                        TIPO_EST_AUTO==2 | TIPO_EST_AUTO==3 | TIPO_EST_AUTO==4,
                        1,
                        2
                    )
                )
            )
    )