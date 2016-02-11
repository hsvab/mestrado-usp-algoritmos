library("RColorBrewer")
display.brewer.pal(n = 3, name = 'Set3')
display.brewer.pal(n = 4, name = 'Set3')
display.brewer.pal(n = 9, name = 'Set3')
#### FAMCLUSTER2
####
# PESS_DIST_MED
#select(filter(od, famcluster2==1),PESS_DIST_TOT) %>% describe()
od %>% filter(F_PESS==1) %>%
    ggplot(data=., aes(x=PESS_DIST_TOT)) +
    facet_grid(famcluster2 ~ .) +
    geom_density(fill="#FF6666", alpha=.5) +
    stat_function(fun = dnorm,
                  color="red",
                  args = list(mean = 3793.44, sd = 5515.29)) +
    ggtitle('Distribuição da Distância total percorrida por pessoa para o Famcluster2') +
    xlab('Distância percorrida') +
    ylab("Densidade")

#TOT_VIAG
od %>% filter(F_PESS==1) %>% select(TOT_VIAG, famcluster2) %>% describeBy(group="famcluster2")
od %>% filter(F_PESS==1) %>% mutate(famcluster2=factor(famcluster2)) %>%
    ggplot(aes(x=TOT_VIAG, fill=famcluster2)) +
    facet_grid(famcluster2 ~.) +
    geom_histogram(binwidth=1, alpha=0.5,
                   aes(y=..density..)) +
    #scale_fill_gradient("Count", low="#DCDCDC", high="#7C7C7C") +
    stat_function(fun=dnorm,
                  color="red",
                  arg=list(mean=1.75,
                           sd=1.62)) +
    stat_function(fun=dnorm,
                  color="green",
                  arg=list(mean=1.69,
                           sd=1.72)) +
    ggtitle("Total de viagens por pessoa para o Famcluster2") +
    xlab('Total de viagens') +
    ylab('Densidade') +
    theme(strip.text.x = element_text(size=8, angle=75),
          strip.text.y = element_text(size=12, face="bold"),
          strip.background = element_rect(colour="red", fill="#CCCCFF"))


#### FAMCLUSTER4
####
# PESS_DIST_MED
od %>% select(PESS_DIST_MED) %>% describeBy(group='famcluster4')

od %>% filter(F_PESS==1) %>%
    ggplot(data=., aes(x=PESS_DIST_MED)) +
    facet_grid(famcluster4 ~ ., ncol=2) +
    geom_density(fill="#FF6666", alpha=.5) +
    stat_function(fun = dnorm,
                  color="red",
                  args = list(mean = 3793.44, sd = 5515.29)) +
    ggtitle('Distribuição da Distância média percorrida por pessoa para o Famcluster2') +
    xlab('Distância média') +
    ylab("Densidade")

#TOT_VIAG
#select(filter(od, famcluster2==1),TOT_VIAG) %>% describe() %>% select(mean)
od %>% filter(F_PESS==1) %>%
    ggplot(aes(x=TOT_VIAG)) +
    facet_grid(famcluster4 ~.) +
    geom_histogram(binwidth=1, alpha=0.5, fill="#FF6666",
                   aes(y=..density..)) +
    #scale_fill_gradient("Count", low="#DCDCDC", high="#7C7C7C") +
    stat_function(fun=dnorm,
                  color="red",
                  arg=list(mean=2.81,
                           sd=2.3)) +
    ggtitle("Total de viagens por pessoa para o Famcluster2") +
    xlab('Total de viagens') +
    ylab('Densidade')