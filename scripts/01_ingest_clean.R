library(tidyverse)
library(janitor)

# ---------------------------
# STEP 1: Read raw data
# ---------------------------
raw_file <- "data/raw/FieldOfStudyData1920_2021_PP.csv"

fos <- read_csv(raw_file, show_col_types = FALSE) %>%
  clean_names()

# ---------------------------
# STEP 2: Keep only useful columns
# ---------------------------
fos_small <- fos %>%
  select(
    unitid,
    instnm,
    control,
    cipcode,
    cipdesc,
    credlev,
    creddesc,
    ipedscount1,
    ipedscount2,
    earn_mdn_1yr,
    earn_mdn_5yr
  )

# ---------------------------
# STEP 3: Filter to bachelor's degree only
# ---------------------------
fos_small <- fos_small %>%
  filter(creddesc == "Bachelor's Degree")

# ---------------------------
# STEP 4: Convert earnings columns to numeric
# ---------------------------
fos_small <- fos_small %>%
  mutate(
    earnings_1yr = suppressWarnings(as.numeric(earn_mdn_1yr)),
    earnings_5yr = suppressWarnings(as.numeric(earn_mdn_5yr))
  )

# ---------------------------
# STEP 5: Rename columns
# ---------------------------
fos_small <- fos_small %>%
  rename(
    institution_name = instnm,
    institution_type = control,
    major_code = cipcode,
    major_name = cipdesc,
    credential_level = creddesc,
    grad_count = ipedscount1,
    cohort_count = ipedscount2
  )

# ---------------------------
# STEP 6: Keep rows with usable earnings
# We will require at least 5-year earnings
# ---------------------------
fos_clean <- fos_small %>%
  filter(!is.na(earnings_5yr))

# ---------------------------
# STEP 7: Create earnings growth metric
# ---------------------------
fos_clean <- fos_clean %>%
  mutate(
    earnings_growth = earnings_5yr - earnings_1yr,
    earnings_growth_pct = if_else(
      !is.na(earnings_1yr) & earnings_1yr > 0,
      (earnings_5yr - earnings_1yr) / earnings_1yr,
      NA_real_
    )
  )

# ---------------------------
# STEP 8: Quick checks
# ---------------------------
cat("Rows after cleaning:", nrow(fos_clean), "\n")
cat("Columns after cleaning:", ncol(fos_clean), "\n\n")

print(head(fos_clean))

# ---------------------------
# STEP 9: Save cleaned dataset
# ---------------------------
write_csv(fos_clean, "data/processed/fos_clean.csv")

cat("\nSaved cleaned dataset to data/processed/fos_clean.csv\n")
