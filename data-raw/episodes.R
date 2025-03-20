library(tidyverse)
episodes <- read_csv("data-raw/episodes.csv")
usethis::use_data(episodes, overwrite = TRUE)
