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

# state space limit
K <- 250

# Vector of all possible states
states <- 0:K

##################################################################################
# STEP 3: DEFINE CONTROL ACTIONS
##################################################################################

# Vector of actions: rate of the population that can be removed, ranging #from 0 to 1
actions <- seq(0, 1, 0.01)
##################################################################################
# STEP 4: DEFINE TRANSITION FUNCTION
##################################################################################

# Population growth rate
lambda <- 1.25

# Function for the exponential growth of the dynamic model
dynamic <- function(actualpop, action) {
  # nextpop <- max(0, actualpop*lambda - action)
  nextpop <- actualpop*lambda*(1-action)
  return(nextpop)
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
    nextpop_avg <- dynamic(states[s], actions[i]) #average of next population

    # Implement demographic stochasticity by drawing
    #probability from a Poisson density function
    #hint: use the dpois function
    transition[s,,i] <- dpois(states, nextpop_avg)

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
  return(ifelse(x < Nmin, - x*action,
                ifelse(x > Nmax, -x*action, x-x*action)))
}

plot(get_utility(states,0),
     xlab="Population",
     ylab="Utility function")

reward <- array(0, dim = c(length(states), length(H)))
# Loop on all states
for (s in 1:length(states)) {
  # Loop on all actions
  for (i in 1:length(actions)) {
    # Compute utility
    reward[s,i] <- get_utility(states[s],actions[i])
  } # end of action loop
} # end of state loop
##################################################################################
# STEP 6: SOLVE BELLMAN EQUATION WITH VALUE ITERATION
##################################################################################

# Discount factor
discount <- 0.95

horizon <- 50 #horizon

solution <- mdp_finite_horizon(#we use the function mdp_finite_horizon
  transition,
  reward,
  discount,
  horizon)

##################################################################################
# PLOT SOLUTION
##################################################################################
selected_times <- c(1,49,50)
solution_data <- data.frame(states=states,
                            culling=actions[solution$policy[,selected_times]],
                            time=sort(rep(selected_times, length(states))))

solution_data |>
  ggplot(aes(x=states,
             y=culling,
             group=time,
             col=factor(time))) +
  geom_line(linewidth = 1)+
  theme_bw()+
  labs(x="Population size",
       y="Culling rate",
       col="Time step")
