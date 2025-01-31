library(tidyverse)

badges <- read_csv("data-raw/badges.csv")

badges <- badges |>
  mutate(id_numeric = as.numeric(gsub("-", "", id)),
         joined_predicted = lm(joined ~ I(id_numeric^30), badges) |>
           predict(newdata = badges) * 365,
         joined = joined * 365) |>
  arrange(id_numeric)

usethis::use_data(badges, overwrite = TRUE)
