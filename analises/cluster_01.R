# The palette with grey:
# from: http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# The palette with black:
# from: http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

cor_sexo <- c('#56B4E9','#CC79A7')

#http://www.r-statistics.com/2013/08/k-means-clustering-from-r-in-action/
wssplot <- function(data, nc=15, seed=1234, titulo='', subtitulo=''){
    wss <- (nrow(data)-1)*sum(apply(data,2,var))
    for (i in 2:nc){
        set.seed(seed)
        wss[i] <- sum(kmeans(data, centers=i)$withinss)}
    plot(1:nc, wss, type="b", xlab="Number of Clusters",
         ylab="Within groups sum of squares", main=titulo,
         sub=subtitulo)}

od %>%
    filter(F_PESS==1, ANO==4) %>%
    select(SEXO,QT_AUTO,ANO,TOT_VIAG) %>%
#    dist() %>%
    hclust.vector()

od %>%
    filter(QT_AUTO!=0, MODO1==3|MODO2==3|MODO3==3|MODO4==3) %>%
    select(SEXO, ANO, SIT_FAM) %>% table() %>%
    as.data.frame() %>%
    ggplot(.,aes(x=ANO, y=Freq, fill=SEXO)) +
    geom_bar(stat='identity',
             position='dodge') +
    scale_fill_manual(values=cor_sexo)
