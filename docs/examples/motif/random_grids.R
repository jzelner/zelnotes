source("lib/example_functions.R")
require(tidyverse)
## Define rates for within each within quadrants

moran_grid_plot_w_legend <- function(df, label = "Number in minority group", queen=FALSE) {
  g <- ggplot(df, aes(x = x, y = y, fill = z)) +
  geom_tile(colour = "white") +
  ggtitle(paste0("Isolation = ", round(isolation_index(df), 2), ";  Moran's I = ", round(morans_grid(df$z, queen = queen), 2))) +
  theme_void() +
    scale_fill_distiller(guide = "colourbar", palette = "OrRd", direction = 1) +
  #scale_fill_gradient(guide="colourbar") +
  guides(fill = guide_colourbar(label)) +
  theme(legend.position="bottom") + 
  coord_equal()
  return(g)
}

blocked_grid <- function(p = 0.25, pop = 1000, block = rep(1, 8), neighborhood = c(1, 1, 5, 1), quadrant = c(1, 2, 1, 1)) {


block_rates <- matrix(block, 4, 4)
neighborhood_rates <- kronecker(matrix(neighborhood, 2, 2), block_rates)
quadrant_rates <- kronecker(matrix(quadrant, 2, 2), neighborhood_rates)
df <- data.frame(x = as.vector(row(quadrant_rates)),
y = as.vector(col(quadrant_rates)),
z = as.vector(quadrant_rates))

n = p*pop*nrow(df)

  ## Divide to get mean
  df$z <- (df$z / mean(df$z)) * (n / nrow(df))
df$pop <- pop

return(df)
}

sample_blocked_grid <- function(df, numcell = 1000) {
  out_z <- rbinom(nrow(df), numcell, df$z / 1000)
  df$z <- out_z
  df$pop <- numcell
return(df)
}

isolation_index <- function(df) {
  total_B <- sum(df$z)
  p_b <- df$z/ total_B
  p_b_cell <- df$z / df$pop

  iso <- sum(p_b * p_b_cell)
  return(iso)
}

interaction_index <- function(df) {
  total_B <- sum(df$z)
  p_b <- df$z / total_B
  p_b_cell <- (df$pop-df$z) / df$pop

  iso <- sum(p_b * p_b_cell)
  return(iso)
}

## One example
df <- blocked_grid(p = 0.25, neighborhood = c(1, 1, 1, 1), quadrant = c(1, 1, 1, 1))
r_df_1 <- sample_blocked_grid(df, numcell = 1000)
g1 <- moran_grid_plot_w_legend(r_df_1)
ggsave("output/motif/iso_1.pdf")
g3 <- r_df_1 %>%
  mutate(z = sample(z)) %>%
  moran_grid_plot_w_legend()
ggsave("output/motif/iso_1_random.pdf")

## Another
df <- blocked_grid(p = 0.25, neighborhood = c(1, 1, 1, 1), quadrant = c(1,5,5,1))
r_df_2 <- sample_blocked_grid(df, numcell = 1000)
g2 <- moran_grid_plot_w_legend(r_df_2)
ggsave("output/motif/iso_2.pdf")
g3 <- r_df_2 %>%
  mutate(z = sample(z)) %>%
  moran_grid_plot_w_legend()
ggsave("output/motif/iso_2_random.pdf")

## Another
df <- blocked_grid(p = 0.25, neighborhood = c(1, 1, 1, 1), quadrant = c(1, 1, 8, 1))
r_df_2 <- sample_blocked_grid(df, numcell = 1000)
g2 <- moran_grid_plot_w_legend(r_df_2)
ggsave("output/motif/iso_3.pdf")

g3 <- r_df_2 %>%
  mutate(z = sample(z)) %>%
moran_grid_plot_w_legend()
ggsave("output/motif/iso_3_random.pdf")
