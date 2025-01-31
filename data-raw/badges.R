library(tidyverse)

badges <- read_csv("data-raw/badges.csv")

badges <- badges |>
  mutate(id_numeric = as.numeric(gsub("-", "", id)),
         joined_predicted = lm(joined ~ I(id_numeric^30), badges) |>
           predict(newdata = badges) * 365,
         joined = joined * 365) |>
  arrange(id_numeric)

preds <- tibble(id_numeric = 8039:8988)
preds$joined_predicted <- lm(joined ~ I(id_numeric^30), badges) |>
  predict(newdata = preds)
ggplot(badges, aes(x = id_numeric, y = joined_predicted)) +
  geom_point() +
  geom_line(data = preds, aes(y = joined_predicted), color = "white", linetype = "dashed") +  # Add the dashed line
  scale_y_continuous(
    breaks = badges$joined_predicted,
    labels = badges$name[order(badges$joined_predicted, decreasing = TRUE)],
    sec.axis = sec_axis(~ ., breaks = badges$joined_predicted, labels = round(badges$joined_predicted / 365, 1), name = "Predicted Start (Years Ago)")
  ) +
  scale_x_continuous(
    breaks = badges$id_numeric,
    labels = function(x) glue::glue("08-{substr(x, 2, 4)}")
  ) +
  labs(x = "Employee Code", y = "") +
  annotate("label", x = 8907, y = 365*2,
           size = 3,
           label = "~2 years\nsource: S1E1 (40:39)",
           hjust = 1) +
  annotate("label", x = 8430, y = 365*9,
           size = 3,
           label = "~9 years\nsource: Linkedin",
           hjust = 1) +
  theme_mdr() +
  theme(
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

usethis::use_data(badges, overwrite = TRUE)

usethis::use_data(badges, overwrite = TRUE)
