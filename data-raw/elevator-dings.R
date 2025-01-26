library(tidyverse)
elevator_dings <- read_csv("data-raw/elevator-dings.csv")
usethis::use_data(elevator_dings, overwrite = TRUE)



