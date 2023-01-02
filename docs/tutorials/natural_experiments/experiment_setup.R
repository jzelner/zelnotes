require(dplyr)

## Number of neighborhoods total
G <- 20

## Avg households per neighborhood
H <- 500

## Number of neighborhoods in treatment
T <- 5
M <- 10
C <- G - (T+M)

## Proportion in treatment in mixed neighborhoods
p_t <- 0.5

p_treat <- c(rep(1,T), rep(0,C), rep(p_t,M))

neighborhood_type <- c(rep("treatment",T), rep("control",C), rep("mixed",M))
## Make neighborhoods df
nsize <- rpois(G, H)
n_treatment <- rbinom(G, nsize, p_treat)
n_control <- nsize-n_treatment

df <- data.frame(neighborhood_id = 1:G, 
n = nsize,
n_treat = n_treatment,
n_control = n_control,
neighborhood_type = neighborhood_type,
mixed = ifelse(neighborhood_type == "mixed", 1,0))

disease_p_control <- 0.01
disease_or_treatment <- 5
disease_or_mixed <- 0.5
disease_p_treatment <- plogis(qlogis(disease_p_control) + log(disease_or_treatment))


individual_df <- df %>% 
group_nest(row_number()) %>% 
pull(data) %>%
map(
    function(x) {
    treated <- c(rep(1,x$n_treat),rep(0,x$n_control))
    p_disease <- plogis(qlogis(disease_p_control) + 
    treated*log(disease_or_treatment) + 
    treated*x$mixed*log(disease_or_mixed)
    )
    disease <- rbinom(x$n, 1, p_disease)
    data.frame(
        neighborhood_id = rep(x$neighborhood_id,x$n),
        neighborhood_type = rep(x$neighborhood_type, x$n),
        treatment = treated,
        disease = disease)
    }
    ) %>% bind_rows()