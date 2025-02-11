library(tidyverse)
library(mdr)


clean_transcript <- function(file, season, episode) {
  transcript_text <- str_c(read_lines(file), collapse = " ")

  cleaned_text <- str_remove_all(transcript_text, "<.*?>")
  cleaned_text <- str_remove_all(cleaned_text, "\\{\\{tag>Transcripts\\}\\}")

  timestamps <- str_extract_all(cleaned_text, "\\d{2}:\\d{2}:\\d{2}")[[1]]

  dialogues <- str_split(cleaned_text, "\\d{2}:\\d{2}:\\d{2}")[[1]][-1]

  speakers <- str_trim(str_extract(dialogues, "^[^:]+(?=:)"))
  texts <- str_trim(str_remove(dialogues, "^[^:]+:"))

  tibble(
    season = as.integer(season),
    episode = as.integer(episode),
    timestamp = hms::as_hms(timestamps),
    speaker = speakers,
    dialogue = texts
  )
}

## Add S2E4

transcripts <- bind_rows(transcripts,
                         clean_transcript("data-raw/s2e4_transcript.txt", 2, 4))

usethis::use_data(transcripts, overwrite = TRUE)
