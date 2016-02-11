
############# Plotando dendrogramas
###### Famílias
#### Geral
## Ward
plot(fam_hcluster_ward, xlab=NA, sub=NA, hang=-1, labels = FALSE,
     main = 'Cluster de atributos de viagens da família\n método ward')
dev.copy(png,file="imagens/dendro-hierarq-cluster-familia-total-ward.png", width=700, height=350 )
dev.off()

#### Geral
## Centroide
plot(fam_hcluster_centroide, xlab=NA, sub=NA, hang=-1, labels = FALSE,
     main = 'Cluster de atributos de viagens da família\n método centróide')
dev.copy(png,file="imagens/dendro-hierarq-cluster-familia-total-centroide.png", width=700, height=350 )
dev.off()
#### Ano
## 1977
plot(fam_hcluster_77, xlab=NA, sub=NA, hang=-1, labels = FALSE,
     main = 'Cluster de atributos de viagens da família\n para 1977')
dev.copy(png,file="imagens/dendro-hierarq-cluster-familia-1977.png", width=700, height=350 )
dev.off()
## 1987
plot(fam_hcluster_87, xlab=NA, sub=NA, hang=-1, labels = FALSE,
     main = 'Cluster de atributos de viagens da família\n para 1987')
dev.copy(png,file="imagens/dendro-hierarq-cluster-familia-1987.png", width=700, height=350 )
dev.off()
## 1997
plot(fam_hcluster_97, xlab=NA, sub=NA, hang=-1, labels = FALSE,
     main = 'Cluster de atributos de viagens da família\n para 1997')
dev.copy(png,file="imagens/dendro-hierarq-cluster-familia-1997.png", width=700, height=350 )
dev.off()
## 2007
plot(fam_hcluster_07, xlab=NA, sub=NA, hang=-1, labels = FALSE,
     main = 'Cluster de atributos de viagens da família\n para 2007')
dev.copy(png,file="imagens/dendro-hierarq-cluster-familia-2007", width=700, height=350 )
dev.off()

###### Pessoas
#### Geral
## Ward
#### Geral
## Centroide
#### Ano
## 1977
plot(pess_hcluster_77, xlab=NA, sub=NA, hang=-1, labels = FALSE,
     main = 'Cluster de atributos de viagens da pessoa\n para 1977')
dev.copy(png,file="imagens/dendro-hierarq-cluster-pessoa-1977.png", width=700, height=350 )
dev.off()
## 1987
plot(pess_hcluster_87, xlab=NA, sub=NA, hang=-1, labels = FALSE,
     main = 'Cluster de atributos de viagens da pessoa\n para 1987')
dev.copy(png,file="imagens/dendro-hierarq-cluster-pessoa-1987.png", width=700, height=350 )
dev.off()
## 1997
plot(pess_hcluster_97, xlab=NA, sub=NA, hang=-1, labels = FALSE,
     main = 'Cluster de atributos de viagens da pessoa\n para 1997')
dev.copy(png,file="imagens/dendro-hierarq-cluster-pessoa-1997.png", width=700, height=350 )
dev.off()
## 2007
plot(pess_hcluster_07, xlab=NA, sub=NA, hang=-1, labels = FALSE,
     main = 'Cluster de atributos de viagens da pessoa\n para 2007')
dev.copy(png,file="imagens/dendro-hierarq-cluster-pessoa-2007.png", width=700, height=350 )
dev.off()

