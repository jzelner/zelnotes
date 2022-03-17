library(tidyverse)

source("lib/example_functions.R")

set.seed(8776767)

dim <- 8

row1 <- rep(c(0, 1), dim / 2)
row2 <- rep(c(1, 0), dim / 2)

init_row <- c(row1, row2)
z_vals <- rep(init_row, dim/2)
x_index <- rep(1:dim, 8) 
y_index <- sort(x_index)
df <- data.frame(x = x_index, y = y_index, z = z_vals)

g <- moran_grid_plot(df)
ggsave("output/moran/checkerboard.png")

g2 <- moran_grid_plot(df,queen=TRUE)
ggsave("output/moran/checkerboard_queen.png")

df2 <- df
df2$z <- sort(df2$z)
g2 <- moran_grid_plot(df2)
ggsave("output/moran/clustered.png")

g2 <- moran_grid_plot(df2, queen=TRUE)
ggsave("output/moran/clustered_queen.png")

df3 <- df
df3$z <- sample(df2$z)
g3 <- moran_grid_plot(df3)
ggsave("output/moran/random.png")

g3 <- moran_grid_plot(df3, queen=TRUE)
ggsave("output/moran/random_queen.png")


df3 <- df
df3$z <- sample(df2$z)
g3 <- moran_grid_plot(df3)
ggsave("output/moran/random_2.png")

## Use this area to make ones with continuous values
z_means <- rep(init_row, dim / 2)
z_vals <- rnorm(length(z_means), z_means, sd = 0.1)



