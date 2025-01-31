library(tidyverse)
library(httr)
library(rvest)

url <- "https://severance.wiki/list_of_severance_episodes"
response <- GET(url)

urls <- content(response, "text") |>
  read_html() |>
  html_nodes("a.wikilink1") |>
  (function(x) x[grepl("\\(transcript\\)", html_text(x))])() |>
  html_attr("href")

urls <- glue::glue("https://severance.wiki{urls}")

get_transcript_data <- function(url) {
  response <- GET(url)
  content <- read_html(response)

  transcript_text <- content |>
    html_nodes("div.wrap_script.plugin_wrap") |>
    html_text()

  episode <- content |>
    html_nodes("td.col1") |>
    `[`(_, 1) |>
    html_text() |>
    as.numeric()


  extract_transcript_data <- function(text) {
    text %>%
      str_split("\n\n\n\n", simplify = TRUE) |>
      map_dfr(~ {
        parts <- str_split(.x, "\n")[[1]]

        tibble(
          timestamp = parts[1],
          speaker = str_extract(parts[2], "^[^:]+"),
          dialogue = str_extract(parts[2], "(?<=: ).*$")
        ) |>
          filter(!is.na(dialogue)) |>
          mutate(timestamp = hms::as_hms(timestamp))
      })
  }

  transcript_df <- extract_transcript_data(transcript_text)
  transcript_df$episode <- episode
  transcript_df
}

transcripts <- map_dfr(urls, get_transcript_data)
transcripts <- transcripts |>
  mutate(season = floor(episode),
         episode =  as.numeric(episode %% 1 * 10)
  ) |>
  select(season, episode, timestamp, speaker, dialogue)

usethis::use_data(transcripts, overwrite = TRUE)
