##################################################################################
# ADAPTED FROM PASCAL ET AL.
# DEVELOPING NEW TECHNOLOGIES TO PROTECT ECOSYSTEMS: PLANNING WITH ADAPTIVE MANAGEMENT
##################################################################################

## install necessary packages ###################
packages_to_install <- c("markovchain","MDPtoolbox","ggplot2","dplyr")

# Install packages if not already installed
install_if_not_installed <- function(package) {
  if (!requireNamespace(package, quietly = TRUE)) {
    install.packages(package, dependencies = TRUE)
  }
}

# Apply the function to install packages
invisible(lapply(packages_to_install, install_if_not_installed))

## simulate a markov chain ####
library(markovchain)
library(ggplot2)
library(dplyr)

###################################################################################
## REEF EXAMPLE ####
###################################################################################

# STEP 1: DEFINE STATES
reef_names <- c("Unhealthy", "Healthy")# states: unhealthy and healthy

# STEP 2: DEFINE TRANSITION FUNCTION
reef_matrix <- matrix(c(0.8,0.2, #row 1 - probability of transitioning to other states from unhealthy
                        0.5,0.5),  #row 2 - probability of transitioning to other states from healthy
                      ncol = 2,
                      byrow=TRUE,
                      dimnames = list(reef_names, reef_names))

mcB <- new("markovchain", states = reef_names,
           transitionMatrix =reef_matrix) #markov chain object

#run the Markov chain for 20 time steps
Tmax <- 20
time_steps <- seq(Tmax)
states <- markovchainSequence(n=Tmax, markovchain=mcB, include=FALSE)

#create a data frame
data.reef <- data.frame(states=states,
                        time_steps=time_steps)
#convert the states into factors
data.reef <- data.reef %>%
  mutate(states = factor(states,
                         levels = reef_names))

ggplot(data.reef,
       aes(x = time_steps,
           y = as.numeric(states), #give a numerical value to each state 1 for Unhealthy 2 for Healthy
           group = 1)) +
  geom_line() +
  geom_point(size=3) +
  scale_y_continuous(
    breaks = c(1, 2),
    labels = reef_names
  )+
  labs(x="Time",
       y="Ecosystem state")+
  theme_bw()+
  theme(text=element_text(size=15))

###################################################################################
## WEATHER EXAMPLE ####
###################################################################################

weather_names <- c( ... , ... )# states

weather_matrix <- ...

#markov chain object
mcB_weather <- ...

#run the Markov chain for 20 time steps
Tmax <- 20
time_steps <- seq(Tmax)
states_seq_weather <- ...

#plot the sequence of states for the weather
