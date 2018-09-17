library(dplyr)
library(readr)
library(janitor)
library(knitr)
library(tidyr)
library(ggplot2)
library(broom)
library(car)
library(multcomp)
library(compute.es)
library(here)


raw_gold <- read_csv(here::here("data", "goldilocksdata.csv"), na = c("-99", "")) %>%
  clean_names()

tidy_gold <- raw_gold %>% #tidy data set
  dplyr::select(serial, male, minority, deprived, mwbi, ends_with("_wd"), ends_with("_we")) %>%
  gather(key = "key", value = "engagement", -serial, -male, -minority, -deprived, -mwbi) %>%
  separate(key, into = c("pred", "time")) %>%
  mutate(engagement = as.double(engagement),
         pred = as.factor(pred),
         time = as.factor(time))

gold_no_na <- na.omit(tidy_gold) #dataset with na values removed