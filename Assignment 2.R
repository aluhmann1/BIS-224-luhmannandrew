library(tidyverse)
Temp <- getwd()
setwd("./covid-19-data/")
STATES <- read_csv("us-states.csv")
setwd(Temp)
View(STATES)
PA <- filter(STATES, state=="Pennsylvania")
View(PA)
n <- length(PA$date)
PA$adj_deaths <- 0
for (i in 1:n) {
  if (as.character(PA$date[i])=="2020-04-21") {
    PA$adj_deaths[i] <- (PA$deaths[i] - 282)
  } else if (as.character(PA$date[i])=="2020-04-22") {
    PA$adj_deaths[i] <- (PA$deaths[i] - 297)
  }
  else {PA$adj_deaths[i] <- PA$deaths[i]}
}
sum(PA$adj_deaths)