library(tidyverse)
library(socviz)
library(dplyr)
library(here)
install.packages("ggrepel")
library(ggrepel)
getwd()
setwd('covid-19-data')
dataframe <- read_csv(here('covid-19-data', "us-counties.csv"))
view(dataframe)
PA <- dataframe %>% filter(state=="Pennsylvania")
view(PA)
asof <- PA %>% filter(date=="2021-02-11")
view(asof)
counties <- c("Westmoreland", "Dauphin", "Luzerne", "Chester", "Lehigh", "Northampton", "York", "Berks", "Bucks", "Delaware", "Montgomery", "Allegheny", "Philadelphia")
pac <- asof[asof$county %in% counties,]
view(pac)
p <- ggplot(data = asof,
            mapping = aes(x = cases,
                          y = deaths))
p + geom_smooth(se=F, mapping = aes(group = state)) +
  labs(x = "Cases",
       y = "Deaths",
       title = "COVID-19 Deaths vs Cases for PA as of 2021-02-11") + 
  geom_point() + geom_text_repel(data = pac, aes(label = county), size = 4)

