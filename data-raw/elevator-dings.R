library(tidyverse)
elevator_dings <- read_csv("data-raw/elevator-dings.csv")
elevator_dings |>
  mutate(action = case_when(
    action %in% c("enters", "exits") ~ "elevator opens",
    .default = action
  ))
usethis::use_data(elevator_dings, overwrite = TRUE)



