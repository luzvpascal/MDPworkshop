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
states <- c("Extant","Extinct")

##################################################################################
# STEP 3: DEFINE CONTROL ACTIONS
##################################################################################
actions <- c("Do nothing","Manage")

##################################################################################
# STEP 4: DEFINE TRANSITION FUNCTION
##################################################################################

#define the transition function for action 1: do nothing
PR_dn <- matrix(c(0.9, 0.1, #from extant to extant, and extinct resp
                  0.0, 1.0 #from extinct to extant, and extinct resp
                  ),
                byrow=TRUE, ncol=2, dimnames =list(states,states))

#define the transition function for action 2: manage
PR_manage <- matrix(c(0.94, 0.06, #from extant to extant, and extinct resp
                      0.0, 1.0 #from extinct to extant, and extinct resp
                      ),
                    byrow=TRUE, ncol=2, dimnames =list(states,states))

PR <- array(c(PR_dn,PR_manage),
            dim=c(2,2,2), #2 states, 2 states, 2 actions
            dimnames=list(states,states,actions)) #state, state, action
print(PR)

##################################################################################
# STEP 5: DEFINE UTILITY - Reward function
##################################################################################

reward_extant <- 1 #immediate reward if the tiger population is extant
reward_extinct <- 0#immediate reward if the tiger population is extinct
cost_dn <- 0 #cost of doing nothing
cost_manage <- 0.1 #cost of management

R <- matrix(c(reward_extant-cost_dn,reward_extant-cost_manage, #reward for state 1 action 1, action 2
              reward_extinct-cost_dn,reward_extinct-cost_manage #reward for state 2 action 1, action 2
              ),
            byrow=TRUE,
            ncol=2,
            dimnames=list(states,actions))
print(R)

##################################################################################
# STEP 6: SOLVE BELLMAN EQUATION WITH VALUE ITERATION
##################################################################################
#finite horizon ####
gamma <- 1 #define the discount factor
horizon <- 7 #horizon
solution <- mdp_finite_horizon(#we use the function mdp_finite_horizon
                   PR,
                   R,
                   gamma,
                   horizon)

#table of expected values
print(solution$V)

#table of strategies
print(solution$policy)


#infinite horizon ####
gamma <- 0.9 #define the discount factor
solution_inf <- mdp_value_iteration(#we use the function mdp_finite_horizon
  PR,
  R,
  gamma)

#table of expected values
print(solution_inf$V)

#table of strategies
print(solution_inf$policy)
