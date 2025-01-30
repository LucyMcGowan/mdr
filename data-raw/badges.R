library(tidyverse)

badges <- read_csv("data-raw/badges.csv")
badges <- badges |>
  mutate(id_numeric = as.numeric(gsub("-","", id)))

ggplot(badges, aes(x = id_numeric, y = id_numeric)) +
  geom_point() +
  scale_y_continuous(breaks = badges$id_numeric,
                     labels = badges$name) +
  scale_x_continuous(breaks = badges$id_numeric,
                     labels = function(x) glue::glue("08-{substr(x, 2, 4)}")) +
  labs(x = "employee code", y = "") +
  annotate("segment", x = 8880, xend = 8880,
           y = 8927, yend = 8988, size = 1,
           arrow = arrow(length = unit(0.01, "npc"), ends = "both"),
           color = "green") +
  annotate("text", x = 8880, y = 8999,
           label = "~2 years", size = 5,
           color = "green",
           vjust = 0) +
  theme_mdr() +
  theme(
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1))

usethis::use_data(badges, overwrite = TRUE)
