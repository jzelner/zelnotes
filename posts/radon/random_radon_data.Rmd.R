# But wait, there's more!


```{r}


random_data <- function(df) {
  gamma_0 <- 0.85
  gamma_1 <- 0.7
  beta <- 0.6
  sigma_i <- 0.7
  sigma_j <- 0.05
  
  ## Extract county-level log-uranium vals
  county_uranium <- df %>%
    group_by(county) %>%
    summarize(log_uranium = first(log_uranium))
  
  county_uranium$alpha <-
    gamma_0 + gamma_1 * county_uranium$log_uranium + rnorm(nrow(county_uranium), 0, sigma_j)
  
  random_df <- df %>%
    inner_join(county_uranium) %>%
    mutate(log_radon = alpha + beta * basement + rnorm(1, 0, 0.7))
  
  return(random_df)
  
}
```