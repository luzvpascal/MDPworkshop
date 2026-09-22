# MDP workshop

This repository gathers the documents necessary to run the CBCS workshop on sequential decision-making.

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
