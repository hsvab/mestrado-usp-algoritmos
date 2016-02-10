# Definição de variáveis gerais
local({
  # Largura e altura para exportar plots em PNG
  largura = 455*1.05/28.4
  altura = largura / 1.24

  assign(".mestrado.plot.largura", largura,
         envir = globalenv())
  assign(".mestrado.plot.altura", altura,
         envir = globalenv())

  cor.grafico.linha.simples = "#336666"
  cor.elementos.gerais = "#333333"

  assign(".mestrado.cor.graf.linha.simples", cor.grafico.linha.simples,
         envir = globalenv())
  assign(".mestrado.cor.elementos.gerais", cor.elementos.gerais,
         envir = globalenv())
})
