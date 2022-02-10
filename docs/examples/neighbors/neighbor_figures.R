#! /usr/bin/env Rscript

library(tidyverse)
source("lib/example_functions.R")

nsew <- function(x0,y0) {
  dirs <- list()
  dirs[["N"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0 + 1, x2 = x0)
  dirs[["S"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0 - 1, x2 = x0)
  dirs[["E"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0, x2 = x0 + 1)
  dirs[["W"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0, x2 = x0 - 1)

  return(dirs)
}

nsew <- function(x0, y0) {
  dirs <- list()
  dirs[["N"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0 + 1, x2 = x0)
  dirs[["S"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0 - 1, x2 = x0)
  dirs[["E"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0, x2 = x0 + 1)
  dirs[["W"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0, x2 = x0 - 1)

  return(dirs)
}

queen_dirs <- function(x0, y0) {
  dirs <- list()
  dirs[["NE"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0 + 1, x2 = x0+1)
  dirs[["NW"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0 + 1, x2 = x0-1)
  dirs[["SE"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0 - 1, x2 = x0 + 1)
  dirs[["SW"]] <- data.frame(x1 = x0, y1 = y0, y2 = y0 - 1, x2 = x0 - 1)

  return(dirs)
 
}

rook_arrows <- function(g, x0, y0) {
  dirs <- nsew(x0, y0)
  g <- g + geom_segment(data = dirs$N, aes(x = x1, xend = x2, y = y1, yend = y2), colour = "white", arrow = arrow(type = "closed"), size = 3) +
  geom_segment(data = dirs$S, aes(x = x1, xend = x2, y = y1, yend = y2), colour = "white", arrow = arrow(type = "closed"), size = 3) +
   geom_segment(data = dirs$E, aes(x = x1, xend = x2, y = y1, yend = y2), colour = "white", arrow = arrow(type = "closed"), size = 3) +
  geom_segment(data = dirs$W, aes(x = x1, xend = x2, y = y1, yend = y2), colour = "white", arrow = arrow(type = "closed"), size = 3)

 return(g)
}

queen_arrows <- function(g, x0, y0) {
  dirs <- queen_dirs(x0, y0)
  g <- g + geom_segment(data = dirs$NE, aes(x = x1, xend = x2, y = y1, yend = y2), colour = "white", arrow = arrow(type = "closed"), size = 3) +
  geom_segment(data = dirs$SE, aes(x = x1, xend = x2, y = y1, yend = y2), colour = "white", arrow = arrow(type = "closed"), size = 3) +
   geom_segment(data = dirs$NW, aes(x = x1, xend = x2, y = y1, yend = y2), colour = "white", arrow = arrow(type = "closed"), size = 3) +
  geom_segment(data = dirs$SW, aes(x = x1, xend = x2, y = y1, yend = y2), colour = "white", arrow = arrow(type = "closed"), size = 3)

  return(g)
}

## Make a checkerboard
df <- make_checkerboard(dim = 8)

g <- plain_grid_plot(df)
ggsave("output/neighbors/checkerboard.pdf")

center <- c(4, 4)
dirs <- nsew(center[1],center[2])
g <- rook_arrows(plain_grid_plot(df), center[1], center[2])
ggsave("output/neighbors/rook.pdf")

g2 <- queen_arrows(plain_grid_plot(df), center[1], center[2])
ggsave("output/neighbors/corners.pdf")

g2 <- queen_arrows(g, center[1], center[2])
ggsave("output/neighbors/queen.pdf")

