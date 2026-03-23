<<<<<<< HEAD
library(tidyverse)
fos_clean <- read_csv("data/processed/fos_clean.csv", show_col_types = FALSE)

# ---------------------------
# STEP 2: Filter Texas schools
# ---------------------------
texas_data <- fos_clean %>%
  filter(str_detect(institution_name, "Texas"))

# If that returns too few schools, use state code method:
# (Only if needed later)

# ---------------------------
# STEP 3: Major-level summary (Texas only)
# ---------------------------
texas_summary <- texas_data %>%
  group_by(major_name) %>%
  summarise(
    median_earnings_5yr = median(earnings_5yr, na.rm = TRUE),
    median_growth = median(earnings_growth, na.rm = TRUE),
    school_count = n(),
    .groups = "drop"
  ) %>%
  filter(school_count >= 3)

# ---------------------------
# STEP 4: Save
# ---------------------------
write_csv(texas_summary, "data/processed/texas_summary.csv")

cat("Texas summary saved.\n")
=======
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
>>>>>>> a006e27dcb2edda5e4517a175ab92ae25d995a32
