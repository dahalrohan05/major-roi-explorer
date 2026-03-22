library(tidyverse)
fos_clean <- read_csv("data/processed/fos_clean.csv", show_col_types = FALSE)


# Filter Texas schools
texas_data <- fos_clean %>%
  filter(str_detect(institution_name, "Texas"))


# Major-level summary (Texas only)
texas_summary <- texas_data %>%
  group_by(major_name) %>%
  summarise(
    median_earnings_5yr = median(earnings_5yr, na.rm = TRUE),
    median_growth = median(earnings_growth, na.rm = TRUE),
    school_count = n(),
    .groups = "drop"
  ) %>%
  filter(school_count >= 3)

write_csv(texas_summary, "data/processed/texas_summary.csv")

cat("Texas summary saved.\n")
