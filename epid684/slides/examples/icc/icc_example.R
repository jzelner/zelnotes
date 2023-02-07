require(ggplot2)
mu_pop <- 120

sigma_pop <- 5

sigma_neighborhood <- 3

J <- 10
N <- 100

neighborhoods <- rep(1:J, N)

neighborhood_means <- rnorm(J, mu_pop, sqrt(sigma_neighborhood))

ind_sbp <- rnorm(N*J, neighborhood_means[neighborhoods], sqrt(sigma_pop))

hg <- ggplot(data.frame(x=ind_sbp)) + geom_histogram(aes(x=x), binwidth=0.5, colour = "black", fill = "white") + theme_bw() + 
geom_vline(xintercept = mean(ind_sbp), linetype = "dashed") +
xlab("Systolic Blood Pressure (SBP)") +
ylab("N")

png("output/ind_sbp_hist.png", width = 600, height = 400)
print(hg)
dev.off()


## Make a plot of neighborhood means, ordered from least to greatest
ng <- ggplot(data = data.frame(x=as.factor(1:J), y = neighborhood_means), 
aes(x=x,y=y)) + 
geom_point(shape = "x", size = 5) + 
xlab("Neighborhood") +
ylab("Neighborhood Mean SBP") + 
theme_bw() +
ylim(sbp_limits)

png("output/neighborhood_sbp_means.png", width = 600, height = 400)
plot(ng)
dev.off()

## Make a plot of neighborhood means, ordered from least to greatest
ig <- ggplot() +
geom_point(data = data.frame(x=as.factor(neighborhoods), y = ind_sbp), aes(x=x,y=y, colour = x)) + 
#geom_point(data = data.frame(x=as.factor(1:J), y = neighborhood_means), aes(x=x,y=y), shape = "x", size = 5) +
xlab("Neighborhood") +
ylab("Individual SBP") +
theme_bw() +
theme(legend.position = "none") +
ylim(sbp_limits)

png("output/ind_sbp_means.png", width = 600, height = 400)
print(ig)
dev.off()

## Make a plot of neighborhood means, ordered from least to greatest
ig2 <- ggplot() +
geom_point(data = data.frame(x=as.factor(neighborhoods), y = ind_sbp), aes(x=x,y=y, colour = x)) + 
geom_point(data = data.frame(x=as.factor(1:J), y = neighborhood_means), aes(x=x,y=y), shape = "x", size = 5) +
xlab("Neighborhood") +
ylab("Individual SBP") +
theme_bw() +
theme(legend.position = "none") +
ylim(sbp_limits)

png("output/ind_neigh_sbp_means.png", width = 600, height = 400)
print(ig2)
dev.off()

 