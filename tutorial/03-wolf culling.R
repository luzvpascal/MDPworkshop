##################################################################################
# ADAPTED FROM MARESCOT ET AL.
# COMPLEX DECISIONS MADE SIMPLE: A PRIMER ON STOCHASTIC DYNAMIC PROGRAMMING
##################################################################################

##################################################################################
# STEP 1: DEFINE OBJECTIVES
##################################################################################

# This is a conceptual step which does not require coding

###################################################################################
# STEP 2: DEFINE STATES
##################################################################################

# state space limit
K <- 250

# Vector of all possible states
states <- 0:K

##################################################################################
# STEP 3: DEFINE CONTROL ACTIONS
##################################################################################

# Vector of actions: rate of the population that can be removed, ranging #from 0 to 1
# H <- seq(0, 1, 1/(K+1))
H <- states
##################################################################################
# STEP 4: DEFINE TRANSITION FUNCTION
##################################################################################

# Population growth rate
lambda <- 1.25

# Function for the exponential growth of the dynamic model
dynamic <- function(actualpop, action) {
  nextpop <- max(0, actualpop*lambda - action)
  # nextpop <- actualpop*lambda*(1-action)
  return(nextpop)
}

##################################################################################
# STEP 5: DEFINE UTILITY - Reward function
##################################################################################

# Maximum objective threshold for population abundance
Nmax <- 200

# Minimum objective threshold for population abundance
Nmin <- 50

# Utility function
get_utility <- function(x) {
  return(ifelse(x < Nmin | x > Nmax, 0, x))
}

## build the transition and reward matrices ####
# Transition matrix
transition <- array(0, dim = c(length(states), length(states), length(H)))

# Utility matrix
utility <- array(0, dim = c(length(states), length(H)))

# Fill in the transition and utility matrix
# Loop on all states
for (k in 0:K) {

  # Loop on all actions
  for (i in 1:length(H)) {

    # Calculate the transition state at the next step, given the #current state k and the harvest Hi
    nextpop <- dynamic(k, H[i])

    # Implement demographic stochasticity by drawing
    #probability from a Poisson density function
    transition[k+1,,i] <- dpois(states, nextpop)

    # We need to correct this density for the final capping state
    transition[k+1,K+1,i] <- 1 - sum(transition[k+1,-(K+1),i])

    # Compute utility
    utility[k+1,i] <- get_utility(nextpop)

  } # end of action loop
} # end of state loop
##################################################################################
# STEP 6: SOLVE BELLMAN EQUATION WITH VALUE ITERATION
##################################################################################

# Discount factor
discount <- 0.9

horizon <- 150 #horizon
solution <- mdp_finite_horizon(#we use the function mdp_finite_horizon
  transition,
  utility,
  discount,
  horizon)

#table of expected values
print(solution$V)

#table of strategies
print(solution$policy)
##################################################################################
# PLOT SOLUTION
##################################################################################
solution_data <- data.frame(states=states,
                            culling=H[solution$policy[,1]])

solution_data |>
  ggplot(aes(x=states,
             y=culling)) +
  geom_line()+
  theme_bw()+
  labs(x="Population size",
       y="Culling number")
