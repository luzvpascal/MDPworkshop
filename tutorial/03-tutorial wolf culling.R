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

transition_matrix <- ...

##################################################################################
# STEP 5: DEFINE UTILITY - Reward function
##################################################################################

# Maximum objective threshold for population abundance
Nmax <- 200

# Minimum objective threshold for population abundance
Nmin <- 50

reward_matrix <- ...


##################################################################################
# STEP 6: SOLVE BELLMAN EQUATION WITH VALUE ITERATION
##################################################################################

# Discount factor
discount <- ...

horizon <- ... #horizon


