##################################################################################
# ADAPTED FROM MARESCOT ET AL.
# COMPLEX DECISIONS MADE SIMPLE: A PRIMER ON STOCHASTIC DYNAMIC PROGRAMMING
##################################################################################

library(MDPtoolbox)
library(ggplot2)

##################################################################################
# STEP 1: DEFINE OBJECTIVES
##################################################################################

# This is a conceptual step which does not require coding

###################################################################################
# STEP 2: DEFINE STATES
##################################################################################

# Vector of all possible states
states <- ...

##################################################################################
# STEP 3: DEFINE CONTROL ACTIONS
##################################################################################

# Vector of actions:
actions <- ...

##################################################################################
# STEP 4: DEFINE TRANSITION FUNCTION
##################################################################################

# Population growth rate
lambda <- 1.25

# Function for the exponential growth of the dynamic model
dynamic <- function(actualpop, action) {
  ...
}

transition <- array(0, dim=c(length(states),
                             length(states),
                             length(actions)))
# Fill in the transition function
# Loop on all states
for (s in 1:length(states)) {
  # Loop on all actions
  for (i in 1:length(actions)) {

    # Calculate the transition state at the next step, given the #current state k and the harvest Hi
    nextpop_avg <- ... #average of next population

    # Implement demographic stochasticity by drawing
    #probability from a Poisson density function
    #hint: use the dpois function
    transition[s, ,i] <- ...

    # We need to correct this density for the final capping state
    transition[s,length(states),i] <- 1 - sum(transition[s,-(length(states)),i])

  } # end of action loop
} # end of state loop


##################################################################################
# STEP 5: DEFINE UTILITY - Reward function
##################################################################################

# Maximum objective threshold for population abundance
Nmax <- 200

# Minimum objective threshold for population abundance
Nmin <- 50

# Utility function
get_utility <- function(x, action) {
  ...
}

# Reward matrix
reward <- array(0, dim = c(length(states), length(actions)))

# Fill in the transition and utility matrix
# Loop on all states
for (s in 1:length(states)) {

  # Loop on all actions
  for (i in 1:length(actions)) {

    # Compute utility
    reward[s,i] <- ...

  } # end of action loop
} # end of state loop


##################################################################################
# STEP 6: SOLVE BELLMAN EQUATION WITH VALUE ITERATION
##################################################################################

# Discount factor
discount <- ...

horizon <- ... #horizon

#Use the function mdp_finite_horizon

