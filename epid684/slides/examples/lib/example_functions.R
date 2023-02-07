require(sp)
require(spdep)

make_checkerboard <- function(dim = 8) {
  row1 <- rep(c(0, 1), dim / 2)
  row2 <- rep(c(1, 0), dim / 2)

  init_row <- c(row1, row2)
  z_vals <- rep(init_row, dim / 2)
  x_index <- rep(1:dim, dim)
  y_index <- sort(x_index)
  df <- data.frame(x = x_index, y = y_index, z = z_vals)

    return(df)
}

make_hotspot_grid <- function(dim = 8) {

  df <- expand.grid(x = 1:dim, y = 1:dim)
  df$z <- 0
  df$z[as.logical((df$x <= dim /2) * (df$y <= dim/2))] <- 1
  return(df)
}


make_me_a_grid <- function(n) {
  x <- seq(1, n, by = 1)
  y <- seq(1, n, by = 1)
  num_cells = length(x) * length(y)
  xy <<- expand.grid(x = x, y = y)
  grid.pts <<- SpatialPointsDataFrame(coords = xy, data = xy)
  #make points a gridded object
  gridded(grid.pts) <- TRUE
  #plot(grid.pts)
  grid <- as(grid.pts, "SpatialPolygons") #encode as spatial polygons
  #str(grid)
  gridspdf <<- SpatialPolygonsDataFrame(grid, data = data.frame(ID = row.names(grid), row.names = row.names(grid)))

  gridspdf$ID <- sapply(slot(gridspdf, "polygons"), function(x) slot(x, "ID"))


  return(gridspdf)
}

morans_grid <- function(x, queen = FALSE) {

  dim <- sqrt(length(x))
  tg <- make_me_a_grid(dim) %>%
  poly2nb(queen = queen) %>%
  nb2listw
  return(as.numeric(moran.test(x, tg)$estimate[1]))
}

moran_grid_plot <- function(df, queen = FALSE) {
  g <- ggplot(df, aes(x = x, y = y, fill = z)) +
  geom_tile(colour = "white") +
  theme_void() +
  theme(legend.position = "none") +
  ggtitle(paste0("Moran's I = ", round(morans_grid(df$z, queen = queen), 2)))

  return(g)
}

plain_grid_plot <- function(df) {
  g <- ggplot() +
  geom_tile(data = df, aes(x = x, y = y, fill = z), colour = "white") +
  theme_void() +
  theme(legend.position = "none") 

  return(g)
}