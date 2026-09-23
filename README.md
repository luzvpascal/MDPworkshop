# MDP workshop

This repository gathers the documents necessary to run the CBCS workshop on sequential decision-making.

# Getting started

To get started with the workshop, please make sure you have installed R and Rstudio.
Run the following code in R to install the necessary packages.

```
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
```
# Slides
The folder slides contains the slides of the lecture and workshops.

#Tutorial and solutions
The folder tutorial contains the R script we will complete during the tutorial. The folder solutions contains the solutions.
