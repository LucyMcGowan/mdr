library(stringr)

transcript_text <- str_c(read_lines("data-raw/s2e1_transcript.txt"), collapse = " ")

cleaned_text <- str_remove_all(transcript_text, "<.*?>")
cleaned_text <- str_remove_all(cleaned_text, "\\{\\{tag>Transcripts\\}\\}")

timestamps <- str_extract_all(cleaned_text, "\\d{2}:\\d{2}:\\d{2}")[[1]]

dialogues <- str_split(cleaned_text, "\\d{2}:\\d{2}:\\d{2}")[[1]][-1]

speakers <- str_trim(str_extract(dialogues, "^[^:]+(?=:)"))
texts <- str_trim(str_remove(dialogues, "^[^:]+:"))

s2e1_transcript <- data.frame(
  timestamp = timestamps,
  speaker = speakers,
  text = texts,
  stringsAsFactors = FALSE
)


usethis::use_data(s2e1_transcript, overwrite = TRUE)
