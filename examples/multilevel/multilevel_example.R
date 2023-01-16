require(ggplot2)
icc <- 0.9
total_var <- 10
cluster_sigma <- sqrt(icc * total_var)
ind_sigma <- sqrt((1 - icc) * total_var)
ind_cluster <- rpois(ncluster, lambda = 2)
ind_cluster[ind_cluster <= 1] <- 2
ncluster <- 100
#cluster_sigma <- 1
#ind_sigma <- 0.2

cluster_ids <- sort(rep(1:ncluster, ind_cluster))

cluster_means <- rnorm(ncluster, sd = cluster_sigma)
ind_vals <- rnorm(n = length(cluster_ids), mean = cluster_means[cluster_ids], sd = ind_sigma)

df <- data.frame(x = ind_vals, cluster = cluster_ids)
aa <- df %>% group_by(cluster) %>% group_map(~resid(lm(x ~ 1, data = .x))) %>% unlist 
df$resid <- aa

g <- ggplot(df, aes(x = resid, cluster = cluster_ids)) +
  geom_histogram(binwidth = 0.1, aes(y = ..density..)) +
      stat_function(fun = dnorm, args = list(mean = 0, sd = sqrt(total_var))) + 
  xlab("Distance from mean") +
  ylab("N") + 
  theme_bw()

g <- ggplot(df, aes(sample = resid, cluster = cluster_ids)) +
    stat_qq() +
    stat_qq_line()



plot(g)