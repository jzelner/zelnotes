library(tidyverse)
source("lib/example_functions.R")

set.seed(9877211)

moran_grid_plot_w_legend <- function(df, label = "Number of cases") {
  g <- moran_grid_plot(df) + theme_bw() + scale_fill_gradient(limits=c(0,35)) + guides(fill = guide_legend(label))
  return(g)
}

## Simple hotspot grid
df <- make_hotspot_grid()
g <- moran_grid_plot(df)

## Modify to allow different numbers of cases
df_pois <- df

## First plot the figure w/means

df_pois <- df %>% mutate(mean_case = ifelse(z == 1, 20, 1))

g1 <- df_pois %>%
  mutate(z = mean_case) %>%
  moran_grid_plot_w_legend("Expected cases")

ggsave("output/moran/hostspot_mean_20_1.pdf")
## Now plot with realized cases
df_pois$z <- as.double(rpois(nrow(df_pois), df_pois$mean_case))

g1 <- moran_grid_plot_w_legend(df_pois)
ggsave("output/moran/hostspot_realization_20_1.pdf")

## Repeat for other RRs
df_pois <- df %>% mutate(mean_case = ifelse(z == 1, 20, 4))

g1 <- df_pois %>%
  mutate(z = mean_case) %>%
  moran_grid_plot_w_legend("Expected cases")

ggsave("output/moran/hostspot_mean_5_1.pdf")
## Now plot with realized cases
df_pois$z <- as.double(rpois(nrow(df_pois), df_pois$mean_case))

g1 <- moran_grid_plot_w_legend(df_pois)
ggsave("output/moran/hostspot_realization_5_1.pdf")

## Repeat for other RRs
df_pois <- df %>% mutate(mean_case = ifelse(z == 1, 20, 10))

g1 <- df_pois %>%
  mutate(z = mean_case) %>%
  moran_grid_plot_w_legend("Expected cases")

ggsave("output/moran/hostspot_mean_2_1.pdf")
## Now plot with realized cases
df_pois$z <- as.double(rpois(nrow(df_pois), df_pois$mean_case))

g1 <- moran_grid_plot_w_legend(df_pois)
ggsave("output/moran/hostspot_realization_2_1.pdf")