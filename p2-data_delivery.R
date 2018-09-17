library(readr)
library(dplyr)
library(janitor)
library(knitr)
library(tidyr)
library(ggplot2)

raw_gold <- read_csv("./fall_classes/prob_stats/goldilocksdata.csv", na = c("-99", "")) %>%
  clean_names()

raw_gold %>%
  tabyl(male) %>%
  adorn_totals("row") %>%
  kable()

tidy_gold <- raw_gold %>%
  select(serial, male, mwbi, ends_with("_wd"), ends_with("_we")) %>%
  gather(key = "key", value = "engagement", -serial, -male, -mwbi) %>%
  separate(key, into = c("pred", "time")) %>%
  mutate(engagement = as.double(engagement),
         pred = as.factor(pred),
         time = as.factor(time))
