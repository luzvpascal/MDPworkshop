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
PR_dn <- matrix(c(..., ..., #from extant to extant, and extinct resp
                  ..., ... #from extinct to extant, and extinct resp
                  ),
                byrow=TRUE, ncol=2, dimnames =list(states,states))

#define the transition function for action 2: manage
PR_manage <- matrix(c(..., ..., #from extant to extant, and extinct resp
                      ..., ... #from extinct to extant, and extinct resp
                      ),
                    byrow=TRUE, ncol=2, dimnames =list(states,states))

PR <- array(c(PR_dn,PR_manage),
            dim=c(2,2,2), #2 states, 2 states, 2 actions
            dimnames=list(states,states,actions)) #state, state, action
print(PR)

##################################################################################
# STEP 5: DEFINE UTILITY - Reward function
##################################################################################

R <- matrix(c(..., ..., #reward for state 1 action 1, action 2
              ..., ... #reward for state 2 action 1, action 2
              ),
            byrow=TRUE,
            ncol=2,
            dimnames=list(states,actions))
print(R)

##################################################################################
# STEP 6: SOLVE BELLMAN EQUATION WITH VALUE ITERATION
##################################################################################

#finite horizon ##################################################################
gamma <- ... #define the discount factor
horizon <- ... #horizon

#use the function mdp_finite_horizon from the package MDPtoolbox to find the table of values and actions


#infinite horizon ##############################################################
gamma <- ... #define the discount factor

#use the function mdp_value_iteration from the package MDPtoolbox to find the table of values and actions

