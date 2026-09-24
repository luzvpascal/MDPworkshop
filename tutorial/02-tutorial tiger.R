##################################################################################
# ADAPTED FROM CHADES ET AL.
# WHEN TO STOP MANAGING OR SURVEYING CRYPTIC THREATENED SPECIES
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
states <- c(..., ... )

##################################################################################
# STEP 3: DEFINE CONTROL ACTIONS
##################################################################################
actions <- c(..., ...)

##################################################################################
# STEP 4: DEFINE TRANSITION FUNCTION
##################################################################################

#define the transition function for action 1: do nothing
PR_dn <- ...

#define the transition function for action 2: manage
PR_manage <- ...

#check the documentation of mdp_finite_horizon for the format of the transition function
PR <- ...
print(PR)

##################################################################################
# STEP 5: DEFINE UTILITY - Reward function
##################################################################################

R <- ...
#check the documentation of mdp_finite_horizon for the format of the reward function
print(R)

##################################################################################
# STEP 6: SOLVE BELLMAN EQUATION WITH VALUE ITERATION
##################################################################################

#finite horizon ##################################################################
gamma <- ... #define the discount factor
horizon <- ... #horizon

#use the function mdp_finite_horizon from the package MDPtoolbox to find the table of values and actions


# think about ways we can represent the solution


#infinite horizon ##############################################################
gamma <- ... #define the discount factor

#use the function mdp_value_iteration from the package MDPtoolbox to find the table of values and actions

# think about ways we can represent the solution
