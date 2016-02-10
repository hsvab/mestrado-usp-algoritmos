# Setando tema default do ggplot como sendo o theme_light
theme_set(theme_light())

# Alterando algumas características:
theme_update(
  plot.title = element_text(lineheight=1.6,
                            face="bold",
                            size="16"),
  axis.title = element_text(color=.mestrado.cor.elementos.gerais,
                            size="14"),
  axis.text = element_text(color=.mestrado.cor.elementos.gerais,
                           size="10"),
  axis.text.y = element_text(margin=margin(l=6)),
  #axis.text.x = element_text(angle = 45,
  #                           hjust=1,
  #                           vjust = 1),

  legend.title = element_text(color=.mestrado.cor.elementos.gerais,
                              size="10"),
  legend.text = element_text(color=.mestrado.cor.elementos.gerais,
                             size="8"),
  # Para facets
  strip.text = element_text(color=.mestrado.cor.elementos.gerais,
                            size="8",
                            face="bold"),
  strip.background = element_rect(fill="#999999", colour = "#999999")
)
