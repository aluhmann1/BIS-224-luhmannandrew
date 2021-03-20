#Andrew Luhmann, BIS 244 Midterm
Wd <- getwd()
install.packages(my_packages, repos = "http://cran.rstudio.com")
#tidyverse wouldn't load, so I used this solution someone posted to stackoverflow.com
remove.packages("rlang")
install.packages("rlang")
library(tidyverse)
library(gapminder)
library(here)
library(socviz)
library(dplyr)
AAPL <- read.csv("AAPL.csv")
View(AAPL)
AAPL$daychange <- -1.12321
n <- length(AAPL$Date)
for (i in 1:n) {
  AAPL$daychange[i] <- (AAPL$Adj.Close[i]-AAPL$Open[i]) 
}
p <- ggplot(data = AAPL,
            mapping = aes(x = Date,
                          y = daychange))
p + geom_point() +
  labs(x = "2020-03-19 through 2021-03-18", y = "Change in Adjusted Price",
       title = "Changes in Apple Daily Prices over last year",
       subtitle = "Andrew Luhmann")
nochanges <- AAPL$nochange <- 0
AAPL$green <- 0
AAPL$red <- 0
for (i in 1:n) {
  if(AAPL$daychange[i]>=nochanges) {
    AAPL$green[i] <- AAPL$daychange[i]
  } else {
    AAPL$red[i] <- AAPL$daychange[i]
  }
}
for (i in 1:n) {
  if(AAPL$green[i]==0.000000) {
    AAPL$green[i] <- ""[i]
  } else {
    AAPL$red[i] <- AAPL$daychange[i]
  }
}
AAPL[AAPL == 0.000000] <- NA
#This makes AAPL$nochange = NA, so set it back to 0.
#I tried for 50 minutes to make a legend! Alas.
p <- ggplot(data = AAPL,
            mapping = aes(x = Date, y = daychange))
p + geom_point(data = AAPL, aes(x = Date, y = green), color = "green3") +
  geom_point(data = AAPL, aes(x = Date, y = red), color = "red") +
  labs(x = "2020-03-19 through 2021-03-18", y = "Change in Adjusted Price",
       title = "Changes in Apple Daily Prices over last year",
       subtitle = "Andrew Luhmann", color = "Legend") +
  theme(axis.text.x = element_blank())
#I manually saved as a PDF because the ggsave command yielded a blank chart.
